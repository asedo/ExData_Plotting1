library(lubridate)
library(graphics)
rm(list = ls())
dFile<- "./exdata_data_household_power_consumption/household_power_consumption.txt"
if(file.exists(dFile)){cat("Found File")}

# convert Date data to class Date and filter data
df.raw<- read.csv(dFile, header = TRUE, sep = ";", stringsAsFactors = F)

df.work<-df.raw
df.work$DateTime <- parse_date_time(paste(df.work$Date, df.work$Time), orders="dmy hms")

df.work$Date<- parse_date_time(df.work$Date, orders = "dmy")
df.work$Time<- paste(hour(df.work$Time),minute(df.work$Time),Second(df.work$Time),sep = ":")
head(df.work)
fromD<- parse_date_time('01/02/2007', orders="dmy")  
toD <-  parse_date_time('02/02/2007', orders="dmy")

df.final<-df.work[df.work$Date >= fromD & df.work$Date <= toD,]

#Convert columns to the right classes
cols = c(3, 4, 5, 6, 7, 8, 9)    
df.final[,cols] = apply(df.final[,cols], 2, function(x) as.numeric(as.character(x)))

# to correct formatting issues, using the png device
dev.copy(png, file="plot4.png", height=480, width=480)

par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0)) 
   #plot 1
    plot(df.final$Global_active_power~df.final$DateTime, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
  #plot 2
    plot(df.final$Voltage~df.final$DateTime, type = "l", xlab = "datetime", ylab = "Voltage")
  #plot 3
  with(df.final, {plot(Sub_metering_1~DateTime , type = "l", xlab = "", ylab = "Energy sub metering")
    lines(Sub_metering_2~DateTime , col ="red")
    lines(Sub_metering_3~DateTime , col ="blue")  
  })
  
  legend("topright", inset = .01 ,box.lty=0 , col=c("black", "red", "blue"), lty=1, lwd=2, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  #plot 4
  plot(df.final$Global_reactive_power~df.final$DateTime, type = "l", xlab = "datetime", ylab = "Global Active Power (kilowatts)")
  
  
## Saving to file
dev.off()
