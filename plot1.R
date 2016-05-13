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

## Plot histogram called plot1.R and save as PNG file in working directory
png("plot1.png", width = 480, height = 480, units = "px", res = 72)
par(mar = c(4.5, 4.25, 3, 0.75))
hist(data4.df$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", ylim = c(0, 1200))
dev.off()