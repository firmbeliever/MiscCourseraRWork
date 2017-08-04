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

## plot global active power against new date/time column
plot(range(febData$formatted), range(febData$Global_active_power), type="n", ylab = "Global Active Power (kilowatts)", xlab="")
lines(febData$formatted, febData$Global_active_power)

## copy plot to png file, default size is 480 x 480
dev.copy(png, "plot2.png")
dev.off()