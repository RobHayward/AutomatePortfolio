#======weeklyPortfolioRollover====================
# this will update the portfolio each week by rollig over the portfolio's of 
# those students with no transactions
weeklyPortfolioRollover <- function(date = As.Date(), studentlist = activestudents){
otherstudents <- students[!(students %in% activestudents)] 
for(i in otherstudents){
  portfolioRecord(as.Date("2018-03-30"), i, asset = "None", 0, 0)
}
}

# this did not seem to work as a function but the components do work. 
