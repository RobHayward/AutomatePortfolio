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
write.csv(capture.output(print(portfolio),  file = "test3.csv")
          )
# from 
# https://stackoverflow.com/questions/27594541/export-a-list-into-a-csv-or-txt-file-in-r

# Below is another attempts.  Seems like two table writes,. 
# https://stat.ethz.ch/pipermail/r-help/2011-March/272076.html

out_file <- file("file.csv", open="a")  #creates a file in append mode
for (i in students){
  write.table(names(portfolio)[i], file=out_file, sep=",", dec=".", 
              quote=TRUE, col.names=FALSE, row.names=FALSE)  
  write.table(portfolio[[i]], file=out_file, sep=",", dec=".", quote=FALSE, 
              col.names=NA, row.names=TRUE)  #writes the data.frames
}
close(out_file)  #close connection to file.csv
#===============

#test
a <- data.frame(boy = c(1,2,3), girl = c(2, 3,4))
a
b <- data.frame(boy = c(2,3,4), girl = c(1, 2,3))
mylist <- list("a" = a, "b" = b)
mylist
write.table(gsub(" ", ",", capture.output(mylist)), file = "",quote = FALSE, 
            row.names = FALSE, col.names = FALSE, ",") 
mylist <- read.table('portrecord.txt', header = TRUE)
#=====================================
dput(portfolio, "./portfoliobackup")
