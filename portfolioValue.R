## Create a time series of portfolio value
## Take the Friday price as the valuation
pick.wkday <- function(selday,start,end) {
  fwd.7 <- start + 0:6
  first.day <- fwd.7[as.numeric(format(fwd.7,"%w"))==selday]
  seq.Date(first.day,end,by="week")
}
# valueDates are the dates at which the portfolio will be valued. 
valueDates <- pick.wkday(5, as.Date("2016-01-08"), as.Date("2016-03-20"))
# Now use the priceMatrix on the valueDates                   
pricetab <- priceMatrix("Date" = as.Date(valueDates), assets = c("Equity", "Debt"))
# this does return the matrix of dates and prices.  Now apply this to each portfolio. 
# there is an issue with the warning.  It only checks the first date. 
#-----------------------------------------
# this works with the Test.R run. 
pricetab <- data.frame(Date = c(as.Date("2017-09-28"), as.Date("2017-09-29"),
            as.Date("2017-10-01")), Equity = c(25.0, 23.0, 52.0), Debt = c(10.0, 20.0, 30.0))
#pricetab <- priceMatrix(Date = as.Date(valueDates), assets = c("Equity", "Debt"))
a <- merge(pricetab, portfolio[['td126']], by = "Date")
a$value <- a[,2] * a[, 5] + a[, 3] * a[, 6] + a[, 4]
# create the lagged variable
a$valuel <- c(rep(NA, 1), a$value)[1:length(a$value)]
# calculate the percentage
a$return <- (a$value - a$valuel)/a$valuel
a
# this works for one.  How do I apply across the students. Create function and use
# lapply?

