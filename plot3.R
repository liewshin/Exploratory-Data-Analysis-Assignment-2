#Installing Packages
if(!require(tidyverse)){
        install.packages("tidyverse")
}
library(tidyverse)

#Downloading and reading files
filename <- "exdata_data_NEI_data.zip"
if(!file.exists(filename)){dir.create("filename")
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "exdata_data_NEI_data.zip")
}
unzip("exdata_data_NEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subsetting and plotting
BCem <- NEI[NEI$fips == "24510",]
embyyearandtype <- aggregate(Emissions ~ year + type, BCem, sum)
png('plot3.png')
ggplot(data = embyyearandtype, aes(x = year, y = Emissions, color = type)) + geom_line() + xlab("Year") + ggtitle("Total PM2.5 Emissions in Baltimore City from 1999 to 2008 by Type")
dev.off()