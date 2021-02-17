#' Select case types from familystarts
#'
#' Selects a given number of case types from the familystarts dataset.
#'
#' @param n The number of case types required, from one to six.
#' @return Returns a vector of case types.
#' @noRd
#' @examples
#' select_familystart_categories(4)
select_familystart_categories <- function(n){
  if (n == 6) {
    c("Children Act - public law", "Children Act - private law", "Matrimonial matters", "Financial remedies", "Domestic violence remedy orders", "All Adoption Act")
  } else if (n == 5) {
    c("Children Act - public law", "Children Act - private law", "Financial remedies", "Domestic violence remedy orders", "All Adoption Act")
  } else if (n == 4) {
    c("Children Act - public law", "Financial remedies", "Domestic violence remedy orders", "All Adoption Act")
  } else if (n == 3) {
    c("Children Act - public law", "Domestic violence remedy orders", "All Adoption Act")
  } else if (n == 2) {
    c("Children Act - private law", "Financial remedies")
  } else if (n == 1){
    "Total cases started"
  }
}

#' Reduce familystarts
#'
#' Reduces the familystarts dataset to a given number of case types, from one to
#' six. Intended for creating example line charts.
#'
#' @param n The number of case types required, from one to six.
#' @importFrom dplyr %>%
#' @importFrom rlang .data
#' @return Returns the filtered data frame.
#' @export
#' @examples
#' familystarts_reduced(4)
familystarts_reduced <- function(n = 6){

  if (!n %in% 1:6)
    stop("The number of categories must be between 1 and 6.", call. = FALSE)

  categories <- select_familystart_categories(n)

  mojchart::familystarts %>%
    dplyr::filter(.data$case_type %in% categories)
}

#' Select categories for an example bar chart
#'
#' Returns the names of a given number of categories from the example bar chart
#' data frame.
#'
#' @param n The number of categories required, from one to six.
#' @return Returns a vector of category names.
#' @noRd
#' @examples
#' select_bar_categories(3)
select_bar_categories <- function(n){
  if (n == 5) {
    c("Category 1", "Category 2", "Category 3", "Category 4", "Category 5")
  } else if (n == 4) {
    c("Category 1", "Category 2", "Category 3", "Category 4")
  } else if (n == 3) {
    c("Category 1", "Category 2", "Category 3")
  } else if (n == 2) {
    c("Category 1", "Category 2")
  }
}

#' Data frame for an example bar chart
#'
#' Creates a data frame that can be used for an example bar chart.
#'
#' @param n The number of categories in column `col2`, which is intended to be
#'   mapped to the fill aesthetic of the plot. Must be from one to six.
#' @importFrom dplyr %>%
#' @importFrom rlang .data
#' @return Returns a data frame with the specified number of categories in `col2`.
#' @export
#' @examples
#' bars(3)
bars <- function(n){

  if (!n %in% 1:6)
    stop("The number of categories must be between 1 and 6.", call. = FALSE)

  bars_df <- dplyr::tibble(col1 = c(rep("A", 6), rep("B", 6), rep("C", 6)),
                           col2 = factor(rep(c("Category 1", "Category 2", "Category 3", "Category 4", "Category 5", "Category 6"), 3)),
                           col3 = (c(9.5, 8, 6, 7, 9, 5,
                                     2, 5, 3, 2, 1, 3,
                                     2, 3, 7, 4, 6, 3.5))
  )

  one_bar <- dplyr::tibble(x = c("A", "B", "C"), y = c(8, 10, 6))

  categories <- select_bar_categories(n)

  if (n == 6) {
    bars_df
  } else if (n > 1 & n <=5) {
    bars_df %>%
      dplyr::filter(.data$col2 %in% categories)
  } else if (n == 1) {
    one_bar
  }
}
