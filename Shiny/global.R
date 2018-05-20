#Load Packages
  if (!require("shiny")) {
  install.packages("shiny", repos="http://cran.rstudio.com/") 
  library("shiny")
}
#library(shinythemes)
# Load functions for Shiny
# This is the function for dates from valueDates.R
# Helpers
# This will cast data from the inputs to a one-row dataframe
  CastData <- function(data) {
	  datar <- data.frame(name = data["name"], 
			      used_shiny = as.logical(data["used_shiny"]),
			      r_num_years = as.integer(data["r_num_years"]), 
			      stringsAsFactors = FALSE)
	  rownames(datar) = data["id"]
	  return(datar)

	  }
  
  #This creates an empty record to be used

  CreateDefaultRecord = function() {
	  mydefault <- CastData(list(id = "0", name = "", used_shiny = FALSE, r_num_years = 2))
	  return(mydefault)
  }
 # This takes the data and updates the inputs
  UpdateInputs <- function(data, session){
	  updateTextInput(session, "id", value = unname(rownames(data)))
	  updateTextInput(session, "name", value = unname(data["name"]))
	  updateTextInput(session, "used_shiny", value = as.logical(data["used_shiny"])) 
	  updateTextInput(session, "r_num_years", value = as.integer(data["r_num_years"]))
  }
  # function used to get the next id
  GetNextId <- function(){
	  if (exists("responses") && nrow(responses) > 0) {
		  max(as.integer(rownames(responses))) + 1
	  } else {
		  return (1)
	  }
  }
  # Methods ti mimic actual CRUD funcctionality 
  # CREATE
  CreateData <- function(data) {
	  data <- CastData(data)
	  rownames(data) <- GetNextId()
	  if (exists("responses")) {
		  responses <<- rbind(responses, data)
	  } else {
		  responses <<- data
	  }
  }
  # READ
  ReadData <- function() {
	  if (exists("responses")) {
		  responses
	  }
  }

  #UPDATE
  UpdateData <- function(data){
	  data = CastData(data)
	  responses[row.names(responses) == row.names(data), ] <<- data
  }

  #DELETE
  DeleteData <- function(data) {
	  responses <<- responses[row.names(responses) != unname(data["id"]), ]
  }

  #GetTableMetaData fordevelopent?  Not sure
  GetTableMetadata <- function() {
	  fields <- c(id = "Id", 
		     name = "Name", 
		     used_shiny = "Used Shiny", 
		     r_num_years = "R Years")
	  result <- list(fields = fields)
	  return (result)
  }



