#' @import htmlwidgets
#' @export
responsiveGuide <- function(
    variables,
    color_scale = NULL,
    manual_colors = NULL,
    ramp_levels = 100,
    title = NULL,
    direction = "column",
    focused = NULL,
    width = NULL,
    height = NULL,
    ...
) {

  if (is.null(scale) & is.null(manual_colors)) {
    stop("You must provide either a color scale or manual colors")
  }

  # check if variables is continuous or discrete
  if (is.numeric(variables)) {
    scale <- "continuous"
    breaks <- pretty(variables, n = 3)
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
  shinyWidgetOutput(outputId, "ResponsiveGuides", width, height, package = "ResponsiveGuides")
}
#' @export
renderResponsiveGuides <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, ResponsiveGuidesOutput, env, quoted = TRUE)
}
