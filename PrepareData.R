# This will prepare the database.  At the moment it gets just SPY but I want to get Treasury as well and have columne names.  
# This will require downloading TlT data to the database, switching the path to that database and then amalgamating into da. 
# QQQ is not the right database but I will swap for TLT when it has been added to the database. 
da1 <- read.csv("../Trading/Database/newSPY.csv", stringsAsFactors = FALSE)
da2 <- read.csv("../Trading/Database/newTLT.csv", stringsAsFactors = FALSE)
da <- merge(x = da1, y = da2, by = "Date") 
da$Date <- as.Date(da[,1], format = "%Y-%m-%d")
da <- da[, c(1, 6, 12)]
colnames(da) <- c("Date", "Equity", "Debt")
#head(da)
#====================================================
# Create portfolio using the data from the gradebook.  This will use the student id so can automate email. 
data <- read.csv("../EC381/Official/EC381.csv", stringsAsFactors = FALSE)
students <- data$Username
#ma <- matrix(nrow = length(students), ncol = 3)
#da <- data.frame(ma, row.names = students)
assets <- c("Cash", "Equity", "Debt")
#colnames(da) <- assets
#head(data)
#----------------------------------
