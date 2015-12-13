# Set working directory
setwd("/Users/mila/ExData_Plotting1")

# Download and unzip the file 
if(!file.exists("exdata-data-household_power_consumption.zip")) {
        temp <- tempfile()
        download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
        file <- unzip(temp)
        unlink(temp)
}

# Read the file
rawdata <- read.table(file, header=T, sep=";", na.strings="?")
dim(rd)
summary(rawdata)
class("rawdata$Date")
class("rawdata$Time")

# Convert the Date variable to the Date class
rawdata$Date2 <- as.Date(rawdata$Date,"%d/%m/%Y")

# Subset to dates we will be using, 2007-02-01 and 2007-02-02.
data <- subset(rawdata, Date2 == "2007-02-01" | Date2 == "2007-02-02")

# Convert the Time variable to the Time class
data$Time2 <- strptime(data$Time,"%H:%M:%S")

# Combine Date and Time
data$DateTime <- paste(data$Date, data$Time)
data$DateTime <-  strptime(data$DateTime , "%d/%m/%Y %H:%M:%S")


#### Plot 4 ####

# Open the PNG graphic device 
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")
par(mfrow = c(2, 2), mar = c(14, 6, 2, 2), cex=.5)

# Plot 4.1.
plot(data$DateTime, data$Global_active_power, xaxt=NULL, xlab = "", ylab = "Global Active Power", type="n")
lines(data$DateTime, data$Global_active_power, type="S")

# Plot 4.2.
plot(data$DateTime, data$Voltage, xaxt=NULL, xlab = "datetime", ylab = "Voltage", type="n")
lines(data$DateTime, data$Voltage, type="S")

# Plot 4.3.
plot(data$DateTime, data$Sub_metering_1, xaxt=NULL, xlab = "", ylab = "Energy sub metering", type="n")
lines(data$DateTime, data$Sub_metering_1, col = "black", type = "S")
lines(data$DateTime, data$Sub_metering_2, col = "red", type = "S")
lines(data$DateTime, data$Sub_metering_3, col = "blue", type = "S")
legend("topright", bty = "n", lty = c(1, 1), lwd = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Plot 4.4.
plot(data$DateTime, data$Global_reactive_power, xaxt=NULL, xlab = "datetime", ylab = "Global_reactive_power", type="n")
lines(data$DateTime, data$Global_reactive_power, type="S")

dev.off()