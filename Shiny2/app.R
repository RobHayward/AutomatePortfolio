# This comes from https://shiny.rstudio.com/articles/persistent-data-storage.html#basic
# We only need the first two components.  
library(shiny)
# define the fields that we want to save from the form
fields <- c("name", "used_shiny", "r_num_years")

# shiny app wtih the three fields that the user can submit data for
shinyApp(
  ui = fluidPage(
    DT::dataTableOutput("responses", width = 300), tags$hr(), 
    textInput("name", "Name", ""),
    checkboxInput("used_shiny", "I've build a shiny app in R before", FALSE),
    sliderInput("r_num_years", "Number of years using R", 
                 0, 25, 2, ticks = FALSE), 
    actionButton("submit", "Submit")
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

shinyApp(ui = ui, server = server)

