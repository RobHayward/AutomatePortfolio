server <- function(input, output) {
#Input and output the data to the gfile. 
  formData <- reactive({
      data <- sapply(fields, function (x) input[[x]])
      data
    })
  # whenever the submit is clicked, save the form data
    observeEvent(input$submit, {
      # need to calculate the values in the message using current price
      # these three lines can be removed if necessary.
      #showModal(modalDialog(
      #  title = "Important Message", 
      #  "Buy 100 at 24.5, total cost is 400: are you sure"
        # https://shiny.rstudio.com/reference/shiny/1.0.1/modalDialog.html
      #))
      saveData(formData())
    })
#========================================================    
    #show the previous responses
    # update with current responses when submit is clicked
    output$responses <- DT::renderDataTable({
      input$submit
      loadData()
    })
# Create the transaction trable for the particular student    
    studenttransaction <- reactive({
    req(input$student)
    if(dim(transactions[[input$student]])[1] == 0){
      mylength <- 1
    } else {
    mylength <- dim(transactions[[input$student]])[1]
    }
    da1 <- transactions[[input$student]][seq(1,mylength, by = 2),]
    da1[,1] <- as.character(as.Date(da1[,1]))
    return(da1)
    })
 #==========================================================
# Create the student portfolio for the chosen student
  studentportfolio <- reactive({
   req(input$student)
   da2 <- portfolioValue(student = input$student, week = 13)
   da2$table[,1] <- as.character(as.Date(da2$table[,1]))
   # let me remove the colnames for now, 
   #colnames(da2$table) <- c("Date", "SPY", "TLT", "Cash", "Equity", "Debt", "Value", "Return")
   return(da2$table)
   })
#=============================================================
# Calculate the return for the particular student    
  studentReturn1 <- reactive({
   req(input$student)
   da2 <- portfolioValue(student = input$student, week = 13)
   return(da2$Return)
  })
  studentReturn2 <- reactive({
   req(input$student)
   da2 <- portfolioValue(student = input$student, week = 13)
   return(da2$AnnualReturn)
  })
 #=============================================================
# Plot the portfolio performance for the particular student
  studentplot <- reactive({
   req(input$student)
   da2 <- portfolioValue(student = input$student, week = 13)
   # we can add inputs for the weights later.  Remember to change weeks. 
   da3 <- portfoliobenchmarkValue()
   #da2$table <- da$table[, c(1, 6, 7, 8, 9, 10, 11, 13)]
   #da2$table[,1] <- as.Date(da2$table[,1])
   colnames(da2$table) <- c("Date", "Cash", "Equity", "Debt", 
                            "Gold", "Oil", "Value", "Return")
   plot(da2$table[, c(1, 7)], type = 'l', main = paste(input$student, 
                              "portfolio performance", " "), 
        ylim = c(min(da3$table[1:week, 7], da2$table[1:week, 7]), 
                 max(da3$table[1:week, 7], da2$table[1:week, 7])), 
        lwd = 4) 
  lines(da3$table[, c(1, 7)], type = 'l', col = 'red', lwd = 4)
  legend(legend = c("Student Portfolio", "Base Portfolio"), "bottomright", 
         inset = 0.05, col = c("black", "red"), lty = c(1, 1)) 
  # return(myplot)
   
  })
# a reactive object is a cached expression.  If inputs do not change, this remains cached.
  
  output$view1 <- renderTable({
    data = studenttransaction()
  })
  
  output$view2 <- renderTable({
    data = studentportfolio()
  })

  output$text1 <- renderText({
    data = studentReturn1() 
    paste("The Return on this portfolio over the investment period is ", 
          data, " percent.", sep = "")
    })
  
    output$text2 <- renderText({
    data = studentReturn2() 
    paste("The annualised return for this portfolio is ", 
          data, " percent.", sep = "")
    }) 
    
    output$plot <- renderPlot({
       studentplot()
    #plot(studentportfolio()[, c(1, 7)], type = 'l')
    
    })
  
}


