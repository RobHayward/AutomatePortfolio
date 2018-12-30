#=====porttransRecoprd.R
# will create a backup of the portfoolio and transaction files
# this will save the transactions and portfolio data to a text file to be read 
# for the next session.  
# Create the "backup" directory if it does not exist
if(dir.exists("./ShinyDash/backup") == FALSE) {
  dir.create("./ShinyDash/backup")
}  
# comeback to automate the date.  Combinewith portfoliobackup. 
save(transactions, file = paste0("./ShinyDash/backup/trans", pricetab[week, 1]))
save(portfolio, file = paste0("./ShinyDash/backup/port", pricetab[week, 1]))

# I will also have the price record so that we can load that. 

