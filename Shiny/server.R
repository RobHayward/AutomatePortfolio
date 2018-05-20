server <- function(input, output, session) {
  # input fields are treated as a group
  formData <- reactive({
    sapply(names(GetTableMetadata()$fields), function(x) input[[x]])
  })
  # click submit button -> save data
  observeEvent(input$submit, {
    if (input$id != "0") {
      UpdateData(formData())
    } else {
      CreateData(formData())
      UpdateInputs(CreateDefaultRecord(), session)
    }
    
  }, priority = 1)
  
  # Press "New" buttom -> display empty record
  observeEvent(input$new, {
    UpdateInputs(CreateDefaultRecord(), session)
  })
  
  # Press "Delete" button -> delte from data
  observeEvent(input$delete, {
    DeleteData(formData())
    UpdateInputs(CreateDefaultRecord(), session)
  }, priorit = 1)    
  
  # select row in table -> show details in inputs
  observeEvent(input$responses_rows_selected, {
    if (length(input$response_rows_selected) > 0){
      data <- ReadData()[input$response_rows_selected, ]
      UpdateInputs(data, session)
    }
    
  })
  # display table 
  output$responses <- DT::renderDataTable({
    #update after submit is clicked
    input$submit
    #update after delete is clicked
    input$delete
    ReadData()
  }, server = FALSE, selection = "single",
  colnames = unname(GetTableMetadata()$fields)[-1]
  )
}

