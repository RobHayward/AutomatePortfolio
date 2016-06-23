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
myList[[student]][asset] <- amount
return(myList)
}
portfolioChange("nm279", "Cash", 999999)
portfolioChange("cs734", "Equity", 50)
portfolioChange("cs734", "Gold", 100)
