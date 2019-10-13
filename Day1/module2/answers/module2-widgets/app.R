# Do not run this code cell, copy and paste it to app.R

library(shiny)

ui <- fluidPage(
  titlePanel("censusVis"),

  sidebarLayout(
    sidebarPanel(
      helpText("Create demographic maps with 
               information from the 2010 US Census."),

      selectInput("var", 
                  label = em("Choose a variable to display"),
                  choices = c("Percent White", 
                              "Percent Black",
                              "Percent Hispanic", 
                              "Percent Asian"),
                  selected = "Percent White"), #default

      sliderInput("range", 
                  label = em("Range of interest:"),
                  min = 0, max = 100, value = c(0, 100))
    ),

    mainPanel(
      h3("Output is displayed here:"),
      textOutput("selected_var"),
      p(),
      textOutput("selected_range")
        
    )
  )
)

server <- function(input, output) {

  output$selected_var <- renderText({ 
    paste("You have selected ", input$var)  # create a text message using the input from user. Now this is reactive. 
  })
  
  output$selected_range <- renderText({ 
    paste(" in this range: ", input$range[1], " - ", input$range[2]) 
  })
        
}


shinyApp(ui=ui, server=server)