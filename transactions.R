# Now record the transactions.  The first column will have the date, 
# the second the transaction and the third the amount.  Next check that it is possible. 
transactionRecord <- function(student, asset, size, price){
  end <- dim(transactions[[student]])[1] + 1
  transactions[[student]][end, 1] <- Sys.Date()
  transactions[[student]][end, 2] <- asset
  transactions[[student]][end, 3] <- size
  transactions[[student]][end, 4] <- price
  transactions[[student]][end, 5] <- price * size
  return(transactions)
  }
transactions <- transactionRecord("td126", "Equity", 80, 20)
transactions[["td126"]]
