#' Create a ggplot2 scale function for an mojchart palette
#'
#' Generates a discrete scale function for an mojchart palette and a given
#' aesthetic, using `ggplot2::scale_discrete_manual()`.
#'
#' @inheritParams scales
#' @param aesthetics The aesthetic(s) that the scale work with. Passed to the
#'   `aesthetics` parameter of `ggplot2::scale_discrete_manual()`.
#' @return Returns a ggplot2 scale function.
#' @noRd
#' @examples
#' library(ggplot2)
#' create_moj_scale(5, scheme = "vibrant1", aesthetics = "colour")
create_moj_scale <- function(n, scheme, order = NULL, aesthetics, ...){

  # Set default order
  if (is.null(order))
    order <- 1:n

  pal <- mojchart_palette(n, scheme)

  pal_reorder <- reorder_palette(pal, order)

  ggplot2::scale_discrete_manual(aesthetics, values = unname(pal_reorder), ...)
}

#' ggplot2 scale functions
#'
#' Scale functions for mojchart palettes.
#'
#' @param n The number of colours required, from one to six.
#' @param scheme The name of an mojchart colour scheme. Run `scheme_names()` for
#'   the available options. "Muted" schemes are generally recommended for the
#'   fill scale and "vibrant" schemes for the colour scale.
#' @param order A numeric vector giving the order in which to apply the colours.
#'   `order` must have length `n`. Numbers can be repeated to apply the same
#'   colour to multiple categories in the data.
#' @param ... Other arguments passed to scale_discrete_manual().
#' @return Returns a ggplot2 scale function.
#' @name scales
#' @examples
#' library(ggplot2)
#' ggplot(familystarts_reduced(6), aes(x = year_qtr, y = count, colour = case_type)) +
#'   geom_line(size = 1.5) +
#'   scale_colour_moj(n = 6, scheme = "vibrant1")
#'
#' library(ggplot2)
#' ggplot(bars(3), aes(x = col1, y = col3, fill = col2)) +
#'   geom_col() +
#'   scale_fill_moj(n = 3, scheme = "muted2")
NULL

#' @rdname scales
#' @export
scale_colour_moj <- function(n, scheme = "vibrant1", order = NULL, ...){
  create_moj_scale(n, scheme, order, aesthetics = "colour", ...)
}

#' @rdname scales
#' @export
scale_fill_moj <- function(n, scheme = "muted1", order = NULL, ...){
  create_moj_scale(n, scheme, order, aesthetics = "fill", ...)
}
