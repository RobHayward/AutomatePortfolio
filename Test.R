# This is just a test that the system works. 
source('wrapper.R')
completeTrade('td126', "Buy", "2017-09-28", "Equity", 5000, 25.0)
completeTrade('td126', "Buy", "2017-09-28", "Debt", 5000, 10.0)
transactions[['td126']]
completeTrade('td126', "Sell", "2017-09-29", "Equity", 5000, 23.0)
completeTrade('td126', "Buy", "2017-09-29", "Debt", 20000, 20.0)
portfolio[['td126']]
#==============If we need to remove a line
#portfolio[['td126']] <- portfolio[['td126']][6,]
portfolio[['td126']]
# Now eveluate.  
# this will mean calculating the returns. 