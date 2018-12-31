# load packages
library(shiny)
library(googlesheets)
library(shinythemes)
library(shinydashboard)
library(DT)
#================================================
# Do I set the week here??? I will for now
week = 1
#===================================================
# create fields for...
fields <- c("name", "asset", "action", "quantity")
#=================================================
# Save and load data functions
outputDir = "responses"

saveData <- function(data) {
  data <- t(data)
  fileName <- sprintf("%s_%s.csv", as.integer(Sys.time()), digest::digest(data))
  # write file to local system
  write.csv(
    x = data,
    file = file.path(outputDir, fileName), 
    row.names = FALSE, quote = TRUE
  )
}

loadData <- function() {
  # read all the files into the list
  files <- list.files(outputDir, full.names = TRUE)
  data <- lapply(files, read.csv, stringsAsFactors = FALSE)
  # concatonate all data together into one dataframe
  data <- do.call(rbind, data)
  data
}
#=================================================
# Load functions for Shiny
# portfolioValue function that will build a table and make some 
# calculations when the student is chosen.  
portfolioValue <- function(student, week = 13){
  # Turn date to date class. 
  portfolio[[student]][,1] <- as.Date(portfolio[[student]][,1])
  # merge the student portfolio with the price data
  tempdf <- merge(pricetab, portfolio[[student]], by = "Date")
  # calculate the value of the portfolio. 
  # This has been changed
    tempdf$value <- tempdf[,2] * tempdf[, 7] + tempdf[, 3] * tempdf[, 8] + 
    tempdf[, 4] * tempdf[, 9] + tempdf[, 5] * tempdf[, 10] + tempdf[, 6]
  # Now isolate multiple dates so that just the last transaction is displayed
  tempdf <- tempdf[(duplicated(portfolio[[student]]$Date) &! 
                      duplicated(portfolio[[student]]$Date, fromLast = TRUE) ) 
                   | (!duplicated(portfolio[[student]]$Date) &! duplicated(portfolio[[student]]$Date, fromLast = TRUE)), ]
  
  #tempdf <- tempdf[duplicated(tempdf$Date) &! duplicated(tempdf$Date, fromLast = TRUE), ]
  # create the lagged variable
  tempdf$valuel <- c(rep(NA, 1), tempdf$value)[1:length(tempdf$value)]
  # calculate the percentage
  tempdf$return <- round((tempdf$value - tempdf$valuel)/tempdf$valuel, digits = 6)
  colnames(tempdf) <- c("Date", "Equity_Price", "Debt_Price", 
                        "Gold_Price", "Oil_Price", "Cash_Holding", 
                        "Equity_Holding", "Debt_Holding", 
                        "Gold_Holding", "Oil_Holding", "Portfolio_Value",
                        "Lagged_Value", "Portfolio_Return")
  performance1 <- (tempdf[dim(tempdf)[1], "Portfolio_Value"] / 
                     tempdf[1, "Portfolio_Value"] -1)*100
  performance2 <- ((tempdf[dim(tempdf)[1], "Portfolio_Value"] / 
                      tempdf[1, "Portfolio_Value"])^(52/week)-1)*100
  mylist <- list(table = tempdf[,-c(2, 3, 4, 5, 12)], student = student, 
                 ReturnSeries = tempdf$'Portfolio_Return', Return =  
                 round(performance1, 2), AnnualReturn = round(performance2, 2))
  return(mylist)
}
#=======================================
# This just applies the portfolioi value function to a particular 
# benchmark portfolio.  This also needs to be translated to assets
portfoliobenchmarkValue <- function(fundvalue = 1000000, equityweight = 40, debtweight = 30, goldweight = 20, oilweight = 10, week = 13){
  equityvalue <- fundvalue * equityweight / 100
  debtvalue <- fundvalue * debtweight / 100
  goldvalue <- fundvalue * goldweight/ 100
  oilvalue <- fundvalue * oilweight/100
  cashvalue <- fundvalue * (100 - equityweight - debtweight
                            - goldweight - oilweight)/100
  equityvolume <- equityvalue/pricetab[1,2]
  debtvolume <- debtvalue/pricetab[1,3]
  goldvolume <- goldvalue/pricetab[1,4]
  oilvolume <- oilvalue/pricetab[1, 5]
  # now build the data.frame
  portfoliobenchmark <- data.frame(Date = as.Date(pricetab[c(1:week), 1]), 
  	Cash = rep(cashvalue, week), 
  	           Equity = rep(equityvolume, week), 
  	                        Debt = rep(debtvolume, week), 
  	                        Gold = rep(goldvolume, week), 
  	                        Oil = rep(oilvolume, week))
  tempdf <- merge(pricetab, portfoliobenchmark, by = "Date")
  # calculate the value of the portfolio. 
  # This has been changed
  tempdf$value <- tempdf[,2] * tempdf[, 7] + tempdf[, 3] * tempdf[, 8] + 
    tempdf[, 4] * tempdf[, 9] + tempdf[, 5] * tempdf[, 10] + tempdf[, 6]
  # create the lagged variable
  tempdf$valuel <- c(rep(NA, 1), tempdf$value)[1:length(tempdf$value)]
  # calculate the percentage
  tempdf$return <- round((tempdf$value - tempdf$valuel)/tempdf$valuel, digits = 6)
  colnames(tempdf) <- c("Date", "Equity_Price", "Debt_Price", 
                        "Gold_Price", "Oil_Price", "Cash_Holding", 
                        "Equity_Holding", "Debt_Holding", 
                        "Gold_Holding", "Oil_Holding", "Portfolio_Value",
                        "Lagged_Value", "Portfolio_Return")
  performance1 <- (tempdf[week, 13] / 
                     tempdf[1, 13] -1)*100
  performance2 <- ((tempdf[week, 13] / 
                      tempdf[1, 13])^(52/week)-1)*100
  mylist2 <- list(table = tempdf[,-c(2, 3, 4, 5, 12)], student = NA, 
                 ReturnSeries = tempdf$'Portfolio_Return', Return =  
                   round(performance1, 2), AnnualReturn = round(performance2, 2))
  return(mylist2)} 	           
# Load data============================
# Get the latest datafile.
#load('./backup/port2019-01-18')
#load('./backup/trans2019-01-18')
#data <- read.csv("Names.csv", stringsAsFactors = FALSE)
students <- c("Team1", "Team2", "Team3", "Team4")
#shinyApp(ui, server)
