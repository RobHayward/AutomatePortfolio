    # This will prepare the database.  At the moment it gets just SPY but I want to get Treasury as well and have columne names.  
# This will require downloading TlT data to the database, switching the path to that database and then amalgamating into da. 
# QQQ is not the right database but I will swap for TLT when it has been added to the database. 
da1 <- read.csv("../Trading/Database/SPY.csv", stringsAsFactors = FALSE)
da2 <- read.csv("../Trading/Database/QQQ.csv", stringsAsFactors = FALSE)
da <- merge(x = da1, y = da2, by = "Index") 
da$Date <- as.Date(da[,1], format = "%Y-%m-%d")
da <- da[, c(14, 7, 13)]
colnames(da) <- c("Date", "Equity", "Debt")
#head(da)
#====================================================
# Create portfolio using the data from the gradebook.  This will use the student id so can automate email. 
data <- read.csv("Official/EC381.csv", stringsAsFactors = FALSE)
students <- data$Username
#ma <- matrix(nrow = length(students), ncol = 3)
#da <- data.frame(ma, row.names = students)
assets <- c("Cash", "Equity", "Debt")
#colnames(da) <- assets
#head(data)
#----------------------------------
# An alternative way would be to have a list of student names and to have 
# transactions and portfolio and other information in each member of the list. 
# Could use lapply to create documents and make changes. 
#students = c('Mark', "John")
# set up the two lists that contain the transactios and the portfolios
portfolio <- as.list(students)
transactions <- as.list(students)
# the first method is to put the elements together
d1 <- data.frame("Cash"= 1000000, "Equity" = 0, "Debt" = 0) 
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
str(portfolio)
str(transactions)
  # We should now have 2 lists with assets for each student in the 
#portfolio and transacitons for each student in transactions. 
# Could now remove d1, d2 and students to tidy up. 
# Now remove the unneeded parts
rm(da1, da2, d1, d2, Date, BS, Asset, Volume, Price, Total, data)
# 