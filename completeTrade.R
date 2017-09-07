# Trade R:  this will get  the price, make a transaction (two-way) and change the 
# portfolio. the asset will have to be changed eventually 
completeTrade <- function(student, bs, Date, asset, volume, price){
  portfolioRecord(Date = Date, student = student, bs = bs, asset = asset, 
                  volume = volume, price = price)
  #Next line does not work. 
  transactionRecord(Date = Date, student = student, bs = bs, asset = asset, 
                    volume = volume, price = price)
}
# This is a test.  It seems to work. 
#completeTrade(student = "td126", bs = "Buy", Date = "2016-06-07", asset = "Equity", 
#              volume = 200, price = 23.50)
#
## this seems to work. Not sure what portfoli and transactioRecord are about. 
#portfolio <- portfolioChange("td126", bs = "Buy", "Equity", 50, price = 50)
#portfolio[["td126"]]
#transactionRecord(student = "td126", bs = "Buy", asset = "Equity", size = 50, price = 2.5)
#transactions[["td126"]]
