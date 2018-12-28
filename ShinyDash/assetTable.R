# Download price tab
datafile <- gs_title('AssetData')
# switch this to pricetab once conversion is made. 
pricetab2 <- gs_read_csv(datafile)
pricetab2$Date = as.Date(pricetab2$Date, format = "%d/%m/%Y")
