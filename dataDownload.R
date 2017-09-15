# Not sure that this is necessary.  Is the data okay?  Adjusted? 
# Download ETF data from Quandl
#https://www.quandl.com/api/v3/datasets/EOD/AAPL.csv?api_key=1gPFtK4HC_PNzHR2DPUD
da <- Quandl(code = 'SPY', start_date = "2001-01-01", end_date = "2017-09-10")
url <- 'https://www.quandl/api/v3/datasets/EOD/SPY.csv?api_key=1gPFtK4HC_PNzHR2DPUD'
da <- read.csv(url)
#Does not seem to work
#=========
for(i in c("SPY", "TLT")){
  link1 <- paste('../Trading/Database/', i, '.csv', sep = "")
  link2 <- paste('~/Downloads/', i, '.csv', sep = "")
  da1 <- read.csv(link1, stringsAsFactors = FALSE)
  da1$Index <- as.Date(da1$Index, format = "%Y-%m-%d")
  str(da1)
  da2 <- read.csv(link2)
  colnames(da2) <- c("Index", "open", "high", "low", "close", "adj", "volume")
  da2$Index <- as.Date(da2$Index, format = "%Y-%m-%d")
  da <- merge(da1, da2, by = "Index", all.y = TRUE)
#str(da2)
}
head(da)
tail(da)
head(da1)
head(da2)

# works but not elegant. 