library(graphics)
library(lubridate)

df_csv <- read.csv("household_power_consumption.txt",sep = ";")
df_csv <- df_csv[df_csv$Date == "2/1/2007" | df_csv$Date == "2/2/2007",]
df_csv$Date <- mdy(df_csv$Date)
df_csv[df_csv=="?"] <- NA

df_csv$DateTime <- paste(df_csv$Date,df_csv$Time,sep=" ")
df_csv$DateTime <- as.POSIXct(df_csv$DateTime,format = "%Y-%m-%d %H:%M:%S")


df_csv$Sub_metering_1 <- as.numeric(df_csv$Sub_metering_1)
df_csv$Sub_metering_2 <- as.numeric(df_csv$Sub_metering_2)
df_csv$Sub_metering_3 <- as.numeric(df_csv$Sub_metering_3)
y_axis_limits <- as.numeric(seq(0,40,by=10))

plot(df_csv$DateTime,df_csv$Sub_metering_3, type= "l", main = "", xlab = "", ylab = "", col = "blue", ylim = c(0,35))
lines(df_csv$DateTime,df_csv$Sub_metering_2,type = "l", col = "red")
lines(df_csv$DateTime,df_csv$Sub_metering_1,type = "l", col = "black")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), y.intersp = 0.5, lty=1, col=c("black","red","blue")) #,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
title(ylab = "Energy sub metering")   

dev.copy(png,height = 480, width = 480, file= "plot3.png")
dev.off()