if(!file.exists("exdata%2Fdata%2FNEI_data.zip")) {
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

plot1 <- function() {
  png(filename = 'plot1.png', width = 480, height = 480)
  pm25_year <- with(NEI, tapply(Emissions, year, sum))
  barplot(pm25_year, main='Total PM2.5 emission from all sources', xlab='Year',
          ylab='PM2.5')
  dev.off()
  cat('Plot 1 has been saved in', getwd())
}

plot1()