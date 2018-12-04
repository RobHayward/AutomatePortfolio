library(shiny)
# fieds for the form
fields <- c("name", "used_shiny", "r_num_years")

# Shiny app with 3 fields that can be submitted

shinyApp(
  ui = fluidPage(
    DT::dataTableOutput("responses", width = 300), tags$hr(), 
    textInput("name", "Name", ""), 
    checkboxInput("used_shiny", "I've built a Shiny app in R before", FALSE), 
    sliderInput("r_num_years", "Number of years using R", 
                0, 25, 2, ticks = FALSE), 
    actionButton("submit", "Submit")
    ),
  
  server = function(input, output, sesssion){
    
    #whenever a field is filled aggregate all form data
    formData <- reactive({
      data <- sapply(fields, function(x) input[[x]])
      data
    })
  
    # when the submit button is clicked, save the form data
    observeEvent(input$submit, {
      saveData(formData())
  })

    # show the previous responses
    # update with current response when submit is clicked
    output$responses <- DT::renderDataTable({
      input$submit
      loadData()
      
    })
        }
    )

saveData <- function(data){
  data <- as.data.frame(t(data))
  if (exists("responses")) {
    responses <<- rbind(responses, data)
  } else {
    responses <<- data
  }
  }

loadData <- function() {
  if (exists("responses")) {
    responses
  }
}
