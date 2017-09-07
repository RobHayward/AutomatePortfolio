# Make changes to the portfolio.  
# where "amount" = size multiplied by price
portfolioRecord <- function(Date = Sys.Date(), student, bs, asset, volume, price){
end <- dim(portfolio[[student]])[1] + 1
if(student %in% students == FALSE) {
    warning("Not valid student")
} 
  if(asset %in% assets == FALSE) {
    warning("Not valid asset")
  }
# the <<- will assign the variable to the parent scope

# This line will copy all the last line one lower before adding date and asset change
portfolio[[student]][end, ] <<- portfolio[[student]][end -1, ] 

if(bs == "Buy"){
portfolio[[student]][end, asset] <<- portfolio[[student]][end -1, asset] + volume * price
portfolio[[student]][end, "Cash"] <<- portfolio[[student]][end -1, "Cash"] - volume * price
portfolio[[student]][end, "Date"] <<- Date
} else {
 portfolio[[student]][end, asset] <<- portfolio[[student]][end -1, asset] - volume * price 
 portfolio[[student]][end, "Cash"] <<- portfolio[[student]][end -1, "Cash"] + volume * price
}
}
# I was told that 'Selling equity works but buying bond does not'.  
# Undefined column.  I think that this is okay now. 
# This is the test below. 
#portfolioRecord(Date = "2017-07-05", "td126", "Buy", "Debt", 50, 2.5)
#portfolioRecord("yl136","Sell", "Equity", 50, 2.5)
#portfolioRecord("yl136", "Gold", 100)
#portfolio[["yl136"]][2, assets] <- portfolio[["yl136"]][1, "Cash"] + 100
#portfolio[["yl136"]]
#
