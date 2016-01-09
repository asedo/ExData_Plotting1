install.packages("Defaults")
library(lubridate)
library(graphics)

dFile<- "./exdata_data_household_power_consumption/household_power_consumption.txt"
if(file.exists(dFile)){cat("Found File")}

# convert Date data to class Date and filter data
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )


#df.raw<- read.delim(dFile, sep = ";", colClasses = c("myDate",NA,NA,NA,NA,NA,NA,NA,NA ))
df.raw<- read.delim(dFile, sep = ";", colClasses = c(NA,NA,NA,NA,NA,NA,NA,NA,NA ))

paste(df.raw$Date, df.raw$Time )
df.raw$DateTime <- parse_date_time(paste(df.raw$Date, df.raw$Time), orders="dmy hms")
df.raw$Date<- parse_date_time(df.raw$Date, orders = "dmy")
fromD<- parse_date_time('01/02/2007', orders="dmy")  
toD <-  parse_date_time('02/02/2007', orders="dmy")
df.work<-df.raw[df.raw$Date >= fromD & df.raw$Date <= toD,]

#Convert columns to the right classes
times <- strptime(df.work$Time, format='%H:%M:%S')
head(times)
cols = c(3, 4, 5, 6, 7, 8, 9)    
df.work[,cols] = apply(df.work[,cols], 2, function(x) as.numeric(as.character(x)))

class(hour(df.work$Time))

## Converting dates
datetime <- paste(as.Date(df.work$Date), df.work$Time)
head(datetime)
df.work$Datetime <- as.POSIXct(datetime)

head(df.work$Datetime, 20)
plot(df.work$Global_active_power~df.work$Datetime, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

## Saving to file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
