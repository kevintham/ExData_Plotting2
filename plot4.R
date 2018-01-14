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

plot4 <- function() {
  
  coal_source <- grep(' Coal', as.character(SCC$Short.Name))
  SCC_coal <- SCC$SCC[coal_source]
  NEI_coal <- subset(NEI, SCC %in% SCC_coal)
  pm25_year_coal <- NEI_coal[c('year','Emissions')] %>% 
    group_by(year) %>% summarise(Total.Emissions = sum(Emissions))
  pm25_year_coal$year <- as.factor(pm25_year_coal$year)
  g <- ggplot(pm25_year_coal,aes(year,Total.Emissions)) + geom_bar(stat='identity')
  g + ggtitle('Emissions from coal combustion-related sources across the US')
  ggsave('plot4.png')
  cat('Plot 4 has been saved in', getwd())
}

plot4()
