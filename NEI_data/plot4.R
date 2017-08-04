## read data in, files must be in the working directory
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

## select all SCC values related to coal combustion, i.e. have 'coal' in the EI.Sector
coalSCC <- as.character(scc[grep("coal", tolower(scc$EI.Sector)), 1])

## subset the NEI data to just those rows with the coal SCC values
coalData <- subset(nei, SCC %in% coalSCC)


yearSums <- tapply(coalData$Emissions, coalData$year, sum)

## plot the data
barplot(yearSums, main = "Total Coal Emissions per Year", xlab = "Year", ylab = "Total Coal Emissions")


## copy plot to png file
dev.copy(png, "plot4.png")
dev.off()