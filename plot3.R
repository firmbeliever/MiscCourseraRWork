## read just the data for 2007-02-01 and 2007-02-02
## starts on row 66638, includes 2880 rows
## include one extra row for this chart to get Saturday cut-off on plot
febData <- read.table("household_power_consumption.txt", header = FALSE, na.strings = "?", sep = ";", skip = 66637, nrows = 2881)

## read and assign the column names
colnms <- read.table("household_power_consumption.txt", sep = ";", nrows = 1)
names(febData) <- unlist(colnms)

## convert Date column
febData$Date <- as.Date(febData$Date, "%d/%m/%Y")

## Add new column with date/time properly formatted
febData <- mutate(febData, formatted = as.POSIXct(paste(febData$Date, febData$Time)))

## plot the 3 different sub meters against new date/time column
plot(range(febData$formatted), range(febData$Sub_metering_1, febData$Sub_metering_2, febData$Sub_metering_3), type="n", ylab = "Engergy sub metering", xlab="")
lines(febData$formatted, febData$Sub_metering_1, col = "black")
lines(febData$formatted, febData$Sub_metering_2, col = "red")
lines(febData$formatted, febData$Sub_metering_3, col = "blue")

## add a legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)

## copy plot to png file, default size is 480 x 480
dev.copy(png, "plot3.png")
dev.off()