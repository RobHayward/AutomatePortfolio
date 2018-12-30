# PriceTab.R
# This will create the data.frame that holds the price data. 
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
pricetab[2, 2] <- 25
pricetab[2, 3] <- 25
pricetab[2, 4] <- 25
pricetab[2, 5] <-25 
#pricetab[2, 3] <- 
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