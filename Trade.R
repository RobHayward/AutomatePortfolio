# Trade R:  this will get  the price, make a transaction (two-way) and change the portfolio
# the asset will have to be changed eventually 
completeTrade <- function(student, bs, Date, asset, amount){
  size <- trade(Date, amount)
  portfolioChange(student = student, asset = asset, amount = amount)
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
