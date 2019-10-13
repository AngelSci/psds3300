# ui.R

library(shiny)

ui <- fluidPage(
  titlePanel("App title/name"),
  sidebarLayout(
      
    sidebarPanel(), # nothing in the sidebar for now.
    mainPanel(
      h1("Welcome"),  
      p("p creates a paragraph of text."),
      p("A new p() command starts a new paragraph."),
      strong("strong() makes bold text."),
      em("em() creates italicized/emphasized text."),
      div("div creates segments of text with a similar style. This division of text is blue because we used a style argument.", style = "color:blue"),
      a(href="http://shiny.rstudio.com","a sample link here")
    )
  )
)
