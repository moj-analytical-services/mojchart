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
#' create_moj_scale(5, scheme = "vibrant1", scale_function = scale_colour_manual)
create_moj_scale <- function(n, scheme, order = NULL, scale_function, ...){

  # Check n is an integer
  if (n != as.integer(n))
    stop("n must be an integer.")

  # Check n is within range
  if (n < 1 | n > 6){
    stop("n must be between 1 and 6.")
  }

  # Check scheme name is valid
  if (!scheme %in% names(palettes)){
    message <- glue::glue('"{scheme}" is not a valid scheme name. The available schemes are: {paste(scheme_names(), collapse = " ")}.')
    rlang::abort(message = message)
  }

  # Set default order
  if (is.null(order))
    order <- 1:n

  palette_neworder <- reorder_palette(palettes[[scheme]][[n]], order)

  scale_function(values = unname(palette_neworder), ...)
}

#' Scale functions for ggplot2
#'
#' Scale functions to add mojchart palettes to charts.
#'
#' @param n The number of colours required, from one to six.
#' @param scheme The name of an mojchart scheme. Run `scheme_names()` for
#'   the available options. "Muted" schemes are generally recommended for the
#'   fill scale and "vibrant" schemes for the colour scale.
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
#'   scale_colour_moj(n = 6, scheme = "vibrant1")
#'
#' library(ggplot2)
#' ggplot(bars(3), aes(x = col1, y = col3, fill = col2)) +
#'   geom_col() +
#'   scale_fill_moj(n = 3, scheme = "muted2")
NULL

#' @rdname scales
#' @importFrom ggplot2 scale_colour_manual
#' @export
scale_colour_moj <- function(n, scheme = "vibrant1", order = NULL, ...){
  create_moj_scale(n, scheme, order, scale_function = scale_colour_manual, ...)
}

#' @rdname scales
#' @importFrom ggplot2 scale_fill_manual
#' @export
scale_fill_moj <- function(n, scheme = "muted1", order = NULL, ...){
  create_moj_scale(n, scheme, order, scale_function = scale_fill_manual, ...)
}
