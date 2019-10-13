# server.R

library(shiny)
library(datasets)

# Data pre-processing
# Tweak the "am" variable to have nicer factor labels

# Since this doesn't rely on any user inputs, we can do this once at
# startup and then use the value throughout the lifetime of the app.
mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))


# Define server logic to plot various variables against mpg 

# input and output variables of this function provide communication with the UI above. 
server <- function(input, output) {

  # Compute the formula text 
  # This is in a reactive expression since it is shared by the
  # output$caption and output$mpgPlot functions
  formulaText <- reactive({
    paste("mpg ~", input$variable)
  })

  # Return the formula text to UI for printing as a caption 
  output$caption <- renderText({
    formulaText()
  })

  # Generate a plot of the requested variable against mpg
  # and exclude outliers if requested.
  output$mpgPlot <- renderPlot({
    boxplot(as.formula(formulaText()),
            data = mpgData,
            outline = input$outliers,
            col = "#75AADB", pch = 19)
  })

}