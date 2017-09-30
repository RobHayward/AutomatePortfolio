source('wrapper.R')
completeTrade('td126', "Buy", "Equity", 5000, 25.5)
completeTrade('td126', "Buy", "2017-09-28", "Equity", 5000, 25.5)
transactions[['td126']]
completeTrade('td126', "Sell", "2017-09-29", "Equity", 5000, 30.5)
completeTrade('td126', "Buy", "2017-09-29", "Debt", 20000, 100)
portfolio[['td126']]
#==============If we need to remove a line
portfolio[['td126']] <- portfolio[['td126']][5,]
portfolio[['td126']]
# Now eveluate.  
# this will mean calculating the returns. 