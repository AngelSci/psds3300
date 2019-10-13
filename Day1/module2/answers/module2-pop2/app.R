# app.R
library(shiny)
library(shinydashboard)
library(ggplot2)

# these operations need to be done only once
# read the data set 
popdata = read.csv("../module2-pop/pop_proj.csv") # data set is in the same folder as the app. 

# we need these lists to automatically populate the choices in the UI. 
sex_list <- c("All", levels(popdata$sex))
age_list <- c("All", levels(popdata$age))

body <- dashboardBody(
    # first create a row 
    fluidRow(
     # now a tabBox with two panels    
     tabBox(
      title = "US Population",
      id = "proj", width=12, #full width of the screen 
         
      # this is the panel with the plot and the selections    
      tabPanel("Projection", 
        
        plotOutput("ggp"),
        box(title = tagList(shiny::icon("gear"), "Selections"), width=12,                       
      
          column(6,
                selectInput("sex_in", 
                  label = em("Sex:"),
                  choices = sex_list,
                  selected = "All") #default
          ),
          column(6,
                selectInput("age_in", 
                  label = em("Age bracket:"),
                  choices = age_list,
                  selected = "All") #default
          )
        )               
      ),
         
      # this is the data panel    
      tabPanel("Data", dataTableOutput("table"))      
    )
             
  )
)

# This is UI, it has a clean look because we defined body up above. 
ui <- dashboardPage(
    dashboardHeader(title = "popVis"),
    dashboardSidebar(helpText("Projections of the population by sex and selected age groups for US: 2015-2030")),
    body
  )

# This is server function is the same as in the layout practice. 
server <- function(input, output) {

     output$ggp <- renderPlot({ 
      
      if (input$age_in != "All") 
      {
        newdata <- subset(popdata, age == input$age_in)
      } else { 
          
        newdata <- popdata
      }
   
      if (input$sex_in == "All") 
      {
          p <- ggplot(data=newdata, aes_string(x="year", y="pop")) 

      } else {
          
          p <- ggplot(data=subset(newdata, sex == input$sex_in), aes_string(x="year", y="pop"))           
      }
      
      p <- p + geom_bar(stat="identity") + theme_minimal() + xlab("Years") + ylab("Population Projection") + ylim(0,300000) 
      print(p)
  })
 
  output$table <- renderDataTable(popdata)    
}

shinyApp(ui=ui, server=server)