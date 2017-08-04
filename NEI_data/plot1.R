## read data in, files must be in the working directory
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

## get the emissions sum for each year
yearSums <- tapply(nei$Emissions, nei$year, sum)

## plot the data
barplot(yearSums, main = "Total Emissions per Year", xlab = "Year", ylab = "Total Emissions")

## copy plot to png file
dev.copy(png, "plot1.png")
dev.off()
