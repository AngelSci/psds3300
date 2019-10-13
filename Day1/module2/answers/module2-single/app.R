# This is the UI component.

ui <- fluidPage(
  titlePanel("Hello Shiny!"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("obs", "Number of observations:", min = 10, max = 500, value = 100)
    ),
    mainPanel(plotOutput("distPlot"))
  )
)

# This is the server component. 

server <- function(input, output) {
  output$distPlot <- renderPlot({
    hist(rnorm(input$obs), col = 'darkgray', border = 'white')
  })
}

# This lets Shiny know where UI and server functions are 
# (you could use different names like myUI, xyzserver, etc.) 

shinyApp(ui = ui, server = server)