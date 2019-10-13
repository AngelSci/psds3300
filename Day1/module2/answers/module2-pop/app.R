# Do not run this code cell, copy and paste it to app.R

library(shiny)
library(ggplot2)

# these operations need to be done only once
# read the data set 
popdata = read.csv("pop_proj.csv") # data set is in the same folder as the app. 

# we need these lists to automatically populate the choices in the UI. 
sex_list <- c("All", levels(popdata$sex))
age_list <- c("All", levels(popdata$age))


pop_ui <- fluidPage(
    
  h1("popVis"),
  tabsetPanel(    
   tabPanel("Projection",     

    fluidRow(      
        plotOutput("ggp")        
    ),
    
    hr(),
    
    fluidRow(
        column(3,
              helpText("Projections of the population by sex and selected age groups for US: 2015-2030")
        ),
        column(4,
                selectInput("sex_in", 
                  label = em("Sex:"),
                  choices = sex_list,
                  selected = "All") #default
        ),
        column(5,
                selectInput("age_in", 
                  label = em("Age bracket:"),
                  choices = age_list,
                  selected = "All") #default
        )
    )             
   ),
            
   tabPanel("Data", dataTableOutput("table")) 
  )
)
    

pop_server <- function(input, output) {

         
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

shinyApp(ui=pop_ui, server=pop_server)