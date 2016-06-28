# Trade R:  this will get  the price, make a transaction (two-way) and change the portfolio
# the asset will have to be changed eventually 
completeTrade <- function(student, bs, Date, asset, amount){
  size <- trade(Date, amount)
  portfolioChange(student = student, asset = asset, amount = amount)
  #Next line does not work. 
  #transactionRecord(student = student, bs = bs, asset = asset, amount, price = amount/size)
  return(portfolio)
}
completeTrade(student = "td126", bs = "Buy", Date = "2016-06-06", asset = "Equity", amount = 50)
portfolio[["td126"]]
