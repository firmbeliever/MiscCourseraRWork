## read data in, files must be in the working directory
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

## get the SCC values for motor vehicle emission sources, i.e. where Data.Category == Onroad
mvSCCs <- subset(scc, Data.Category == "Onroad")

## get the subset of emissions data for Baltimore, MD - fips of 24510 that is related to 
## motor vehicles, ie where the SCC is in the list found above
baltMVData <- subset(nei, fips == "24510" & SCC %in% mvSCCs$SCC)

yearSums <- tapply(baltMVData$Emissions, baltMVData$year, sum)

## plot the data
barplot(yearSums, main = "Total Baltimore Motor Vehicle Emissions per Year", xlab = "Year", ylab = "Total Emissions")


## copy plot to png file
dev.copy(png, "plot5.png")
dev.off()