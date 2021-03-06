library(lubridate)
library(graphics)
rm(list = ls())
dFile<- "./exdata_data_household_power_consumption/household_power_consumption.txt"
if(file.exists(dFile)){cat("Found File")}

# convert Date data to class Date and filter data
#setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )


#df.raw<- read.delim(dFile, sep = ";", colClasses = c("myDate",NA,NA,NA,NA,NA,NA,NA,NA ))
#df.raw<- read.delim(dFile, header = TRUE, sep = ";", colClasses = c(NA,NA,NA,NA,NA,NA,NA,NA,NA ))
df.raw<- read.csv(dFile, header = TRUE, sep = ";", stringsAsFactors = F)
View(df.raw)
head(df.raw)

df.work<-df.raw
df.work$DateTime <- parse_date_time(paste(df.work$Date, df.work$Time), orders="dmy hms")

df.work$Date<- parse_date_time(df.work$Date, orders = "dmy")
df.work$Time<- paste(hour(df.work$Time),minute(df.work$Time),Second(df.work$Time),sep = ":")
head(df.work)
fromD<- parse_date_time('01/02/2007', orders="dmy")  
toD <-  parse_date_time('02/02/2007', orders="dmy")

df.final<-df.work[df.work$Date >= fromD & df.work$Date <= toD,]
View(df.work)
View(df.final)

#Convert columns to the right classes
cols = c(3, 4, 5, 6, 7, 8, 9)    
df.final[,cols] = apply(df.final[,cols], 2, function(x) as.numeric(as.character(x)))


head(df.final$DateTime, n =20)
plot(df.final$Global_active_power~df.final$DateTime, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

## Saving to file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
