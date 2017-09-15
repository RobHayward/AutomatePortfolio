# will get the asset prices from the dates supplied and return dataframe. 
  priceMatrix <- function(Date = as.Date(Sys.Date()), 
                          assets = c("Equity", "Debt")){
    #create the data frame
  pricetab <- data.frame(Date = as.Date(Date), "Equity" = 0, "Debt" = 0)
      # checks that dates have data
      if(any(as.Date(Date) %in% da$Date) == FALSE){
    warning("Incorrect date")
  }
  if(any(assets %in% assets) == FALSE){
    stop("Asset does not exist")
  }
  # should return a vector of row values
  pricetab <- da[da$Date %in% as.Date(Date), ]
  rownames(pricetab) <- Date
  return(pricetab)
}
#assets <- c("Equity", "Debt")
setdates <-c("2002-07-30", "2002-07-31", "2002-08-01", "2002-08-02") 
try(priceMatrix(Date = as.Date(setdates), assets = c("Equity", "Debt")))

#This works but there is a warning ""