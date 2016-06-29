# Now record the transactions.  The first column will have the date, 
# the second the transaction and the third the amount.  Next check that it is possible. 
# Eventually, this can be combined wtih Price.R to comined size and price
transactionRecord <- function(student, bs, asset, size, price){
  end <- dim(transactions[[student]])[1] + 1
  transactions[[student]][end, 1] <<- Sys.Date()
  transactions[[student]][end, 2] <<- bs
  transactions[[student]][end, 3] <<- asset
  transactions[[student]][end, 4] <<- size
  transactions[[student]][end, 5] <<- price
  transactions[[student]][end, 6] <<- price * size
# Make an offsetting trasacton for cash. 
  if (bs == "Buy"){
  transactions[[student]][end + 1, 1] <<- Sys.Date()
  transactions[[student]][end + 1, 2] <<- "Sell"
  transactions[[student]][end + 1, 3] <<- "Cash"
  transactions[[student]][end + 1, 4] <<- -1 * size
  transactions[[student]][end + 1, 5] <<- -1 * price
  transactions[[student]][end + 1, 6] <<- -1 * price * size
  }
  else{
    transactions[[student]][end + 1, 1] <<- Sys.Date()
    transactions[[student]][end + 1, 2] <<- "Buy"
    transactions[[student]][end + 1, 3] <<- "Cash"
    transactions[[student]][end + 1, 4] <<- size
    transactions[[student]][end + 1, 5] <<- price
    transactions[[student]][end + 1, 6] <<- price * size
  }
  
  }
transactionRecord("td126", "Sell", "Equity", 80, 20)
transactions[["td126"]]
