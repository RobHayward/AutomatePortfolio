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
  
  studentportfolio <- reactive({
   req(input$student)
   da2 <- portfolioValue(student = input$student, weeks = 13)
   da2$table[,1] <- as.character(as.Date(da2$table[,1]))
   colnames(da2$table) <- c("Date", "SPY", "TLT", "Cash", "Equity", "Debt", "Value",
                           "Return")
   return(da2$table)
   })
  studentReturn1 <- reactive({
   req(input$student)
   da2 <- portfolioValue(student = input$student, weeks = 13)
   return(da2$Return)
  })
  studentReturn2 <- reactive({
   req(input$student)
   da2 <- portfolioValue(student = input$student, weeks = 13)
   return(da2$AnnualReturn)
  })
  
  studentplot <- reactive({
   req(input$student)
   da2 <- portfolioValue(student = input$student, weeks = 13)
   da2$table[,1] <- as.Date(da2$table[,1])
   colnames(da2$table) <- c("Date", "SPY", "TLT", "Cash", "Equity", "Debt", "Value",
                           "Return")
   plot(da2$table[, c(1, 7)], type = 'l', main = paste(input$student, 
                              "portfolio performance", " "), 
        ylim = c(min(portfoliobenchmarkValue$table[, 7]), 
                 max(portfoliobenchmarkValue$table[, 7])), lwd = 4) 
   lines(portfoliobenchmarkValue$table[, c(1, 7)], type = 'l', col = 'red', lwd = 4)
  legend(legend = c("Student Portfolio", "Base Portfolio"), "bottomleft", col = 
           c("black", "red"), lty = c(1, 1)) 
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


