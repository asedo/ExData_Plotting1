install.packages("Defaults")
library(lubridate)
library(defaults)

dFile<- "./exdata_data_household_power_consumption/household_power_consumption.txt"
if(file.exists(dFile)){cat("Found File")}

# convert Date data to class Date and filter data
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )
df.raw<- read.delim(dFile, sep = ";", colClasses = c("myDate",NA,NA,NA,NA,NA,NA,NA,NA ))

fromD<- as.Date('01/02/2007', format='%d/%m/%Y')  
toD <- as.Date('02/02/2007', format='%d/%m/%Y')

df.work<-df.raw[df.raw$Date >= fromD & df.raw$Date <= toD,]



