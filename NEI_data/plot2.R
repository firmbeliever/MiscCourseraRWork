## read data in, files must be in the working directory
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

## get the subset of data for Baltimore, MD - fips of 24510
balt <- subset(nei, fips == "24510")

## get the emissions sum for each year within the Baltimore subset
yearSums <- tapply(balt$Emissions, balt$year, sum)

## plot the data
barplot(yearSums, main = "Total Emissions in Baltimore MD per Year", xlab = "Year", ylab = "Total Emissions")

## copy plot to png file
dev.copy(png, "plot2.png")
dev.off()