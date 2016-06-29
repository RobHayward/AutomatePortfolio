# completeTrade R:  this will update transactions and the portfolio
completeTrade <- function(student, bs, Date, asset, volume, price){
  portfolioChange(student = student, asset = asset, volume = volume)
  #Next line does not work. 
  transactionRecord(student = student, bs = bs, asset = asset, size = amount, price = amount/size)
  myList <- list(size, portfolio, transactions)
  #return(myList)
}
completeTrade(student = "td126", bs = "Buy", Date = "2016-06-07", asset = "Equity", amount = 200)


portfolio <- portfolioChange("td126", "Equity", 50)
portfolio[["td126"]]
transactionRecord(student = "td126", bs = "Buy", asset = "Equity", size = 50, price = 2.5)
transactions[["td126"]]
