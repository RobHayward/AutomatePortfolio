# this is a function to build a transaction list
portfoliolist <- 
for(i in students){
 #write.csv(portfolio[[i]], file = './portfoliolist.csv', append = TRUE)  
 a <- rbind(portfolio[[i]])
  #write.csv(a, file = './portfoliolist.csv')
}
a
a <- lapply(portfolio, function(x) write.table(data.frame(x), 
                                               'test.csv', append = T, sep = ","))
capture.output(summary(portfolio), file = 'test2.csv')
cat(capture.output(print(portfolio), file = "test.txt"))
write.csv(capture.output(print(portfolio),  file = "test3.csv"))
# from 
# https://stackoverflow.com/questions/27594541/export-a-list-into-a-csv-or-txt-file-in-r