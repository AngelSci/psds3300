ui <- fluidPage(
  checkboxGroupInput("check", "Input checkbox", c("Item A", "Item B", "Item C")),
  selectInput("select", "Select input", c("Item A", "Item B", "Item C"))
)

server <- function(input, output, session) { # session object is passed here

  observe({

    x <- input$check # get a list of selections from the checkbox

    # we can use character(0) to remove all choices if nothing is checked yet. 
    if (is.null(x)) {    
      x <- character(0)
    }

    # we can set the label and selection list
    updateSelectInput(session, "select",
      label = paste("Select input label", length(x)), # update the label 
      choices = x,   # new list of choices 
      selected = tail(x, 1))  # pick one as the selected value 
  })
}

shinyApp(ui, server)
