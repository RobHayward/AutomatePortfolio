# Make changes to the portfolio.  
# where "amount" = size multiplied by price
portfolioChange <- function(student, bs, asset, volume){
if(student %in% students == FALSE) {
    warning("Not valid student")
} 
  if(asset %in% assets == FALSE) {
    warning("Not valid asset")
  }
# the <<- will assign the variable to the parent scope

if(bs == "Buy"){
portfolio[[student]][asset] <<- volume
portfolio[[student]]["Cash"] <<- -1 * volume
} else {
 portfolio[[student]][asset] <<- -1 * volume
 portfolio[[student]]["Cash"] <<- volume
}
}
portfolioChange("yl136", "Buy", "Cash", 999999)
portfolioChange("yl136","Sell", "Equity", 50)
portfolioChange("yl136", "Gold", 100)
portfolio[["yl136"]]

