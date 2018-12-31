# This will be the groups but will be switched to student id when I do EC381
students <- c("Team1", "Team2", "Team3", "Team4")
# this should set the vector that is used everywhere else. 
assets <- c("Cash", "Equity", "Debt", "Gold", "Oil")
# set up the two lists that contain the transactios and the portfolios
portfolio <- as.list(students)
transactions <- as.list(students)
# d1 and d2 are the intermediary steps to great the two lists. 
# the first method is to put the elements together.  I am already breaking my
# rule to have the object assets determine everything
d1 <- data.frame("Date" = as.Date("2019-01-04"), "Cash"= 1000000, "Equity" = 0, "Debt" = 0, "Gold" = 0, "Oil" = 0) 
# the second is to create the variables with zero values 
Date <- as.Date(character())
BS <- factor(levels = c("Buy", "Sell"))
Asset <- factor(levels = assets)
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
# Now create the responses directory if it does not already exist. 
if(dir.exists('./ShinyDash/responses' ) == FALSE) {
  dir.create('./ShinyDash/responses')
}
  # We should now have 2 lists with assets for each student in the 
#portfolio and transacitons for each student in transactions and the responses dir.
# Could now remove d1, d2 and students to tidy up. 
# Now remove the unneeded parts
rm(d1, d2, Date, BS, Asset, Volume, Price, Total)
# 
