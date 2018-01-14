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

plot6 <- function() {
  
  LA <- '06037'
  baltimore <- '24510'
  NEI_baLA_onroad <- subset(NEI, fips %in% c(LA, baltimore) & type=='ON-ROAD')
  pm25_baLA_onroad_year <- NEI_baLA_onroad[,c('fips','year','Emissions')] %>% 
    group_by(fips, year) %>% summarise(Total.Emissions = sum(Emissions))
  names(pm25_baLA_onroad_year)[1] <- 'city'
  pm25_baLA_onroad_year$city <- as.factor(pm25_baLA_onroad_year$city)
  levels(pm25_baLA_onroad_year$city) <- c('LA','Baltimore')
  
  g <- ggplot(pm25_baLA_onroad_year, aes(year, Total.Emissions))
  g + geom_bar(stat='identity') + facet_grid(city ~., scales='free_y') +
    ggtitle('Comparison of Motor Vehicle Emissions from LA and Baltimore')
  ggsave('plot6.png')
  
  cat('Plot 6 has been saved in', getwd())
}

plot6()

