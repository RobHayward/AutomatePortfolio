# Price will go to the database and get the price.  
da <- read.csv("Portfolio/SPY.csv", stringsAsFactors = FALSE)
da$Date <- as.Date(da[,1], format = "%Y-%m-%d")
da <- da[, c(8, 7)]
head(da)
price <- da[da$Date == "2000-06-07",2]
# This trade function will return a trade based on the price for the day given and the number of shares. 
trade <- function(Date, volume){
  if(as.Date(Date) %in% da$Date == FALSE){
    warning("Incorrect date")
  }
  price <- da[da$Date == Date, 2]
  trade <- price * volume
  return(trade)
}
trade("2000-05-08", 20)

