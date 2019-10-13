library(shiny)
library(ggplot2)
library(ggthemes)
gapminder <- readRDS(file = "/dsa/data/all_datasets/gapminder_data.rds")

gm <- gapminder

ui <- fluidPage(
        sidebarLayout(
            sidebarPanel(
                selectInput("plotType", "Plot Type", c(Scatter = "scatter", Bar = "bar")),

                # show this panel only if the plot type is chosen as 'scatter' above
                conditionalPanel(
                    condition = "input.plotType == 'scatter'",
                    selectInput("cont", "Continent:", choices = levels(gm$continent))
                ),
                
                # show this panel only if the plot type is chosen as 'bar' above
                conditionalPanel(
                    condition = "input.plotType == 'bar'",
                    sliderInput("year", "Year:", min=1952, max=2007, step=5, value=1952)
                )
            ),
            mainPanel(
                plotOutput("plot")
            )
        )
    )

server <- function(input, output) {

    output$plot <- renderPlot({

        if (input$plotType == "scatter")
        {
            p <- ggplot(data=subset(gm, continent==input$cont), aes_string(x="gdpPercap", y="lifeExp", color="country")) + geom_point()
            p <- p + theme_minimal() + xlab("GDP per capita") + ylab("Life Expectancy") + geom_line(size=0.5)
            p <- p+ ggtitle(paste0("Countries in ", input$cont)) + theme(legend.position="none") + xlim(0,50000) + ylim(0,90) 
            p
        } else # bar plot
        {
            p <- ggplot(data=subset(gm, year==input$year), aes_string(x="continent", y="lifeExp"))
            p <- p + geom_bar(stat="summary", fun.y="mean")
            p <- p + theme_minimal() + xlab("continents") + ylab("Life Expectancy")
            p <- p + ggtitle(paste0("Continents in ", input$year)) + ylim(0,90)
            p
        }
    })
}

shinyApp(ui, server)

