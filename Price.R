# This will create a dataframe with the prices of the assets on correct days
  priceMatrix <- function(Date = Sys.Date(), assets = c("Equity", "Debt")){
  pricetab <- data.frame("Date" = as.Date(Date), "Equity" = 0, "Debt" = 0)
  if(any(as.Date(Date) %in% da$Date) == FALSE){
    warning("Incorrect date")
  }
  if(any(assets %in% assets) == FALSE){
    stop("Asset does not exist")
  }
  pricetab <- da[da$Date %in% Date, c("Date", assets)]
  return(pricetab)
}
assets <- c("Equity", "Debt")
a <- priceMatrix(Date = as.Date("2002-07-30"))
a
# This ow seems to work.  Need to make sure that 
# there is a 'date' label to the first column