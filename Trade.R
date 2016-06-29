# Trade R:  this will get  the price, make a transaction (two-way) and change the portfolio
# the asset will have to be changed eventually 
completeTrade <- function(student, bs, Date, asset, volume, price){
  portfolioChange(student = student, bs = bs, asset = asset, volume = volume)
  #Next line does not work. 
  transactionRecord(student = student, bs = bs, asset = asset, volume = volume, price = price)
}
completeTrade(student = "td126", bs = "Buy", Date = "2016-06-07", asset = "Equity", volume = 200, price = 23.50)


portfolio <- portfolioChange("td126", bs = "Buy", "Equity", 50)
portfolio[["td126"]]
transactionRecord(student = "td126", bs = "Buy", asset = "Equity", size = 50, price = 2.5)
transactions[["td126"]]
