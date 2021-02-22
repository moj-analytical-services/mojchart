#' Create a ggplot2 scale function for an mojchart palette
#'
#' Generates a discrete scale function using either `scale_colour_manual()` or
#' `scale_fill_manual()`.
#'
#' @inheritParams scales
#' @param scale_function A ggplot2 discrete scale function, either
#'   `scale_colour_manual()` or `scale_fill_manual()`.
#' @return Returns a ggplot2 scale function.
#' @noRd
#' @examples
#' library(ggplot2)
#' create_moj_scale(5, palette = "vibrant1", scale_function = scale_colour_manual)
create_moj_scale <- function(n, palette, order = NULL, scale_function, ...){

  # Check n is an integer
  if (n != as.integer(n))
    stop("n must be an integer.", call. = FALSE)

  # Check n is within range
  if (n < 1 | n > 6){
    stop("n must be between 1 and 6.", call. = FALSE)
  }

  # Check palette name is valid
  if (!palette %in% names(palettes))
    stop("Unrecognised palette.", call. = FALSE)

  # Set default order
  if (is.null(order))
    order <- 1:n

  palette_neworder <- reorder_palette(palettes[[palette]][[n]], order)

  scale_function(values = unname(palette_neworder), ...)
}

#' Scale functions for ggplot2
#'
#' Scale functions to add mojchart palettes to charts.
#'
#' @param n The number of colours required, from one to six.
#' @param palette The name of an mojchart palette. Run `moj_palette_names()` for
#'   the available options. "Muted" palettes are generally recommended for the
#'   fill scale and "vibrant" palettes for the colour scale.
#' @param order A numeric vector giving the order in which to apply the colours.
#'   `order` must have length `n`. Numbers can be repeated to apply the same
#'   colour to multiple categories in the data.
#' @param ... Other arguments passed to the ggplot2 scale function.
#' @return Returns a ggplot2 scale function.
#' @name scales
#' @examples
#' library(ggplot2)
#' ggplot(familystarts_reduced(6), aes(x = year_qtr, y = count, colour = case_type)) +
#'   geom_line(size = 1.5) +
#'   scale_colour_moj(n = 6, palette = "vibrant1")
#'
#' library(ggplot2)
#' ggplot(bars(3), aes(x = col1, y = col3, fill = col2)) +
#'   geom_col() +
#'   scale_fill_moj(n = 3, palette = "muted2")
NULL

#' @rdname scales
#' @importFrom ggplot2 scale_colour_manual
#' @export
scale_colour_moj <- function(n, palette = "vibrant1", order = NULL, ...){
  create_moj_scale(n, palette, order, scale_function = scale_colour_manual, ...)
}

#' @rdname scales
#' @importFrom ggplot2 scale_fill_manual
#' @export
scale_fill_moj <- function(n, palette = "muted1", order = NULL, ...){
  create_moj_scale(n, palette, order, scale_function = scale_fill_manual, ...)
}
