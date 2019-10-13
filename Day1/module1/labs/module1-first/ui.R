# define the UI (User Interface) for the application. 
# fluidPage function allows the display to adjust automatically to the browser dimensions.  
shinyUI(fluidPage(
    
 # application title    
 titlePanel("My First Shiny App!"),
    
 # using a sidebar layout, define a text input area and a text output area in the interface.   
 sidebarLayout(
sidebarPanel(
 textInput("myText", "Enter text here:")
 ),
mainPanel(
 textOutput("niceTextOutput")
 )
 )
))