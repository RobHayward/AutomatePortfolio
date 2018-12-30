# storeTransactions.R
#This store the existing transactions and set up the new files
if(dir.exists("./ShinyDash/archive_responses") == FALSE) {
  dir.create("./ShinyDash/archive_responses")
}  
if(dir.exists(paste0(getwd(), "/ShinyDash/archive_responses/", 
                     pricetab[week, 1])) == FALSE) {
  dir.create(paste0(getwd(), "/ShinyDash/archive_responses/", pricetab[week, 1]))
}
newfiles <- list.files(paste0(getwd(), "/ShinyDash/responses"), full.names = TRUE)
file.copy(from = newfiles, to = paste0(getwd(), "/ShinyDash/archive_responses/", pricetab[week,1]))
# In case that needs to be done. 
#sapply(newfiles, function (x) file.copy(x, "/ShinyDash/archive_responses"))
# check that files are there and then
file.remove(list.files(paste0(getwd(), "/ShinyDash/responses/"), full.names = TRUE))

