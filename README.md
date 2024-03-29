
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mojchart

<!-- badges: start -->
<!-- badges: end -->

mojchart is an R package to help with formatting charts in ggplot2. It
includes a theme function based on [Government Analysis Function
guidance](https://analysisfunction.civilservice.gov.uk/policy-store/data-visualisation-charts/)
and colour palettes based on both [MoJ corporate
branding](https://intranet.justice.gov.uk/guidance/communications/branding-templates/)
(MoJ internal link) and Government Analysis Function guidance on
[colours for data
visualisation](https://analysisfunction.civilservice.gov.uk/policy-store/data-visualisation-colours-in-charts/).

## Installation

You can install mojchart with:

``` r
install.packages("devtools")
devtools::install_github("moj-analytical-services/mojchart")
```

## Overview

The package provides the following custom ggplot2 functions:  

-   `theme_gss()` - a theme based on Government Analysis Function
    guidance;  
-   `scale_colour_moj()` and `scale_fill_moj()` for applying mojchart
    colour palettes.

To access the package colour palettes without using the scale
functions:  

-   `moj_palette()` returns a colour palette as a vector of colour hex
    codes.  

To obtain the hex codes for individual colours:  

-   `moj_colours()` provides MoJ corporate colours;  
-   `govanal_colours()` provides colours from the Government Analysis
    Function colour palettes  
-   `palette_colours()` provides the colours used in the mojchart colour
    palettes.  

To display colour palettes:

-   `display_palette()` displays a vector of colour hex codes;
-   `display_scheme()` displays all the colour palettes within an
    mojchart colour scheme.

The function help pages (accessed using `?` or `help()` in RStudio)
contain full details and examples.

## Theme function

The main principle behind the theme function `theme_gss()` is to
simplify the chart and remove unecessary formatting. The theme allows
for a main title plus a subtitle for statistical details. The data
source can be shown in the caption below the chart.

Axis labels should be horizontal according to the [Analysis Function
guidance](https://analysisfunction.civilservice.gov.uk/policy-store/data-visualisation-charts/#section-7)
To that end, `theme_gss()` suppresses the ggplot2 y axis label; a label
can instead be included within the ggplot2 subtitle if required. This is
demonstrated by [example 2](#example-2-grouped-bar-chart) below.

`theme_gss()` includes parameters to show or hide the x axis label and x
axis tick marks. Setting the parameter `flipped = TRUE` reverses the x
and y axes for use with `coord_flip()`.

Note that the name `theme_gss()` is because the Analysis Function
Guidance was previously provided by the Government Statistical Service
(GSS).

## Colour palettes

The package provides colour palettes for discrete data, grouped into
several colour schemes. Each colour scheme consists of six colour
palettes, containing from one to six colours. Note that the [Analysis
Function
guidance](https://analysisfunction.civilservice.gov.uk/policy-store/data-visualisation-colours-in-charts/#section-5)
recommends aiming for a maximum of four colours on a chart to avoid the
chart becomming too cluttered.

The Analysis Function colour palettes are taken from the [Analysis
Function
guidance](https://analysisfunction.civilservice.gov.uk/policy-store/data-visualisation-colours-in-charts/#section-4).
There is one colour scheme for bar charts and one for line charts.

For MoJ corporate colours, there are two types of colour scheme: vibrant
and muted. The vibrant schemes use MoJ corporate colours directly. The
muted schemes are based on MoJ colours but with reduced saturation.
Reduced saturation was previously recommended in [Government Statistical
Service
guidance](https://gss.civilservice.gov.uk/policy-store/introduction-to-data-visualisation/#section-9)
for shading areas, such as for bar charts, and might still be
appropriate in some settings.

For sequential colour palettes or continuous data, you could look at the
inbuilt [ggplot2 options](https://ggplot2-book.org/scale-colour.html),
or try the
[colorspace](https://cran.r-project.org/web/packages/colorspace/vignettes/colorspace.html)
package.

`scheme_names()` returns the colour scheme names.

``` r
library(mojchart)
scheme_names()
#> [1] "muted1"        "muted2"        "muted3"        "vibrant1"     
#> [5] "vibrant2"      "govanal_bars"  "govanal_lines"
```

You can use `scale_colour_moj()` or `scale_fill_moj()` to apply a colour
palette to a ggplot2 chart, passing the number of colours and the name
of a colour scheme as arguments. There is an optional `order` parameter
to change the colour order.

To obtain a colour palette as a vector, use `moj_palette()`, again
specifying the number of colours and the colour scheme. The
`display_palette()` function displays the colours.

``` r
pal <- moj_palette(n = 5, scheme = "muted3")
pal
#> mojdarkblue    midblue1       teal2       pink1     yellow1 
#>   "#003057"   "#3975ac"   "#59a6a4"   "#f3bee0"   "#feebb3"
display_palette(pal)
```

<img src="man/figures/README-display_palette-1.png" width="50%" style="display: block; margin: auto;" />

The `display_scheme()` function shows all the colour palettes within a
colour scheme, as shown for every colour scheme
[here](man/additional-documentation/schemes.md).

## Accessing individual colours

`moj_colours()` provides the hex codes for all MoJ corporate colours.
`govanal_colours` provides the Government Analysis Function colours.
`palette_colours()` provides all colours used in the mojchart colour
palettes. Running one of these functions with no arguments returns a
vector containing all of the available colours. Passing the names of
individual colours returns just those.

``` r
moj_colours("mojblue", "mojgreen")
#>   mojblue  mojgreen 
#> "#1d609d" "#30aa51"
```

## Accessibility

See the [Analysis Function
guidance](https://analysisfunction.civilservice.gov.uk/policy-store/data-visualisation-colours-in-charts/)
for a full discussion of accessibility considerations regarding the use
of colour in charts.

The mojchart colour palettes aim to be accessible to those with the most
common forms of colour blindness, but accessibility does decrease the
more colours you use.

Below are two resources to help assess colour blindness accessibility.  

-   To simulate how an image file could appear to individuals with forms
    of colour blindness:  
    <https://www.color-blindness.com/coblis-color-blindness-simulator/>
-   To simulate the appearance of a colour palette of hex codes:  
    <https://davidmathlogic.com/colorblind/>

Note that for line charts, the Analysis Function guidance recommends
labelling lines directly rather than using a separate legend. The
[directlabels](http://directlabels.r-forge.r-project.org/) package
provides one way to implement this in R.

## Examples

The examples below show the use of `theme_gss()`, `scale_colour_moj()`
and `scale_fill_moj()`, together with various ggplot2 functions, to
create fully formatted charts. The data frames for the charts are
produced by two mojchart functions, `familystarts_reduced()` and
`bars()`.

### Example 1: line chart

-   In this example note that the line thickness has been increased in
    `geom_line()` so that the colours stand out more, making the
    categories easier to identify.

``` r
library(mojchart)
library(ggplot2)
library(xts)
library(scales)
ggplot(familystarts_reduced(6), aes(x = year_qtr, y = count, colour = case_type)) +
  geom_line(size = 1.5) +
  labs(title = "Number of cases started in family courts",
       subtitle = "England and Wales, Q1 2011 - Q2 2020",
       caption = "Source: Family court statistics quarterly, April to June 2020 (table 1)") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.05)), label = comma) +
  scale_x_yearqtr(labels = date_format("%Y-Q%q")) +
  expand_limits(y = 0) +
  theme_gss(xticks = TRUE) +
  scale_colour_moj(6, scheme = "vibrant1", order = c(1, 3, 2, 6, 4, 5))
```

![](man/figures/README-example1-1.png)<!-- -->

### Example 2: grouped bar chart

``` r
ggplot(bars(5), aes(x = col1, y = col3, fill = col2)) +
  geom_col(position = position_dodge2(padding = 0), width = 0.8) +
  labs(title = "Example grouped bar chart",
       subtitle = "Additional details here\n\nAxis label",
       caption = "Source") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.05))) +
  expand_limits(y = 10) +
  theme_gss() +
  scale_fill_moj(5, scheme = "muted2")
```

![](man/figures/README-example2-1.png)<!-- -->

### Example 3: horizontal bar chart

``` r
ggplot(bars(3), aes(x = col1, y = col3, fill = col2)) +
  geom_col(position = "dodge", width = 0.7) +
  coord_flip() +
  labs(title = "Example horizontal bar chart",
       subtitle = "Additional details here\n",
       caption = "Source",
       y = "Axis label") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.05))) +
  expand_limits(y = 10) +
  guides(fill = guide_legend(reverse = TRUE)) +
  theme_gss(flipped = TRUE, xlabel = TRUE) +
  scale_fill_moj(3, scheme = "govanal_bars")
```

![](man/figures/README-example3-1.png)<!-- -->
