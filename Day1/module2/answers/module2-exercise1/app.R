
library(ggplot2)
library(dplyr)
#gapminder <- readRDS(file = "/dsa/data/all_datasets/gapminder_data.rds")
gapminder <- readRDS(file = "/dsa/data/all_datasets/gapminder_data.rds")

# these operations need to be done only once

gm <- gapminder 
gm <- transform(gm, pop = as.numeric(pop))

# compute total pop and weighted means for life exp. gdp per cap. 
cgm <- gm %>% group_by(continent,year) %>% summarise(totpop=sum(pop),avglifeExp=sum(pop*lifeExp)/totpop,avggdpPercap=sum(pop*gdpPercap)/totpop, numCountries=n())


pop_ui <- fluidPage(
    
  h1("GapMinder"),
  tabsetPanel(    
   tabPanel("Plots",     

    fluidRow(      
        column(4, plotOutput("plot1")),
        column(4, plotOutput("plot2")),
        column(4, plotOutput("plot3"))
    ),
    
    hr(),
    
    fluidRow(
        column(4,
              helpText("GapMinder data: worlwide average life expectancy and GDP per capita 1952 - 2007.")
        ),
        column(8,
                sliderInput("year_in", 
                  label = em("Year:"), 1952, 2007, 1952, 5, width="100%", sep="")                  
        )
    )             
   ),
            
   tabPanel("Country Data", dataTableOutput("table1")), 
   tabPanel("Continent Data", dataTableOutput("table2"))       
  )
)
    

pop_server <- function(input, output) {

         
  output$plot1 <- renderPlot({ 
      
      p <- ggplot(data=subset(gm, year==input$year_in), aes(x=lifeExp)) +  geom_density(alpha=.2, fill="red")             
      p <- p + theme_minimal() + xlab("Years") + ylab("Life Expectancy") + xlim(0,100) 
      print(p)
  })
 
  output$plot2 <- renderPlot({ 
      
      p <- ggplot(data=subset(cgm,year==input$year_in), aes(x=continent, y=totpop, fill=continent)) + geom_bar(stat="identity")       
      p <- p + theme_minimal() + xlab("Continents") + ylab("Total Population") + theme(legend.position="none") + ylim(0,4000000000) 
      print(p)
  })

    output$plot3 <- renderPlot({ 
      
      p <- ggplot(data=subset(cgm,year==input$year_in), aes(x=continent, y=avggdpPercap, fill=continent)) + geom_bar(stat="identity")      
      p <- p + theme_minimal() + xlab("Continents") + ylab("GDP per Capita") + theme(legend.position="none") + ylim(0,40000) 
      print(p)
  })    
    
  output$table1 <- renderDataTable(gm)    
  output$table2 <- renderDataTable(cgm)    
    
}

shinyApp(ui=pop_ui, server=pop_server)