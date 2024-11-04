#' Responsive Guides - An htmlwidget for displaying plot guides
#'
#' @import htmlwidgets
#'
#' @param variables A vector of values to be displayed. Either continuous or discrete.
#' @param color_scale A color scale to use for the guide. If NULL, manual_colors must be provided.
#' @param manual_colors A named vector of colors to use for the guide. If NULL, color_scale must be provided.
#' @param ramp_levels The number of colors breaks used to display a continuous color ramp.
#' @param title The title of the guide.
#' @param direction The orientation of the guide. Either "row" or "column".
#' @param justify The alignment of the guide. Either "left", "center", or "right".
#' @param focused The value to highlight in the guide, useful if used interactively.
#' @param width The width of the widget.
#' @param height The height of the widget.
#'
#' @export
responsiveGuide <- function(
  variables,
  color_scale = NULL,
  manual_colors = NULL,
  ramp_levels = 100,
  title = NULL,
  direction = "column",
  justify = "center",
  focused = NULL,
  width = NULL,
  height = NULL,
  ...
) {

  if (is.null(scale) && is.null(manual_colors)) {
    stop("You must provide either a color scale or manual colors")
  }

  # check if variables is continuous or discrete
  if (is.numeric(variables)) {
    scale <- "continuous"
    breaks <- round(pretty(variables, n = 2), digits = 3)
  } else {
    scale <- "discrete"
    variables <- as.factor(variables)
    breaks <- levels(variables)
  }

  if (!is.null(manual_colors)) {
    if (scale == "discrete") {
      if (!all(names(manual_colors) %in% breaks)) {
        stop("All levels of the variable must be present in the manual colors")
      }
      colors <- unname(manual_colors[breaks])
    } else if (scale == "continuous") {
      if (length(manual_colors) < 2) {
        stop("At least two colors must be provided for a continuous scale")
      }
      pal <- colorRampPalette(manual_colors)
      colors <- pal(ramp_levels)
    }
  }

  htmlwidgets::createWidget(
    name = "ResponsiveGuides",
    x = list(
      breaks = breaks,
      scale = scale,
      colors = colors,
      direction = direction,
      justify = justify,
      focused = focused,
      title = title
    ),
    width = width,
    height = height,
    package = "ResponsiveGuides"
  )
}


#' @export
ResponsiveGuidesOutput <- function(outputId, width = "100%", height = "400px") {
  htmlwidgets::shinyWidgetOutput(outputId, "ResponsiveGuides", width, height, package = "ResponsiveGuides")
}
#' @export
renderResponsiveGuides <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, ResponsiveGuidesOutput, env, quoted = TRUE)
}
