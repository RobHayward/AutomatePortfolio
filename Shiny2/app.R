# This comes from https://shiny.rstudio.com/articles/persistent-data-storage.html#basic
# We only need the first two components.  
library(shiny)
# define the fields that we want to save from the form
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
# shiny app wtih the three fields that the user can submit data for
shinyApp(
  ui = fluidPage(
    theme = "bootstrap.css",
    titlePanel("Investment App:  Please record investments here"),
    mainPanel(
    textOutput("This is the place to select security.  Make sure that you use the correct 
              user name, record the volume and the assets.  The price will be taken from 
              close.  Remember, if you do not have sufficient funds, you will be fined
              one percent of the transaction cost."),
    tags$hr(),
    DT::dataTableOutput("responses", width = 350)  
  ),
    
    sidebarPanel(
    textInput("name", "Name", ""),
    selectInput("asset", "Asset", choice = c("SPY", "TLT"), selected = "SPY"),
    selectInput("action", "Action", choice = c("Buy", "Sell"), selected = "Buy"),
    numericInput("quantity", "Assets to buy or sell", value = 100, min = 0, max = 10e6),
    actionButton("submit", "Submit")
    ) 
),
  server = function(input, output, session) {
    
    # whenever a field is filled, aggregate all the form data
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
  
)




