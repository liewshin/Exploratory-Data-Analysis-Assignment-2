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

#Merge datasets
NEISCC <- merge(NEI,SCC,by="SCC")

#Subsetting and plotting
veh <- grepl("veh", NEISCC$Short.Name, ignore.case = TRUE)
NEISCCveh <- NEISCC[veh, ]
BCvehem <- NEISCCveh[NEISCCveh$fips == "24510",]
embyyearveh <- aggregate(Emissions ~ year, BCvehem, sum)
png('plot5.png')
ggplot(data = embyyearveh, aes(x = year, y = Emissions)) + geom_line() + xlab("Year") + ggtitle("Total PM2.5 Emissions from motor vehicle sources in Baltimore City from 1999 to 2008") + theme(plot.title = element_text(size = 10))
dev.off()