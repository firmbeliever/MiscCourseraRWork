## read data in, files must be in the working directory
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

## get the SCC values for motor vehicle emission sources, i.e. where Data.Category == Onroad
mvSCCs <- subset(scc, Data.Category == "Onroad")

## get the subset of emissions data for Baltimore, MD - fips of 24510
## and for LA Country- fips of 06037
## that is related to motor vehicles, ie where the SCC is in the list found above
baltMVData <- subset(nei, fips == "24510" & SCC %in% mvSCCs$SCC)
laMVData <- subset(nei, fips == "06037" & SCC %in% mvSCCs$SCC)

## sum the data by year for each
baltYearSums <- tapply(baltMVData$Emissions, baltMVData$year, sum)
laYearSums <- tapply(laMVData$Emissions, laMVData$year, sum)

## setup plot to create bar chart for each county
par(mfrow = c(1, 2))
barplot(baltYearSums, main = "Baltimore Motor Veh per Year", xlab = "Year", ylab = "Total MV Emissions")
barplot(laYearSums, main = "LA Motor Veh per Year", xlab = "Year", ylab = "Total MV Emissions")


## copy plot to png file
dev.copy(png, "plot6.png")
dev.off()