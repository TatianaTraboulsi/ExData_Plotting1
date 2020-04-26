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

# Make histogram
hist(household2007$Global_active_power, main= "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

# Save it as a png file (default values for width and height are 480)
dev.copy(png, file="plot1.png")
dev.off()