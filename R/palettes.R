# Palettes (for up to 6 colours)
palettes <- list(
  muted1 = list(
    palette_colours("mojblue"),
    palette_colours("mojblue", "lightblue1"),
    palette_colours("mojblue", "lightblue1", "paleblue1"),
    palette_colours("mojdarkblue", "midblue1", "lightblue1", "paleblue1"),
    palette_colours("mojdarkblue", "midblue1", "teal2", "lightblue1", "paleblue1"),
    palette_colours("mojdarkblue", "midblue1", "teal2", "lightblue1", "yellow1", "paleblue1")
  ),
  muted2 = list(
    palette_colours("mojblue"),
    palette_colours("mojblue", "lightblue1"),
    palette_colours("mojblue", "teal1", "yellow1"),
    palette_colours("mojdarkblue", "midblue1", "teal1", "yellow1"),
    palette_colours("mojdarkblue", "midblue1", "teal2", "lightblue1", "yellow1"),
    palette_colours("mojdarkblue", "midblue1", "teal2", "lightblue1", "yellow1", "paleblue1")
  ),
  muted3 = list(
    palette_colours("mojblue"),
    palette_colours("mojblue", "yellow2"),
    palette_colours("mojblue", "teal2", "yellow2"),
    palette_colours("mojblue", "teal2", "pink1", "yellow1"),
    palette_colours("mojdarkblue", "midblue1", "teal2", "pink1", "yellow1"),
    palette_colours("mojdarkblue", "midblue1", "teal2", "lightblue1", "pink1", "yellow1")
  ),
  vibrant1 = list(
    palette_colours("mojblue"),
    palette_colours("mojblue", "mojbrightblue"),
    palette_colours("mojblue", "mojbrightblue", "mojgrey"),
    palette_colours("mojblue", "mojbrightblue", "mojgrey", "mojbrightorange"),
    palette_colours("mojblue", "mojbrightblue", "mojgrey", "mojbrightorange", "mojgreen"),
    palette_colours("mojblue", "mojbrightblue", "mojgrey", "mojbrightorange", "mojgreen", "mojpink")
  ),
  vibrant2 = list(
    palette_colours("mojblue"),
    palette_colours("mojblue", "mojbrightblue"),
    palette_colours("mojblue", "mojbrightblue", "mojbrightorange"),
    palette_colours("mojblue", "mojbrightblue", "mojbrightorange", "mojgreen"),
    palette_colours("mojblue", "mojbrightblue", "mojbrightorange", "mojgreen", "mojpink"),
    palette_colours("mojblue", "mojbrightblue", "mojbrightorange", "mojgreen", "mojpink", "mojgrey")
  )
)

#' mojchart colour palette
#'
#' Returns an mojchart colour palette as a named character vector.
#'
#' @param n The required number of colours in the palette, from one to six.
#' @param scheme The name of a colour scheme as a character string. Run
#'   `scheme_names()` for the available options.
#' @export
#' @examples
#' mojchart_palette(5, scheme = "vibrant1")
mojchart_palette <- function(n, scheme){

  # Check n is an integer
  if (n != as.integer(n))
    stop("n must be an integer.", call. = FALSE)

  # Check n is within range
  if (n < 1 | n > 6){
    stop("n must be between 1 and 6.", call. = FALSE)
  }

  # Check scheme name is valid
  if (!scheme %in% names(palettes)){
    message <- glue::glue('"{scheme}" is not a valid scheme name. The available schemes are: {paste(scheme_names(), collapse = " ")}.')
    rlang::abort(message = message)
  }

  palettes[[scheme]][[n]]
}

#' Names of available palettes
#'
#' Returns the names of all mojchart palettes.
#'
#' @export
scheme_names <- function(){
  names(palettes)
}

#' Reorder a palette
#'
#' Rearranges the elements of a vector. Intended for reordering a palette.
#'
#' @param x A vector to be reordered.
#' @param order A numeric vector containing the desired order. Must be the same
#'   length as `x` and can only contain numbers that correspond to elements of
#'   `x`. Numbers can be repeated, which when applied to a chart will give the
#'   same colour to multiple categories in the data.
#' @return Returns the reordered vector.
#' @noRd
#' @examples
#' pal <- c("#1d609d", "#00b1eb", "#003057")
#' reorder_palette(pal, order = c(2, 1, 3))
#' reorder_palette(pal, order = c(1, 2, 2))
reorder_palette <- function(x, order){

  # Check order vector is the correct length.
  if (length(x) != length(order))
    stop("Palette and order vector have different lengths.")

  allowed_values <- 1:length(x)

  # Check all elements of order are within range.
  for (value in order){
    if (!value %in% allowed_values){
      message <- glue::glue("`order` cannot contain {value} for a palette of length {length(x)}.")
      rlang::abort(message = message)
    }
  }

  x[order]
}
