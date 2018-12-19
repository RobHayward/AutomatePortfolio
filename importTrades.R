# importTrades.R
# This will take the data from the Gfile and put it into the equivalent of the TradeRecord.R
library(googlesheets)
da <- loadData()
# just use token price for now. This needs to be automated so that it is 
# part of the Gfile.  See other notes. 
activeStudents <- unique(da[, 1])
for (i in 1:length(da)[1]){
  completeTrade(student = da[[i, 1]], Date = as.Date("2019-01-06"), bs = da[[i, 3]], asset = da[[i, 2]], volume = da[[i, 4]], price = 25)
}
#portfolio[['Team1']]
#portfolio[['Team2']]
#transactions[['Team1']]
#transactions[['Team2']]
