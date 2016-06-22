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
myList <- as.list(students)
d1 <- data.frame("Cash"= 1000000, "Equity" = 0, "Bonds" = 0) 
myList <- lapply(myList, function(x) d1)
names(myList) <- students
#================
# Make changes to the portfolio.  
portfolioChange <- function(student, asset, amount){
myList[[student]][asset] <- amount
if(student %in% students == FALSE) {
    print("Not valid student")
} 
  if(asset %in% assets == FALSE) {
    print("Not valid asset")
}
return(myList)
}
portfolioChange("Mark", "Cash", 999999)
portfolioChange("John", "Equity", 50)
==================================================
# Now record the transactions.  The first column will have the date, 
# the second the transaction and the third the amount.  Next check that it is possible. 
line <- dim(file)[1] + 1
#paste today's date in the date column
file[end, 1] <- Sys.Date()
file[end, 2] <- 


file[line,]
class(Sys.Date())
trade("vaoa10", "Beer")

# transactions
