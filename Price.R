# Price will go to the database and get the price of assets and return a matrix.  
# In final version, This may get all the assets.
priceMatrix <- function(Date, assets){
  price <- matrix(rep(1, length(assets) + 1, ncol = 1))
  if(as.Date(Date) %in% da$Date == FALSE){
    warning("Incorrect date")
  }
  if(assets %in% assets == FALSE){
    stop("Asset does not exist")
  }
  for(i in length(assets) + 1){
    price[i,] <- da[da$Date == Date, i]
      }
 return(price)
}
assets <- c("Equity", "Debt")
#add bonds to this and make the database names "Equity" and "Bonds".
priceMatrix(Date = "2000-05-08", assets = assets)
#This does not work. 

