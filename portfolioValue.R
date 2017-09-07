## Create a time series of portfolio value
## Take the Friday price as the valuation
pick.wkday <- function(selday,start,end) {
  fwd.7 <- start + 0:6
  first.day <- fwd.7[as.numeric(format(fwd.7,"%w"))==selday]
  seq.Date(first.day,end,by="week")
}
# valueDates are the dates at which the portfolio will be valued. 
valueDates <- pick.wkday(5, as.Date("2016-01-01"), as.Date("2016-03-31"))
# Now use the priceMatrix on the valueDates                   
priceMatrix(Date = valueDates, assets = assets)
# this does return the matrix of dates and prices.  Now apply this to each portfolio. 
# there is an issue with the warning.  It only checks the first date. 
#-----------------------------------------
# pricetab <- data.frame(Date = c("2017-09-07", "2017-09-05", "2017-09-01"), 
# Equity = c(2, 3, 5), Debt = c(10, 20, 30))
a <- merge(pricetab, portfolio[['td126']], by = "Date")
a$value <- a[,2] * a[, 5] + a[, 3] * a[, 6] + a[, 4]
# create the lagged variable
a$valuel <- c(rep(NA, 1), a$value)[1:length(a$value)]
# calculate the percentage
a$return <- (a$value - a$valuel)/a$valuel
a
# this works for one.  How do I apply across the students. Create function and use
# lapply?

