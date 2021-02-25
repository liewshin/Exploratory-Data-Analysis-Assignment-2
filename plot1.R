#Downloading and reading files
filename <- "exdata_data_NEI_data.zip"
if(!file.exists(filename)){dir.create("filename")
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "exdata_data_NEI_data.zip")
}
unzip("exdata_data_NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subsetting and plotting
embyyear <- aggregate(Emissions ~ year, NEI, sum)
png('plot1.png')
barplot(height=embyyear$Emissions, names.arg=embyyear$year, main="Total PM2.5 Emissions from 1999 to 2008",ylab="Total PM2.5 Emissions", xlab="Year")
dev.off()