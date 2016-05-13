## Set global options, working directory, and attach the packages called "downloader" and "lubridate"
options(digits = 4, error = recover, digits.secs = 2, header = TRUE)
setwd("/home/user/R/RworkDir")
library(downloader)
library(lubridate)

## Download and unzip the datafile from https://archive.ics.uci.edu
## RAW_DATA_FILE = https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip
download("https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip", dest = "household_power_consumption.zip", mode = "wb")
household_power_consumption.txt <- unzip("household_power_consumption.zip")

## Use read.csv() to creat dataframe from "household_power_consumption.txt" file
data0.df <- read.csv("household_power_consumption.txt", header = T, sep=";", na.strings="?")
str(data0.df)

## Convert Date & Time variables to Date/Weekday/Time class vectors using as.Date(), lubridate, and strptime()
Date2 <- as.Date(data0.df$Date, format = "%d/%m/%Y")
Weekday <- wday(Date2, label = T)
Time2 <- strptime(data0.df$Time, format = "%H:%M:%S")

## Add Date2, Weekday, and Time2 vectors to data0.df as new colume variables using cbind()
data1.df <- cbind(data0.df, Date2, Weekday, Time2)
names(data1.df)

## Sort dataframe by Date2, andthen by Weekday, and then by Time2
data2.df <- data1.df[order(data1.df$Date2, data1.df$Weekday, data1.df$Time2), ]
str(data2.df)
head(data2.df)

## Extract data rows from dates between 2007-02-01 and 2007-02-02
data3.df <- subset(data2.df, Date2 >= as.Date("2007-02-01"))
data4.df <- subset(data3.df, Date2 <= as.Date("2007-02-02"))
str(data4.df)
head(data4.df)

## Render plot4.R, which displays a four-panel display of plots, and then save as plot4.png file in working directory
png("plot4.png", res = 72)

par(mar = c(5.1, 4.1, 4.1, 2.1), mfrow = c(2,2))
plot(data4.df$Global_active_power, type = "l", xlab = "datetime", ylab = "Global Active Power (kilowatts)", xaxt = "n")
axis(x = NULL, at = c(1, 1440, 2880), side = 1, labels = c("Thu", "Fri", "Sat"))

plot(data4.df$Voltage, type = "l", xlab = "datetime", ylab = "Voltage", xaxt = "n")
axis(x = NULL, at = c(1, 1440, 2880), side = 1, labels = c("Thu", "Fri", "Sat"))

plot(data4.df$Sub_metering_1, type = "l", col = "black", xlab = "datetime", ylab = "Energy sub metering", xaxt = "n")
points(data4.df$Sub_metering_2, type = "l", col = "red", xlab = "datetime", ylab = "Energy sub metering", xaxt = "n")
points(data4.df$Sub_metering_3, type = "l", col = "blue", xlab = "datetime", ylab = "Energy sub metering", xaxt = "n")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, bty = "n")
axis(x = NULL, at = c(1, 1440, 2880), side = 1, labels = c("Thu", "Fri", "Sat"))

plot(data4.df$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power", xaxt = "n")
axis(x = NULL, at = c(1, 1440, 2880), side = 1, labels = c("Thu", "Fri", "Sat"))

dev.off()