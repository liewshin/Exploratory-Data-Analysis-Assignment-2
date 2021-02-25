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

#Subsetting and data
veh <- grepl("veh", NEISCC$Short.Name, ignore.case = TRUE)
NEISCCveh <- NEISCC[veh, ]
BCvehem <- NEISCCveh[NEISCCveh$fips == "24510",]
LAvehem <- NEISCCveh[NEISCCveh$fips == "06037",]
BCembyyearveh <- aggregate(Emissions ~ year + fips, BCvehem, sum)
LAembyyearveh <- aggregate(Emissions ~ year + fips, LAvehem, sum)
totalveh <- rbind(BCembyyearveh,LAembyyearveh)

#Renaming fips for plotting
totalveh$fips[totalveh$fips == "24510"] <- "Baltimore County"
totalveh$fips[totalveh$fips == "06037"] <- "Los Angeles"
colnames(totalveh)[2] <- "County"

#Plot
png('plot6.png')
ggplot(data = totalveh, aes(x = year, y = Emissions, color = County)) + geom_line() + xlab("Year") + ggtitle("Total PM2.5 Emissions from motor vehicle sources")
dev.off()