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

# Make the plot
with(household2007, plot(Time, Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)"))

# Save it as a png file
dev.copy(png, file="plot2.png")
dev.off()