# load packages
library(shiny)
library(googlesheets)
library(shinythemes)
library(shinydashboard)
library(DT)
#===================================================
# create fields for...
fields <- c("name", "asset", "action", "quantity")
#=================================================
# Save and load data functions
saveData <- function(data) {
  # grab google sheet
  gfile2 <- gs_title("Gfile2")
  # add the data as a new row
  gs_add_row(gfile2, input = data)
}

loadData <- function() {
  # grade the google sheet
  gfile2 <- gs_title("Gfile2")
  # read the data
  gs_read_csv(gfile2)
}
#=================================================
# Load functions for Shiny
# This is the function for dates from valueDates.R
pick.wkday <- function(selday,start,end) {
  fwd.7 <- start + 0:6
  first.day <- fwd.7[as.numeric(format(fwd.7,"%w"))==selday]
  seq.Date(first.day,end,by="week")
}
# valueDates are the dates at which the portfolio will be valued. 
valueDates <- pick.wkday(5, as.Date("2019-01-01"), as.Date("2019-03-31"))
# The pricetab vector holds the prices of the assets
# Can I automate this from list of assets? 
pricetab <- data.frame(Date = as.Date(valueDates), Equity_price = rep(NA, length(valueDates)),  Debt_price = rep(NA, length(valueDates)), Gold_price  = rep(NA, length(valueDates)), Oil_price = rep(NA, length(valueDates)))
pricetab[1, 2] <- 22
pricetab[1, 3] <- 23
pricetab[1, 4] <- 24
pricetab[1, 5] <- 25
#pricetab[2, 2] <- #pricetab[2, 3] <- 
#pricetab[3, 2] <- 
#pricetab[3, 3] <- 
#pricetab[4, 2] <- 
#pricetab[4, 3] <- 
#pricetab[5, 2] <- 
#pricetab[5, 3] <- 
#pricetab[6, 2] <- 
#pricetab[6, 3] <- 
#pricetab[7, 2] <- 
#pricetab[7, 3] <- 
#pricetab[8, 2] <- 
#pricetab[8, 3] <- 
#pricetab[9, 2] <- 
#pricetab[9, 3] <- 
#pricetab[10, 2] <-
#pricetab[10, 3] <-
#pricetab[11, 2] <-
#pricetab[11, 3] <-
#pricetab[12, 2] <-
#pricetab[12, 3] <-
#pricetab[13, 2] <-
#pricetab[13, 3] <-
#=====================================================
# portfolioValue function that will build a table and make some 
# calculations when the student is chosen.  
portfolioValue <- function(student, weeks = 13){
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
  performance1 <- (tempdf[dim(tempdf)[1], 13] / 
                     tempdf[1, 13] -1)*100
  performance2 <- ((tempdf[dim(tempdf)[1], 13] / 
                      tempdf[1, 13])^(52/weeks)-1)*100
  mylist <- list(table = tempdf[,-c(2, 3, 4, 5, 12)], student = student, 
                 ReturnSeries = tempdf$'Portfolio_Return', Return =  
                 round(performance1, 2), AnnualReturn = round(performance2, 2))
  return(mylist)
}
#=======================================
# This just applies the portfolioi value function to a particular 
# benchmark portfolio.  This also needs to be translated to assets
portfoliobenchmarkValue <- function(fundvalue = 1000000, equityweight = 40, debtweight = 30, goldweight = 20, oilweight = 10, weeks = 13){
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
  portfoliobenchmark <- data.frame(Date = as.Date(pricetab[c(1:weeks), 1]), 
  	Cash = rep(cashvalue, weeks), 
  	           Equity = rep(equityvolume, weeks), 
  	                        Debt = rep(debtvolume, weeks), 
  	                        Gold = rep(goldvolume, weeks), 
  	                        Oil = rep(oilvolume, weeks))
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
  performance1 <- (tempdf[dim(tempdf)[1], 13] / 
                     tempdf[1, 13] -1)*100
  performance2 <- ((tempdf[dim(tempdf)[1], 13] / 
                      tempdf[1, 13])^(52/weeks)-1)*100
  mylist2 <- list(table = tempdf[,-c(2, 3, 4, 5, 12)], student = NA, 
                 ReturnSeries = tempdf$'Portfolio_Return', Return =  
                   round(performance1, 2), AnnualReturn = round(performance2, 2))
  return(mylist2)} 	           
# Load data============================
# Get the latest datafile.
#load('port20180323')
#load('trans20180323')
#data <- read.csv("Names.csv", stringsAsFactors = FALSE)
students <- c("Team1", "Team2", "Team3", "Team4")
#shinyApp(ui, server)
