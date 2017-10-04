# Load Packages--------------------------
library(shiny)
#library(shinythemes)
#library(dplyr)
#library(readr)
# Load data============================
library(shiny)
da1 <- read.csv("../Trading/Database/newSPY.csv", stringsAsFactors = FALSE)
da2 <- read.csv("../Trading/Database/newTLT.csv", stringsAsFactors = FALSE)
da <- merge(x = da1, y = da2, by = "Date") 
da$Date <- as.Date(da[,1], format = "%Y-%m-%d")
da <- da[, c(1, 6, 12)]
colnames(da) <- c("Date", "Equity", "Debt")
#====================================================
# Create portfolio using the data from the gradebook.  This will use the student id so can automate email. 
data <- read.csv("../EC381/Official/EC381.csv", stringsAsFactors = FALSE)
students <- data$Username
#ma <- matrix(nrow = length(students), ncol = 3)
#da <- data.frame(ma, row.names = students)
assets <- c("Cash", "Equity", "Debt")
#colnames(da) <- assets
#head(data

portfolio <- as.list(students)
transactions <- as.list(students)
# the first method is to put the elements together
d1 <- data.frame("Date" = Sys.Date(), "Cash"= 1000000, "Equity" = 0, "Debt" = 0) 
# the second is to create the variables with zero values 
Date <- as.Date(character())
BS <- factor(levels = c("Buy", "Sell"))
Asset <- factor(levels = c("Cash", "Equity", "Debt"))
Volume <- numeric()
Price <- numeric()
Total <- numeric()
d2 <- data.frame(Date, BS, Asset, Volume, Price, Total)
portfolio <- lapply(portfolio, function(x) d1)
transactions <- lapply(transactions, function(x) d2)
names(portfolio) <- students
names(transactions) <- students
rm(da1, da2, d1, d2, Date, BS, Asset, Volume, Price, Total, data)

# define UI=============================================================
ui <- shinyUI(fluidPage(
  
  # Application title
  titlePanel("Portolio"),
  
  # Sidebar with controls to select a dataset and specify the
  # number of observations to view
  sidebarLayout(
    sidebarPanel(
        selectInput(inputId = "student", label = "Choose a student:", 
                  choices = students,
                  selected = 'td126')
      
),
    
    # Show a summary of the dataset and an HTML table with the 
    # requested number of observations
    mainPanel(
      
      dataTableOutput("view")
    )
  )
))

#======================


# Define server logic required to summarize and view the selected
# dataset
server <- shinyServer(function(input, output) {
  
  # Return the requested dataset
  studentportfolio <- reactive({
    switch(input$student, portfolio[[student]])
  })
  
  
  output$view <- renderDataTable({
    studentportfolio
  })
})

# Create the shiny app server
shinyApp(ui = ui, server = server)