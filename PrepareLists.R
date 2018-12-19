# set up the two lists that contain the transactios and the portfolios
portfolio <- as.list(students)
transactions <- as.list(students)
# the first method is to put the elements together
d1 <- data.frame("Date" = Sys.Date(), "Cash"= 1000000, "Equity" = 0, "Debt" = 0) 
# the second is to create the variables with zero values 
Date <- as.Date(character())
BS <- factor(levels = c("Buy", "Sell"))
Asset <- factor(levels = c("Cash", "Equity", "Debt"))
Volume <- numeric()
Price <- numeric()
Total <- numeric()
d2 <- data.frame(Date, BS, Asset, Volume, Price, Total)
portfolio <- lapply(portfolio, function(x) d1)
transactions <- lapply(transactions, function(x) d2)
names(portfolio) <- students
names(transactions) <- students
#str(portfolio)
#str(transactions)
  # We should now have 2 lists with assets for each student in the 
#portfolio and transacitons for each student in transactions. 
# Could now remove d1, d2 and students to tidy up. 
# Now remove the unneeded parts
rm(d1, d2, Date, BS, Asset, Volume, Price, Total, data)
# 
