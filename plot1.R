library(graphics)

df_csv <- read.csv("household_power_consumption.txt",sep = ";")
df_csv <- df_csv[df_csv$Date == "1/2/2007" | df_csv$Date == "2/2/2007",]
df_csv[df_csv=="?"] <- NA
df_csv[,3] <- as.numeric(df_csv[,3])
x_axis_limits <- as.numeric(seq(0,6,by=2))

hist( df_csv[,3], xaxt = "n", main = "", xlab = "", ylab = "Frequency", xlim = c(0,8), col = "red") 
     
title(main = "Global Active Power",xlab = "Global Active Power (kilowatts)")#, ylab = "Frequency")   
axis(1,at = x_axis_limits)

dev.copy(png,height = 480, width = 480, file= "plot1.png")
dev.off()