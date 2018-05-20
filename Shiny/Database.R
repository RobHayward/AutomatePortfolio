# This is from https://ipub.com/shiny-crud-app/
# It will create an app to change a databbase.  First step, just make the 
# file for the updated data. 
require(shiny)
ui <- fluidPage(
  #use shiny js to disable the ID field
  shinyjs::useShinyjs(), 
  
  #data table
  DT::dataTableOutput("response", width = 300), 
  
  #input fields
  tags$hr(), 
  shinyjs::disabled(textInput("id", "Id", "0")), 
  textInput("name", "Name", ""), 
  checkboxInput("used Shiny", "Used Shiny", FALSE), 
  sliderInput("r_num_years", "R years", 0, 25, 2, ticks = FALSE), 
  
  #direction buttons
  
  actionButton("submit", "Submit"), 
  actionButton("new", "New"), 
  actionButton("delete", "Delete") 
  
)

server <- function(input, output, session) {
  # input fields are treated as a group
  formData <- reacctive({
    sapply(names(GetTableMetadata()$fields), function(x) input[[x]])
  })
  # click submit button -> save data
  observeEvent(input$submit, {
    if (input$id != 0) {
      UpdateData(formData())
  } else {
    CreateData(formData())
    UpdateInputs(CreateDefaultRecord(), session)
  }
    
  }, priority = 1)
  
  # Press "New" buttom -> display empty record
  observeEvent(input$delete, {
    DeleteData(formData())
    UpdateInputs(CreateDefaultRecord(), saession)
  }, priorit = 1)    
  
  # select row in table -> show details in inputs
   observeEvent(input$responses_rows_selected, {
    if (length(input$response_rows_selected) > 0){
      data <- ReadData()[input$response_rows_selected, ]
      UpdateInputs(data, session)
    }
  
  })
# display table 
   Output$responses <- DT::renderDataTable({
     #update after submit is clicked
     input$submit
     #update after delete is clicked
     input$delete
     ReadData()
   }, server = FALSE, selection = "single",
   colnames = unname(GetTableMetadata()$fields)[-1]
   )
}

