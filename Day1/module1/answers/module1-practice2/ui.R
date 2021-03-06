# ui.R 
# starter code for the practice. Add your own code to this. 
library(shiny)

ui <- fluidPage(
  titlePanel("My Shiny App"),
  sidebarLayout(
      
    sidebarPanel(), # nothing in the sidebar for now.
    mainPanel(  
      h1("Introducing Shiny"),  
      p("Shiny is a new package from RStudio that makes it ", em("incredibly easy")," to build interactive web applications in R."),
      br(),
      p("For an introduction and live examples, visit the",a(href="http://shiny.rstudio.com","Shiny homepage.")),
      br(),
      h1("Features"),
      p("- Build useful web applications with only a few lines of code - no Javascript required."),
      p("- Shiny applications are automatically 'live' in the same way that ", strong("spreadsheets"), "are live. Outputs change instantly as users modify inputs, without requiring a reload of the browser." )
    )
  )
)