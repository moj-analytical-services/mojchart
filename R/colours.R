#' MoJ colours
#'
#' Provides names and hex codes for MoJ corporate colours. Calling the function
#' with no arguments returns every colour. If the names of specific colours are
#' passed as arguments, the function returns those colours alone.
#'
#' @param ... Colour names as character strings.
#' @return Returns a named character vector.
#' @family available colours
#' @seealso MoJ branding intranet page:
#'   \url{https://intranet.justice.gov.uk/guidance/communications/branding-templates/}
#' @export
#' @examples
#' # All colours
#' moj_colours()
#'
#' # Selected colours
#' moj_colours("mojblue", "mojgreen")
moj_colours <- function(...){

  colours <- c(
    mojblue = "#1d609d",
    mojbrightblue = "#00b1eb",
    mojdarkblue = "#003057",

    mojblack = "#1d1d1b",

    mojgreen = "#30aa51",
    mojbrightgreen = "#afcc46",
    mojdarkgreen = "#214a35",

    mojpink = "#e9426d",
    mojbrightpink = "#e98dc7",
    mojdarkpink = "#810b20",

    mojpurple = "#565b96",
    mojbrightpurple = "#a68ec2",
    mojdarkpurple = "#311d67",

    mojteal = "#00a5a1",
    mojbrightteal = "#00e0c5",
    mojdarkteal = "#276160",

    mojorange = "#ee7127",
    mojbrightorange = "#fece43",
    mojdarkorange = "#7b3318",

    mojgrey = "#a0a5b4",
    mojbrightgrey = "#ced2dc",
    mojdarkgrey = "#2a363b"
  )

  subset_colours(colours, fun = "moj_colours", ...)
}

#' Palette colours
#'
#' Provides names and hex codes for colours used in the mojchart palettes. If
#' colour names are passed as arguments, returns those colours. If no arguments
#' are provided, returns every colour.
#'
#' @param ... Colour names as character strings.
#' @return Returns a named character vector.
#' @family available colours
#' @export
#' @examples
#' # All colours
#' palette_colours()
#'
#' # Selected colours
#' palette_colours("mojblue", "yellow1")
palette_colours <- function(...){

  colours <- c(

    # MoJ colours for vibrant palettes (good for line charts)
    mojblue = "#1d609d",
    mojbrightblue = "#00b1eb",
    mojdarkblue = "#003057",
    mojgreen = "#30aa51",
    mojbrightorange = "#fece43",
    mojgrey = "#a0a5b4",
    mojpink = "#e9426d",

    # Colours for muted palettes (good for bar charts)
    midblue1 = "#3975ac",
    lightblue1 = "#81cbe4",
    paleblue1 = "#c9e4ed",
    teal1 = "#70c2c0",
    teal2 = "#59a6a4",
    yellow1 = "#feebb3",
    yellow2 = "#fde59b",
    pink1 = "#f3bee0",

    # Government Analysis Function colours
    # https://analysisfunction.civilservice.gov.uk/policy-store/data-visualisation-colours-in-charts/
    govanal_darkblue = "#12436D",
    govanal_turquoise = "#28A197",
    govanal_darkpink = "#801650",
    govanal_orange = "#F46A25",
    govanal_darkgrey = "#3D3D3D",
    govanal_lightpurple = "#A285D1"
  )

  subset_colours(colours, fun = "palette_colours", ...)
}

#' Subset a vector of colours
#'
#' Returns a subset of a named vector, specified by the element names. If no
#' names are supplied, returns the full vector.
#'
#' @param colour_vector A named character vector to subset.
#' @param fun The name of the function that calls subset_colours(), as a
#'   character string. Used in the error message for an invalid colour name.
#' @param ... Colour names as character strings.
#' @return Returns a named character vector.
#' @noRd
#' @examples
#' x <- c(colour1 = "#1d609d", colour2 = "#00b1eb")
#' subset_colours(x, "colour2")
subset_colours <- function(colour_vector, fun = NULL, ...){

  names_provided <- c(...)

  # Check names provided are valid colours
  names_allowed <- names(colour_vector)

  for (value in names_provided){
    if (!value %in% names_allowed){
      message <- glue::glue('"{value}" is not a valid colour name. To see all available colours, run {fun}().')
      rlang::abort(message = message)
    }
  }

  if(is.null(names_provided))
    return(colour_vector)

  colour_vector[names_provided]
}
