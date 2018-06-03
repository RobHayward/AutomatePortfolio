# this comes frmo h#ttps://rstudio.github.io/shinydashboard/
#install.packages("shinydashboard")
# the dashboard has three components: header, sidebar and body.

## app.R ##
library(shiny)
library(shinydashboard)



ui <- dashboardPage(
  dashboardHeader(title = "Select", 
                  dropdownMenu(type = "messages", 
                               messageItem("Sales Dep", 
                                           message = "Sales are steady this month"
                                           ), 
                               messageItem(
                                 from = "New User", 
                                 message = "How do I register", 
                                 icon = icon("question"), 
                                 time = "13:45"
                               ), 
                               messageItem(
                                 from = "SUpport", 
                                 message = "The new server is ready", 
                                 icon = icon("life-ring"),
                                 time = "2014-12-01"
                               ))), 
  # sidebar content
  dashboardSidebar(
    sidebarMenu(
      menuItem("Security Selection", tabName = "security_selection", icon = icon("dashboard")), 
      menuItem("Portfolio", tabName = "portfolio", icon = icon("th")),
      menuItem("News", tabName = "news", icon = icon("500px")),
      menuItem("Economic Calendar", icon = icon("calendar"), 
               href = 'https://tradingeconomics.com/calendar')
    )
  ),
  
  dashboardBody(
    tabItems(
      # first tab content
      tabItem(tabName = "security_selection", 
              
    
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
tabItem(tabName = "portfolio", 
        h2("Portfolio")
 ),
# third tab content
tabItem(tabName = "news", 
        h2("News information and suggestions"),
        p("This is what we say")
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
  
  output$messageMenu <- renderMenu({
    #code to generate each of the message items here in a list
    # This asssumes that hte message data is a data frame with two 
    # elements: 'from' and 'messages' 
    msgs <- apply(messageData, 1, function(row) (
      messageItem(from = row[["from"]], message = row[["message"]])
    ))
  })
}

shinyApp(ui, server)
