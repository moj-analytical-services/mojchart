#' Swatch plot
#'
#' Preview a vector of colours.
#'
#' @param colours A character vector of colours.
#' @export
#' @examples
#' swatch(c("#039BE5", "#E91E63", "#FFB300"))
#' swatch(mojchart_palette(4, scheme = "muted1"))
#' swatch(moj_colours())
swatch <- function(colours){

  df <- dplyr::tibble(x = factor(1:length(colours)), y = 1)

  ggplot2::ggplot(df, ggplot2::aes(x = .data$x, y = .data$y, fill = .data$x)) +
    ggplot2::geom_col() +
    ggplot2::coord_flip() +
    ggplot2::theme_void(base_size = 13) +
    ggplot2::theme(legend.position = "none",
          axis.text.y = ggplot2::element_text(),
          plot.margin = ggplot2::unit(c(10, 10, 10, 10), "pt")) +
    ggplot2::scale_fill_manual(values = unname(colours)) +
    ggplot2::scale_x_discrete(labels = unname(colours)) +
    ggplot2::scale_y_continuous(expand = ggplot2::expansion(mult = 0.02))
}

#' Swatch plot for a full colour scheme
#'
#' Preview all the palettes contained within an mojchart colour scheme.
#'
#' @param scheme The name of an mojchart colour scheme. Run `scheme_names()` for
#'   the available options.
#' @export
#' @examples
#' multiswatch("vibrant1")
multiswatch <- function(scheme){

  # Add an NA element to each palette vector for spacing in the plot
  palette_blank_rows <- lapply(palettes[[scheme]], c, NA)

  allcolour_vector <- unlist(palette_blank_rows)
  na_index <- (is.na(allcolour_vector))

  # Create data frame for the plot with y = 0 for rows that need to be blank
  df <- dplyr::tibble(x = factor(1:length(allcolour_vector)), y = 1)
  df$y[na_index] <- 0

  labels <- allcolour_vector
  labels[na_index] <- ""

  ggplot2::ggplot(df, ggplot2::aes(x = .data$x, y = .data$y, fill = .data$x)) +
    ggplot2::geom_col() +
    ggplot2::coord_flip() +
    ggplot2::theme_void() +
    ggplot2::theme(legend.position = "none",
                   axis.text.y = ggplot2::element_text(),
                   plot.margin = ggplot2::unit(c(10, 10, 10, 10), "pt")) +
    ggplot2::scale_fill_manual(values = unname(allcolour_vector)) +
    ggplot2::scale_y_continuous(expand = ggplot2::expansion(mult = 0.02)) +
    ggplot2::scale_x_discrete(labels = unname(labels))
}
