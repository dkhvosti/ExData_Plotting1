library(graphics)
library(lubridate)

df_csv <- read.csv("household_power_consumption.txt",sep = ";")
df_csv <- df_csv[df_csv$Date == "1/2/2007" | df_csv$Date == "2/2/2007",]
df_csv$Date <- dmy(df_csv$Date)
df_csv[df_csv=="?"] <- NA

df_csv$DateTime <- paste(df_csv$Date,df_csv$Time,sep=" ")
df_csv$DateTime <- as.POSIXct(df_csv$DateTime,format = "%Y-%m-%d %H:%M:%S")

df_csv$Global_reactive_power <- as.numeric(df_csv$Global_reactive_power)
df_csv$Global_active_power <- as.numeric(df_csv$Global_active_power)
df_csv$Voltage <- as.numeric(df_csv$Voltage)

df_csv$Sub_metering_1 <- as.numeric(df_csv$Sub_metering_1)
df_csv$Sub_metering_2 <- as.numeric(df_csv$Sub_metering_2)
df_csv$Sub_metering_3 <- as.numeric(df_csv$Sub_metering_3)
y_axis_limits <- as.numeric(seq(0,40,by=10))

par(mfrow = c(2,2))

with(df_csv, {
    
    plot(DateTime, Global_active_power, xlab = "", ylab = "Global active power", type = "l")
    plot(DateTime,Voltage,type = "l",xlab = "datetime")
  
    plot(df_csv$DateTime,df_csv$Sub_metering_3, type= "l", main = "", xlab = "", ylab = "", col = "blue", ylim = c(0,35))
    lines(df_csv$DateTime,df_csv$Sub_metering_2,type = "l", col = "red")
    lines(df_csv$DateTime,df_csv$Sub_metering_1,type = "l", col = "black")

    #there is something with my installation of R. No matter what I do, the legend is not located correctly.
    #had to fiddle with border, inset, and location to make the legend similar to the example plots in plot3
    #cannot replicate the legend in plot 4. Normally "topright" should do it for legend location but it's not working for me
    legend("topright", bty= "n", cex = 0.8, y.intersp = 0.2, legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("black","red","blue")) #,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
    title(ylab = "Energy sub metering") 
    plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime")
    
})

dev.copy(png,height = 480, width = 480, file= "plot4.png")
dev.off()