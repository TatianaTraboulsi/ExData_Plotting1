# Download the dataset in your working directory
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "ElectricPowerConsumption.zip", method = "curl")
# Extract the files from the zip folder
unzip("ElectricPowerConsumption.zip")
# Read data set
household <- read.table("household_power_consumption.txt", header=TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)
# Convert the Date variable to Date class
household$Date <- as.Date(household$Date,"%d/%m/%Y")
# Subset data to have the data from 2007-02-01 to 2007-02-02
household2007 <- subset(household, household$Date >= "2007-02-01")
household2007 <- subset(household2007, household2007$Date <= "2007-02-02")
# Add the Date information to the Time column
library(dplyr)
household2007 <- mutate(household2007, Time = paste(Date, Time))
# Convert Time variable to POSIXlt class
household2007$Time <- strptime(household2007$Time, "%Y-%m-%d %H:%M:%S")

# Set the parameters to have 4 plots in one graphics device
par(mfcol=c(2,2))

# Top left plot
with(household2007, plot(Time, Global_active_power, type="l", xlab = "", ylab = "Global Active Power"))

# Bottom left plot
with(household2007, plot(Time, Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering"))
points(household2007$Time, household2007$Sub_metering_2, type="l", col="red")
points(household2007$Time, household2007$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("black","red","blue"), y.intersp = 0.2, bty = "n", inset = -1/5)

# Top right plot
with(household2007, plot(Time, Voltage, type="l", xlab = "datetime", ylab = "Voltage"))

# Bottom right plot
with(household2007, plot(Time, Global_reactive_power, type="l", xlab = "datetime"))

# Save it as a png file
dev.copy(png, file="plot4.png")
dev.off()
