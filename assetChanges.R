#================
# Make changes to the portfolio.  
# where "amount" = size multiplied by price
portfolioChange <- function(student, asset, amount){
if(student %in% students == FALSE) {
    warning("Not valid student")
} 
  if(asset %in% assets == FALSE) {
    warning("Not valid asset")
  }
# the <<- will assign the variable to the parent scope
portfolio[[student]][asset] <<- amount
return(portfolio)
}
portfolioChange("yl136", "Cash", 999999)
portfolioChange("yl136","Equity", 50)
portfolioChange("yl136", "Gold", 100)
portfolio[["yl136"]]

