students = c('Mark', "John")
myList <- list("Mark", "John")
d1 <- data.frame("Cash"= 1000000, "Equity" = 0, "Bonds" = 0) 
myList <- lapply(myList, function(x) d1)
names(myList) <- students
--------------------
# Now change portfolio of particular student
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
#-----------------------------------------k
myList["Mark"]
myList[1]
myList[[1]][2]
str(myList)
