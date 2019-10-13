ui <- fluidPage( 
  actionButton('insertBtn', 'Insert'), 
  actionButton('removeBtn', 'Remove'), 
  tags$div(id = 'placeholder') 
)


server <- function(input, output) {
  
  ## keep track of a list of elements inserted and not yet removed
  inserted <- c()
  
  observeEvent(input$insertBtn, { #insert button is pushed
  
    btn <- input$insertBtn
    id <- paste0('txt', btn) # create an "ID" for the element

    # call the insertUI to insert af the "placeholder" in UI 
    insertUI(selector = '#placeholder',
    
      ## wrap element in a div with id for ease of removal
      ui = tags$div(tags$p(paste('Element number', btn)), 
      id = id
      )
    )
    
    # add it to the end of the list 
    inserted <<- c(id, inserted)
  })
    
  
  observeEvent(input$removeBtn, {
    
    # call the removeUI to remove the last element added 
    removeUI(
      ## pass in appropriate div id from the end of the list 
      selector = paste0('#', inserted[length(inserted)])
    )
    
    # remove it from the list, too. 
    inserted <<- inserted[-length(inserted)]
  })
  
}

shinyApp(ui, server)

