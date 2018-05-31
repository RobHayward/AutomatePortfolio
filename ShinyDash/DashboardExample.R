# this comes frmo h#ttps://rstudio.github.io/shinydashboard/
#install.packages("s#hinydashboard")
# the dashboard has three components: header, sidebar and body.

## app.R ##
library(shiny)
library(shinydashboard)


ui <- dashboardPage(
  dashboardHeader(title = "Basic dashboard"), 
  # sidebar content
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")), 
      menuItem("Widgets", tabName = "widgets", icon = icon("th"))
    )
  ),
  
  dashboardBody(
    tabItems(
      # first tab content
      tabItem(tabName = "dashboard", 
              
    
  # boxes need to be put in rows or columns
  fluidRow(
    box(plotOutput("plot1", height = 250)), 
    
    box(
      title = "Controls",
      sliderInput("slider", "Number of Observations:", 1, 100, 50)
    )
  )

), 
# second tab content
tabItem(tabName = "widgets", 
        h2("Widgets tab content")
        )
)
)
)
server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
}

shinyApp(ui, server)
