## read just the data for 2007-02-01 and 2007-02-02
## starts on row 66638, includes 2880 rows
## include one extra row for this chart to get Saturday cut-off on the plots
febData <- read.table("household_power_consumption.txt", header = FALSE, na.strings = "?", sep = ";", skip = 66637, nrows = 2881)

## read and assign the column names
colnms <- read.table("household_power_consumption.txt", sep = ";", nrows = 1)
names(febData) <- unlist(colnms)

## convert Date column
febData$Date <- as.Date(febData$Date, "%d/%m/%Y")

## Add new column with date/time properly formatted
febData <- mutate(febData, formatted = as.POSIXct(paste(febData$Date, febData$Time)))

## include 4 plots on this device, fill by row
par(mfrow=c(2,2))

##-------------- #1
## plot global active power against new date/time column
plot(range(febData$formatted), range(febData$Global_active_power), type="n", ylab = "Global Active Power (kilowatts)", xlab="")
lines(febData$formatted, febData$Global_active_power)

##-------------- #2
plot(range(febData$formatted), range(febData$Voltage), type="n", ylab = "Voltage", xlab="datetime")
lines(febData$formatted, febData$Voltage)


##-------------- #3
## plot the 3 different sub meters against new date/time column
plot(range(febData$formatted), range(febData$Sub_metering_1, febData$Sub_metering_2, febData$Sub_metering_3), type="n", ylab = "Engergy sub metering", xlab="")
lines(febData$formatted, febData$Sub_metering_1, col = "black")
lines(febData$formatted, febData$Sub_metering_2, col = "red")
lines(febData$formatted, febData$Sub_metering_3, col = "blue")

## add a legend, reduce its size so it is visible on png
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, bty = "n", cex = 0.7)

##-------------- #4
plot(range(febData$formatted), range(febData$Global_reactive_power), type="n", ylab = "Global_reactive_power", xlab="datetime")
lines(febData$formatted, febData$Global_reactive_power)

## copy plot to png file, default size is 480 x 480
dev.copy(png, "plot4.png")
dev.off()