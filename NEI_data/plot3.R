## uses ggplot2
## uses dplyr

## read data in, files must be in the working directory
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

## get the subset of data for Baltimore, MD - fips of 24510
balt <- subset(nei, fips == "24510")

## group the Baltimore data by type and year, then get the sum of emissions for each grouping
grouped <- group_by(balt, type, year)
yearTypeSums <- summarise(grouped, emi = sum(Emissions))

## plot the emissions per year for each of the 4 types
print(qplot(year, emi, data = yearTypeSums, facets = .~type, xlab = "Year", ylab = "Total Emissions", main = "Baltimore Emissions By Type"))

## copy plot to png file
dev.copy(png, "plot3.png")
dev.off()