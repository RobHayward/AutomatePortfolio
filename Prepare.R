# Create portfolio
data <- read.csv("Official/EC381.csv", stringsAsFactors = FALSE)
students <- data$Username
#ma <- matrix(nrow = length(students), ncol = 3)
#da <- data.frame(ma, row.names = students)
assets <- c("Cash", "Equity", "Bonds")
#colnames(da) <- assets
head(data)
#----------------------------------
# An alternative way would be to have a list of student names and to have 
# transactions and portfolio and other information in each member of the list. 
# Could use lapply to create documents and make changes. 
#students = c('Mark', "John")
portfolio <- as.list(students)
transactions <- as.list(students)
d1 <- data.frame("Cash"= 1000000, "Equity" = 0, "Bonds" = 0) 
d2 <- data.frame("Date" = as.Date(Sys.Date()), "Asset" = "", "Size" = 0, "Price" = 0)
portfolio <- lapply(portfolio, function(x) d1)
transactions <- lapply(transactions, function(x) d2)
names(portfolio) <- students
names(transactions) <- students
str(portfolio)
str(transactions)
# We should now have 2 lists with assets for each student in the portfolio and transacitons for each student in transactions. 

