## Exploratory Data Analysis
## Course Project 1
## May 7, 2014

setwd("~/Documents/Exploratory Data Analysis/Code")
alldata <- read.table ("./data/household_power_consumption 2.txt", header = T, 
                       sep = ";", na.strings = "?")
head(alldata)
str(alldata)

# Add a column where the original Date (factor variable) is converted to a date variable, 
# column = FDate

alldata$FDate <- as.Date(alldata$Date, "%d/%m/%Y")

# Make a vector containing only the dates of interest, called plotdates

plotdates <- as.Date(c("2/1/2007", "2/2/2007"), "%m/%d/%Y")

# Subset original data on dates of interest - new df = plotdata
plotdata <- subset(alldata, FDate %in% plotdates)

# Check to see if the dates we want are indeed there..                            
# > unique(plotdata$FDate)
# [1] "2007-02-01" "2007-02-02"
# Good to go

# Make a new combo column called DateTime, which we need for several graphs
plotdata$DateTime <- strptime(paste(plotdata$Date, plotdata$Time),
                              "%d/%m/%Y %H:%M:%S")

## PLOT3
## Need to plot Energy sub metering by day (multiple datasets on same graph)
## Sub_metering_1 = black, Sub_metering_2 = red, Sub_metering_3 = blue

# Open the png
png("plots/plot3.png", height = 480, width = 480)

# Make the plot
plot(plotdata$DateTime, plotdata$Sub_metering_1, type = "l", xlab = "",
     ylab = "Energy sub metering")
lines(plotdata$DateTime, plotdata$Sub_metering_2, col = "red")
lines(plotdata$DateTime, plotdata$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1,
       col = c("black", "red", "blue"))

# Close the png
dev.off()
