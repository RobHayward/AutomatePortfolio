# Make changes to the portfolio.  
# where "amount" = size multiplied by price
portfolioChange <- function(student, bs, asset, volume, price){
if(student %in% students == FALSE) {
    warning("Not valid student")
} 
  if(asset %in% assets == FALSE) {
    warning("Not valid asset")
  }
# the <<- will assign the variable to the parent scope

if(bs == "Buy"){
portfolio[[student]][asset] <<- portfolio[[student]][asset] + volume * price
portfolio[[student]]["Cash"] <<- portfolio[[student]]["Cash"] - volume * price
} else {
 portfolio[[student]][asset] <<- portfolio[[student]][asset] - volume * price 
 portfolio[[student]]["Cash"] <<- portfolio[[student]]["Cash"] + volume * price
}
}
# I was told that 'Selling equity works but buying bond does not'.  
# Undefined column.  I think that this is okay now. 
# This is the test below. 
portfolioChange("yl136", "Buy", "Debt", 50, 2.5)
portfolioChange("yl136","Sell", "Equity", 50, 2.5)
portfolioChange("yl136", "Gold", 100)
portfolio[["yl136"]]

