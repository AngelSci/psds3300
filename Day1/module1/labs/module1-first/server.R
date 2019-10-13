# define the server code; unnamed function contains the code necessary to run the app. 

shinyServer(function(input, output){

# define the output area in the user interface; it will get its value from the text input area.     
output$niceTextOutput <-
renderText(paste("You entered the text:\n",
input$myText))

 })