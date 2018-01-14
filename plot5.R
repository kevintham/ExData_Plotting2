rm(list=ls())

library('ggplot2')
library('dplyr')


if(!file.exists("exdata%2Fdata%2FNEI_data.zip")) {
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

plot5 <- function() {
  
  baltimore <- '24510'
  NEI_balt_onroad <- subset(NEI, fips==baltimore & type=='ON-ROAD')
  pm25_balt_onroad_year <- NEI_balt_onroad[,c('year','Emissions')] %>% 
    group_by(year) %>% summarise(Total.Emissions = sum(Emissions))
  
  g <- ggplot(pm25_balt_onroad_year, aes(year, Total.Emissions)) + geom_bar(stat='identity')
  g + ggtitle("Emissions from motor vehicle sources in Baltimore")
  ggsave('plot5.png')
  
  cat('Plot 5 has been saved in', getwd())
}

plot5()
