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
