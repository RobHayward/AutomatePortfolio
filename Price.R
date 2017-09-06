#Chang will go to the database and get the price of assets and return a matrix.  
# In final version, This may get all the assets.
  priceMatrix <- function(Date = Sys.Date(), assets){
  pricetab <- data.frame(Date = as.Date(Date), "Equity" = 0, "Debt" = 0)
  #price <- matrix(rep(1, length(assets) + 1, ncol = 1))
  if(as.Date(Date) %in% da$Date == FALSE){
    warning("Incorrect date")
  }
  if(any(assets %in% assets) == FALSE){
    stop("Asset does not exist")
  }
  pricetab <- da[da$Date == Date, assets]
  rownames(pricetab) <- Date
  #price <- da[da$Date == Date, assets]
  #for(i in length(assets) + 1){
  #  price[i,] <- da[da$Date == Date, i]
  #    }
# return(price)
  return(pricetab)
}
assets <- c("Equity", "Debt")
a <- priceMatrix(Date = "2000-06-08", assets = assets)
a
# I have been changing this to be a dataframe so that it will print the date as well
# as the price.  I so not understand why it does not work.  When it works, 
# I can use this as input into the price past of the formula. 
