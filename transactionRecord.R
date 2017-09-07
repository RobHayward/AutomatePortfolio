# Now record the transactions.  The first column will have the date, 
# the second the transaction and the third the amount.  Next check that it is possible. 
# Eventually, this can be combined wtih Price.R to comined volume and price
transactionRecord <- function(Date = Sys.Date(), student, bs, asset, volume, price){
#find the length of the transaction list
  end <- dim(transactions[[student]])[1] + 1
# This is not the best, could I apply? 
  transactions[[student]][end, 1] <<- Date
  transactions[[student]][end, 2] <<- bs
  transactions[[student]][end, 3] <<- asset
  transactions[[student]][end, 4] <<- volume
  if (bs == "Buy"){
  transactions[[student]][end, 5] <<- price
  transactions[[student]][end, 6] <<- price * volume
} else {
   transactions[[student]][end, 5] <<- -1 * price
   transactions[[student]][end, 6] <<- -1 * price * volume
}

  # Make an offsetting trasacton for cash. 
  
  transactions[[student]][end + 1, 1] <<- Date
  
  transactions[[student]][end + 1, 3] <<- "Cash"
  transactions[[student]][end + 1, 4] <<-  volume
  if (bs == "Buy"){
  transactions[[student]][end + 1, 2] <<- "Sell"
  transactions[[student]][end + 1, 5] <<- -1 * price
  transactions[[student]][end + 1, 6] <<- -1 * price * volume
  }
  else{
    transactions[[student]][end + 1, 2] <<- "Buy"
    transactions[[student]][end + 1, 5] <<- price
    transactions[[student]][end + 1, 6] <<- price * volume
  }
}
# this is the test below. This will eventually be taken out.
transactionRecord("2017-08-08", "td126", "Sell", "Equity", 60, 20)
#transactions[["td126"]]
