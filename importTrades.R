# importTrades.R
# This will take the data from the Gfile and put it into the equivalent of the TradeRecord.R
library(googlesheets)
da <- data.frame(loadData())
# just use token price for now. This needs to be automated so that it is 
# part of the Gfile.  See other notes. 
activeStudents <- unique(da[, 1])
# need to change the price eventually to come from database. 
for (i in 1:dim(da)[1]){
  completeTrade(student = da[[i, 1]], Date = as.Date("2019-01-04"), bs = da[[i, 3]], asset = da[[i, 2]], volume = da[[i, 4]], price = 25)
}
portfolio[['Team1']]
portfolio[['Team4']]
transactions[['Team3']]
transactions[['Team3']]

