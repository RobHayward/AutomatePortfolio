# importTrades.R
# This will take the data from the responses file and put it into the equivalent of the TradeRecord.R
#library(googlesheets)
files <- list.files("ShinyDash/responses", full.names = TRUE)
data <- lapply(files, read.csv, stringsAsFactors = FALSE)
da <- do.call(rbind, data)
#da <- data.frame(loadData())
# just use token price for now. This needs to be automated so that it is 
# part of the Gfile.  See other notes. 
activestudents <- unique(da[, 1])
# the data comes from da and pricetab.  Pricetab is imported. 
for (i in 1:dim(da)[1]){
  completeTrade(student = da[i, 1], Date = pricetab[week, 1], bs = da[i, 3], asset = da[i, 2], volume = da[i, 4], price = pricetab[week, paste0(da[i, 2], "_price")])
}
#======weeklyPortfolioRollover====================
# this will update the portfolio each week by rollig over the portfolio's of 
# those students with no transactions
otherstudents <- students[!(students %in% activestudents)] 
  for(i in otherstudents){
    portfolioRecord(Date = pricetab[week, 1], student = i, asset = "Cash", 0, 0)
}

#transactions[['Team1']]
#transactions[['Team2']]
#transactions[['Team4']]
#transactions[['Team3']]
#portfolio[['Team1']]
#portfolio[['Team2']]
#portfolio[['Team3']]
#portfolio[['Team4']]

