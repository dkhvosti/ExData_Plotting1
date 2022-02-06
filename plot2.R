library(graphics)
library(lubridate)

df_csv <- read.csv("household_power_consumption.txt",sep = ";")
df_csv <- df_csv[df_csv$Date == "1/2/2007" | df_csv$Date == "2/2/2007",]
df_csv$Date <- dmy(df_csv$Date)
df_csv$day <- weekdays(df_csv$Date)
df_csv$DateTime <- paste(df_csv$Date,df_csv$Time,sep=" ")
df_csv$DateTime <- as.POSIXct(df_csv$DateTime,format = "%Y-%m-%d %H:%M:%S")

df_csv[df_csv=="?"] <- NA
df_csv[,3] <- as.numeric(df_csv[,3])
#x_axis_limits <- as.numeric(seq(0,6,by=2))

with( df_csv, plot(DateTime,Global_active_power, type= "l", main = "", xlab = "", ylab = "") )
     
title(xlab = "", ylab = "Global Active Power (kilowatts)")   
axis(1,at = x_axis_limits)

dev.copy(png,height = 480, width = 480, file= "plot2.png")
dev.off()