# Create portfolio
data <- read.csv("Official/EC381.csv", stringsAsFactors = FALSE)
students <- data$Username
ma <- matrix(nrow = length(students), ncol = 3)
da <- data.frame(ma, row.names = students)
assets <- c("Cash", "Equity", "Bonds")
colnames(da) <- assets
head(da)
#----------------------------------
#Create transaction document
Date <- rep(as.Date("2017-01-02"), 62)
asset <- rep("cash", 62)
amount <- rep(1000, 62)
comment <- as.character(rep("Initial endowment", 62))
transactions <- data.frame(Date, students, asset, amount, comment, stringsAsFactors 
                           = FALSE)
head(transactions)
str(transactions)
# Just need to think about the factors. 
##-----------------------------------
trade <- function(student, asset, number){
  if(student %in% students == FALSE) {
    print("Not valid student")
} 
  if(asset %in% assets == FALSE) {
    print("Not valid asset")
}
# if we are to create individual transaction files get the file name
file <- paste("TransactionFIle", student, sep = "")
# find length of the file and add on extra
line <- dim(file)[1] + 1
#paste today's date in the date column
file[end, 1] <- Sys.Date()
file[end, 2] <- 

     }

file[line,]
class(Sys.Date())
trade("vaoa10", "Beer")
file = transactions
dim(transactions)

# transactions
trade <- function(name, asset, number){
  da[name, asset] <- da[name, asset] + number * transaction
}


  
  da[]
