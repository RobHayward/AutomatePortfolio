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
portfolio[[student]][end, asset] <<- portfolio[[student]][end -1, asset] + volume 
portfolio[[student]][end, "Cash"] <<- portfolio[[student]][end -1, "Cash"] - volume * price
portfolio[[student]][end, "Date"] <<- Date
} else if (bs == "Sell") {
portfolio[[student]][end, asset] <<- portfolio[[student]][end -1, asset] - volume 
portfolio[[student]][end, "Cash"] <<- portfolio[[student]][end -1, "Cash"] + volume * price
portfolio[[student]][end, "Date"] <<- Date
}   else {
 portfolio[[student]][end, 3] <<- portfolio[[student]][end -1, 3]  
 portfolio[[student]][end, 4] <<- portfolio[[student]][end -1, 4]  
 portfolio[[student]][end, "Cash"] <<- portfolio[[student]][end -1, "Cash"] 
 portfolio[[student]][end, "Date"] <<- Date
}
}
# I was told that 'Selling equity works but buying bond does not'.  
# Undefined column.  I think that this is okay now. 
# This is the test below. 
#portfolioRecord(Date = "2017-07-05", "nad20", "Buy", "Debt", 50, 2.5)
#portfolio[["nad20"]]
#
