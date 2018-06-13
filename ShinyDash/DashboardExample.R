# this comes frmo h#ttps://rstudio.github.io/shinydashboard/
#install.packages("shinydashboard")
# the dashboard has three components: header, sidebar and body.

## app.R ##
library(shiny)
library(shinydashboard)
library(DT)

fields <- c("name", "asset", "action", "quantity")
saveData <- function(data) {
  data <- as.data.frame(t(data))
  if(exists("responses")) {
    responses <<- rbind(responses, data)
  } else {
    responses <<- data
  }
  
}


loadData <- function() {
  if(exists("responses")) {
    responses
  }
}

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
    
    box(
      title = "Select security",
      textInput("name", "Name", ""),
    selectInput("asset", "Asset", choice = c("SPY", "TLT"), selected = "SPY"),
    selectInput("action", "Action", choice = c("Buy", "Sell"), selected = "Buy"),
    numericInput("quantity", "Assets to buy or sell", value = 100, min = 0, max = 10e6),
    actionButton("submit", "Submit")
    ),
  
   box(  
   DT::dataTableOutput("responses", width = 350)   
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
  formData <- reactive({
      data <- sapply(fields, function (x) input[[x]])
      data
    })
  # whenever the submit is clicked, save the form data
    observeEvent(input$submit, {
      saveData(formData())
    })
    
    #show the previous responses
    # update with current responses when submit is clicked
    output$responses <- DT::renderDataTable({
      input$submit
      loadData()
    })
  
  
}

shinyApp(ui, server)
