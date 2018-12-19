library(shiny)
library(googlesheets)
library(shinythemes)
library(shinydashboard)
library(DT)

fields <- c("name", "asset", "action", "quantity")
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
# Load functions for Shiny
# This is the function for dates from valueDates.R
pick.wkday <- function(selday,start,end) {
  fwd.7 <- start + 0:6
  first.day <- fwd.7[as.numeric(format(fwd.7,"%w"))==selday]
  seq.Date(first.day,end,by="week")
}

# valueDates are the dates at which the portfolio will be valued. 
valueDates <- pick.wkday(5, as.Date("2019-01-01"), as.Date("2019-03-31"))

# This is priceTab.R
pricetab <- data.frame(Date = as.Date(valueDates), Equity = rep(NA, length(valueDates)),  Debt = rep(NA, length(valueDates)), Gold  = rep(NA, length(valueDates)), Oil = rep(NA, length(valueDates)))
pricetab[1, 2] <- NA
pricetab[1, 3] <- NA
pricetab[1, 4] <- NA
pricetab[1, 5] <- NA
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
# portfolioValue function that will react to the student
portfolioValue <- function(student, weeks = 13){
  portfolio[[student]][,1] <- as.Date(portfolio[[student]][,1])
  tempdf <- merge(pricetab, portfolio[[student]], by = "Date")
  tempdf$value <- tempdf[,2] * tempdf[, 5] + tempdf[, 3] * tempdf[, 6] + tempdf[, 4]
  tempdf <- tempdf[(duplicated(portfolio[[student]]$Date) &! duplicated(portfolio[[student]]$Date, 
                                                                        fromLast = TRUE) ) | (
                                                                          !duplicated(portfolio[[student]]$Date) &! duplicated(portfolio[[student]]$Date, 
                                                                                                                               fromLast = TRUE)), ]
  
  #tempdf <- tempdf[duplicated(tempdf$Date) &! duplicated(tempdf$Date, fromLast = TRUE), ]
  # create the lagged variable
  tempdf$valuel <- c(rep(NA, 1), tempdf$value)[1:length(tempdf$value)]
  # calculate the percentage
  tempdf$return <- round((tempdf$value - tempdf$valuel)/tempdf$valuel, digits = 6)
  colnames(tempdf) <- c("Date", "Equity_Price", "Debt_Price", "Cash_Holding", 
                        "Equity_Holding", "Debt_Holding", "Portfolio_Value",
                        "Lagged_Value", "Portfolio_Return")
  performance1 <- (tempdf[dim(tempdf)[1], 7] / 
                     tempdf[1, 7] -1)*100
  performance2 <- ((tempdf[dim(tempdf)[1], 7] / 
                      tempdf[1, 7])^(52/weeks)-1)*100
  mylist <- list(table = tempdf[,-8], student = student, ReturnSeries = 
                   tempdf$'Portfolio_Return', Return =  round(performance1, 2), 
                 AnnualReturn = round(performance2, 2))
  return(mylist)
}
portfoliobenchmarkValue <- function(fundvalue = 1000000, equityweight = 60, debtweight = 40,
                                    weeks = 13){
  equityvalue <- fundvalue * equityweight / 100
  debtvalue <- fundvalue * debtweight / 100
  cashvalue <- fundvalue * (100 - equityweight - debtweight)/100
  equitynumber <- equityvalue/pricetab[1,2]
  debtnumber <- debtvalue/pricetab[1,3]
  # now build the data.frame
  portfoliobenchmark <- data.frame(Date = pricetab[, 1], 
  	Cash = rep(cashvalue, dim(pricetab)[1]), Equity = rep(equitynumber, 
    dim(pricetab)[1]),  Debt = rep(debtnumber, dim(pricetab)[1]))
  tempdf <- merge(pricetab, portfoliobenchmark, by = "Date")
  tempdf$value <- tempdf[,2] * tempdf[, 5] + tempdf[, 3] * tempdf[, 6] + tempdf[, 4]
  # remove the duplicate weeks wtih two transactions
  tempdf <- tempdf[(duplicated(portfoliobenchmark$Date) &! 
                      duplicated(portfoliobenchmark$Date, fromLast = TRUE) ) | 
                     (!duplicated(portfoliobenchmark$Date) &! 
                        duplicated(portfoliobenchmark$Date, fromLast = TRUE)), ]
  #tempdf <- tempdf[duplicated(tempdf$Date) &! duplicated(tempdf$Date, fromLast = TRUE), ]
  # create the lagged variable
  tempdf$valuel <- c(rep(NA, 1), tempdf$value)[1:length(tempdf$value)]
  # calculate the percentage
  tempdf$return <- round((tempdf$value - tempdf$valuel)/tempdf$valuel, digits = 6)
  colnames(tempdf) <- c("Date", "Equity_Price", "Debt_Price", "Cash_Holding", 
                        "Equity_Holding", "Debt_Holding", "Portfolio_Value",
                        "Lagged_Value", "Portfolio_Return")
  performance1 <- (tempdf[dim(tempdf)[1], 7] / 
                     tempdf[1, 7] -1)*100
  performance2 <- ((tempdf[dim(tempdf)[1], 7] / 
                      tempdf[1, 7])^(52/weeks)-1)*100
  portfoliobenchmarkValue <- list(table = tempdf[,-8], student = "benchmark", ReturnSeries = 
                                    tempdf$'Portfolio_Return', Return =  round(performance1, 2), 
                                  AnnualReturn = round(performance2, 2))
  return(portfoliobenchmarkValue)  
  }
portfoliobenchmarkValue <- portfoliobenchmarkValue()
# Load data============================
# Get the latest datafile.
load('port20180323')
load('trans20180323')
data <- read.csv("Names.csv", stringsAsFactors = FALSE)
students <- data$Username
#shinyApp(ui, server)
