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
# PLOT 4
# Paste in code from plots 1-3
# Construct 4th graph

# Open the png
png("plots/plot4.png", height = 480, width = 480)

# Construct the page layout
par(mfrow=(c(2,2))
    
# Add graph 2: Global Active Power by DateTime
plot(plotdata$DateTime, plotdata$Global_active_power,type="l", xlab = "", 
     ylab = "Global Active Power (kilowats)")

# Add new graph: Voltage by DateTime
plot(plotdata$DateTime, plotdata$Voltage,type="l", xlab = "datetime", 
     ylab = "Voltage")

# Add graph 3, no line around legend box
plot(plotdata$DateTime, plotdata$Sub_metering_1, type = "l", xlab = "",
     ylab = "Energy sub metering")
lines(plotdata$DateTime, plotdata$Sub_metering_2, col = "red")
lines(plotdata$DateTime, plotdata$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1,
       col = c("black", "red", "blue"), bty = "n")

# Add new graph: Global reactive power by datetime
with(plotdata, plot(DateTime, Global_reactive_power, xlab='datetime', pch=NA))
with(plotdata, lines(DateTime, Global_reactive_power))

dev.off()
