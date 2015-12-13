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

#### Plot 1 ####
# Open the PNG graphic device and print the histograpm with the y-axis scale 0 to 1200
lim <- c(0,1200)
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")
hist(data$Global_active_power,main="Global Active Power", xlab="Global Active Power (Killowats)",col="red",ylim=lim)

dev.off()