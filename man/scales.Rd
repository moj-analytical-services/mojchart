% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/scales.R
\name{scales}
\alias{scales}
\alias{scale_colour_moj}
\alias{scale_fill_moj}
\title{ggplot2 scale functions}
\usage{
scale_colour_moj(n, scheme = "vibrant1", order = NULL, ...)

scale_fill_moj(n, scheme = "muted1", order = NULL, ...)
}
\arguments{
\item{n}{The number of colours required, from one to six.}

\item{scheme}{The name of an mojchart colour scheme. Run \code{scheme_names()} for
the available options. "Muted" colour schemes are generally recommended for
the fill scale and "vibrant" colour schemes for the colour scale.}

\item{order}{A numeric vector giving the order in which to apply the colours.
\code{order} must have length \code{n}. Numbers can be repeated to apply the same
colour to multiple categories in the data.}

\item{...}{Other arguments passed to scale_discrete_manual().}
}
\value{
Returns a ggplot2 scale function.
}
\description{
Scale functions for mojchart colour palettes.
}
\examples{
library(ggplot2)
ggplot(familystarts_reduced(6), aes(x = year_qtr, y = count, colour = case_type)) +
  geom_line(size = 1.5) +
  scale_colour_moj(n = 6, scheme = "vibrant1")

library(ggplot2)
ggplot(bars(3), aes(x = col1, y = col3, fill = col2)) +
  geom_col() +
  scale_fill_moj(n = 3, scheme = "muted2")
}
