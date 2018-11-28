# postfile to psql
# https://www.r-bloggers.com/how-to-write-an-r-data-frame-to-an-sql-table/
library(RPostgresSQL)
drv <- dbDriver("PostgresSQL")
con <- dbConnect(drv, user = 'user')
password = 'password', dbname = 'my_database', host = 'host')
