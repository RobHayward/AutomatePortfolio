# Now record the transactions.  The first column will have the date, 
# the second the transaction and the third the amount.  Next check that it is possible. 
# Eventually, this can be combined wtih Price.R to comined size and price
transactionRecord <- function(student, bs, asset, size, price){
  end <- dim(transactions[[student]])[1] + 1
  transactions[[student]][end, 1] <- Sys.Date()
  transactions[[student]][end, 2] <- bs
  transactions[[student]][end, 3] <- asset
  transactions[[student]][end, 4] <- size
  transactions[[student]][end, 5] <- price
  transactions[[student]][end, 6] <- price * size
  return(transactions)
  }
transactions <- transactionRecord("td126", "Buy", "Equity", 80, 20)
transactions[["td126"]]
