if(!file.exists("exdata%2Fdata%2FNEI_data.zip")) {
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

plot2 <- function() {
  
  png(filename = 'plot2.png', width = 480, height = 480)
  pm25_balt <- with(NEI[NEI$fips=='24510',], tapply(Emissions, year, sum))
  
  barplot(pm25_balt, main='Total PM2.5 emission from all sources in Baltimore', xlab='Year',
          ylab='PM2.5')
  
  dev.off()
  cat('Plot 2 has been saved in', getwd())
}

plot2()
