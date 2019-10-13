# ui.R 
library(shiny)

# Define UI for miles per gallon app 
ui <- fluidPage(

  # App title 
  titlePanel("Miles Per Gallon"),

  sidebarLayout(

    # Sidebar panel for inputs
    sidebarPanel(

      # Input: Selector for variable to plot against mpg
      selectInput("variable", "Variable:",    # "variable" is the label for this widget
                  c("Cylinders" = "cyl",
                    "Transmission" = "am",
                    "Gears" = "gear")),

      # Input: Checkbox for whether outliers should be included 
      checkboxInput("outliers", "Show outliers", TRUE) # "outliers" is the label for this widget

    ),

    # Main panel for displaying outputs
    mainPanel(

      # Output: Formatted text for caption
      h3(textOutput("caption")), # "caption" is the label for this widget

      # Output: Plot of the requested variable against mpg
      plotOutput("mpgPlot")

    )
  )
)