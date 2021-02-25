#Downloading and reading files
filename <- "exdata_data_NEI_data.zip"
if(!file.exists(filename)){dir.create("filename")
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "exdata_data_NEI_data.zip")
}
unzip("exdata_data_NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subsetting and plotting
BCem <- NEI[NEI$fips == "24510",]
png('plot2.png')
BCembyyear <- aggregate(Emissions ~ year, BCem, sum)
barplot(height=BCembyyear$Emissions, names.arg=BCembyyear$year, main="Total PM2.5 Emissions in Baltimore City from 1999 to 2008",ylab="Total PM2.5 Emissions", xlab="Year")
dev.off()