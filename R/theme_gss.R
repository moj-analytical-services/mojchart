#' GSS style theme
#'
#' A theme based on Government Statistical Service (GSS) guidance.\cr
#' \url{https://gss.civilservice.gov.uk/policy-store/introduction-to-data-visualisation/}
#'
#' @param base_size The base font size for chart text. For publication charts on
#'   gov.uk, it is useful to use a larger size, around size 20. For details of
#'   what this parameter does, see
#'   \url{https://ggplot2-book.org/polishing.html}.
#' @param base_line_size The base size for lines controlled by the theme
#'   function (i.e. non-data lines).
#' @param flipped A logical value indicating whether the chart has flipped axes.
#' @param xticks A logical value indicating whether to add tick marks to the x
#'   axis. Only adds ticks if `flipped = FALSE`.
#' @param xlabel A logical value indicating whether to show the x axis label.
#' @importFrom ggplot2 theme
#' @importFrom ggplot2 element_text
#' @importFrom ggplot2 element_line
#' @importFrom ggplot2 element_blank
#' @importFrom ggplot2 margin
#' @importFrom ggplot2 unit
#' @importFrom ggplot2 theme_grey
#' @importFrom ggplot2 ggplot
#' @return Returns a ggplot2 theme function.
#' @export
#' @examples
#' library(ggplot2)
#' ggplot(familystarts, aes(x = year_qtr, y = count, colour = case_type)) +
#'   geom_line(size = 1.5) +
#'   labs(title = "Number of cases started in family courts",
#'        subtitle = "England and Wales, Q1 2011 - Q2 2020",
#'        caption = "Source: Family court statistics quarterly, April to June 2020 (table 1)") +
#'   theme_gss(base_size = 18)
theme_gss <- function(base_size = 11, base_line_size = 0.5, flipped = FALSE, xticks = FALSE, xlabel = FALSE){

  # Base theme object
  base_elements <- theme_grey(base_size = base_size, base_line_size = base_line_size) +
    theme(line = element_line(colour = "grey80"),
          panel.grid = element_blank(),
          axis.ticks = element_blank(),
          axis.ticks.length = unit(0.5, "lines"),
          axis.title = element_blank(),
          panel.background = element_blank(),
          legend.title = element_blank(),
          legend.key = element_blank(),
          legend.key.size = unit(1.5, "lines"),
          plot.title = element_text(face = "bold"),
          plot.subtitle = element_text(margin = margin(b = 10)),
          plot.caption = element_text(hjust = 0, margin = margin(t = 10)),
          plot.title.position = "plot",
          plot.caption.position = "plot",
          panel.spacing = unit(1, "lines"),
          strip.background = element_blank(),
          strip.text = element_text(face = "bold")
    )

  # To add for regular orientation
  regular_elements <- theme(
    panel.grid.major.y = element_line(),
    axis.line.x = element_line()
  )

  # To add for flipped orientation
  flipped_elements <- theme(
    panel.grid.major.x = element_line(),
    axis.line.y = element_line(),
    axis.title = element_blank(),
    axis.text.y = element_text(margin = margin(r = 10))
  )

  # To add x axis ticks
  xticks_element <- theme(
    axis.ticks.x = element_line()
  )

  # To add x axis label
  xlabel_element <- theme(
    axis.title.x = element_text(margin = margin(t = 10))
  )

  # Build final theme
  if (!flipped) {
    t <- base_elements +
      regular_elements
  } else {
    t <- base_elements +
      flipped_elements
  }

  if (!flipped && xticks)
    t <- t +
      xticks_element

  if (xlabel)
    t <- t +
      xlabel_element

  t
}
