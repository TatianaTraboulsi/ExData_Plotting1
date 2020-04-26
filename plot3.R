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

# Make the plot with data from Sub_metering_1 column
with(household2007, plot(Time, Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering"))
# Add data from Sub_metering_2 column
points(household2007$Time, household2007$Sub_metering_2, type="l", col="red")
# Add data from Sub_metering_3 column
points(household2007$Time, household2007$Sub_metering_3, type="l", col="blue")
# Add legend
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("black","red","blue"), y.intersp = 0.5)

# Save it as a png file
dev.copy(png, file="plot3.png")
dev.off()