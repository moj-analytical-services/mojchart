#' Display a palette
#'
#' Displays a vector of colours.
#'
#' @param x A character vector of colours.
#' @export
#' @examples
#' display_palette(c("#039BE5", "#E91E63", "#FFB300"))
#' display_palette(mojchart_palette(4, scheme = "muted1"))
#' display_palette(moj_colours())
display_palette <- function(x){

  df <- dplyr::tibble(x = factor(1:length(x)), y = 1)

  ggplot2::ggplot(df, ggplot2::aes(x = .data$x, y = .data$y, fill = .data$x)) +
    ggplot2::geom_col() +
    ggplot2::coord_flip() +
    ggplot2::theme_void(base_size = 13) +
    ggplot2::theme(legend.position = "none",
          axis.text.y = ggplot2::element_text(),
          plot.margin = ggplot2::unit(c(10, 10, 10, 10), "pt")) +
    ggplot2::scale_fill_manual(values = unname(x)) +
    ggplot2::scale_x_discrete(labels = unname(x)) +
    ggplot2::scale_y_continuous(expand = ggplot2::expansion(mult = 0.02))
}

#' Display a colour scheme
#'
#' Preview all the palettes contained within an mojchart colour scheme.
#'
#' @param scheme The name of an mojchart colour scheme. Run `scheme_names()` for
#'   the available options.
#' @export
#' @examples
#' display_scheme("vibrant1")
display_scheme <- function(scheme){

  # Check scheme name is valid
  if (!scheme %in% names(palettes())){
    scheme_names_as_string <- paste(scheme_names(), collapse = '", "')
    message <- glue::glue('"{scheme}" is not a valid scheme name. The available schemes are: "{scheme_names_as_string}".')
    rlang::abort(message = message)
  }

  # Add an NA element to each palette vector for spacing in the plot
  palette_blank_rows <- lapply(palettes()[[scheme]], c, NA)

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

#' Display a palette
#'
#' RENAMED: please use `display_palette()` instead.
#'
#' @param ... Arguments passed to `display_palette()`.
#' @export
#' @examples
#' swatch(moj_colours())
swatch <- function(...){

  warning("swatch() has been renamed as display_palette() and will be removed in the future.", call. = FALSE)

  display_palette(...)
}

#' Display a colour scheme
#'
#' RENAMED: please use `display_scheme()` instead.
#'
#' @param ... Arguments passed to `display_scheme()`.
#' @export
#' @examples
#' multiswatch("vibrant1")
multiswatch <- function(...){

  warning("multiswatch() has been renamed as display_scheme() and will be removed in the future.", call. = FALSE)

  display_scheme(...)
}
