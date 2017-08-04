## read just the data for 2007-02-01 and 2007-02-02
## starts on row 66638, includes 2880 rows
febData <- read.table("household_power_consumption.txt", header = FALSE, na.strings = "?", sep = ";", skip = 66637, nrows = 2880)

## read and assign the column names
colnms <- read.table("household_power_consumption.txt", sep = ";", nrows = 1)
names(febData) <- unlist(colnms)

## create histrogram of the global_active_power variable
hist(febData$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")

## copy plot to png file, default size is 480 x 480
dev.copy(png, "plot1.png")
dev.off()
