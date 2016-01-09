install.packages("Defaults")
library(lubridate)
library(graphics)

dFile<- "./exdata_data_household_power_consumption/household_power_consumption.txt"
if(file.exists(dFile)){cat("Found File")}

# convert Date data to class Date and filter data
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )
df.raw<- read.delim(dFile, sep = ";", colClasses = c("myDate",NA,NA,NA,NA,NA,NA,NA,NA ))

fromD<- as.Date('01/02/2007', format='%d/%m/%Y')  
toD <- as.Date('02/02/2007', format='%d/%m/%Y')

df.work<-df.raw[df.raw$Date >= fromD & df.raw$Date <= toD,]

cols = c(3, 4, 5, 6, 7, 8, 9)    
df.work[,cols] = apply(df.work[,cols], 2, function(x) as.numeric(as.character(x)))
class(df.work[,5])

hist(df.work$Global_active_power,main = "Global Active Power", xlab = "Global Active Power", ylab = "Frequency", col = "red")

## Saving to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
