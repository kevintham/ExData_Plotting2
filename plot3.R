library('ggplot2')
library('dplyr')
library('data.table')

if(!file.exists("exdata%2Fdata%2FNEI_data.zip")) {
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

plot3 <- function() {
  
  NEI_balt <- subset(NEI, fips=='24510')
  NEI_balt_year_type <- as.data.frame(with(NEI_balt,
                                           tapply(Emissions, list(year,type),sum)))
  setDT(NEI_balt_year_type,keep.rownames = TRUE)
  names(NEI_balt_year_type)[1] <- 'Year'
  
  NEI_balt_year_type <- NEI_balt_year_type %>% 
    gather(Type, Emissions, names(NEI_balt_year_type)[-1])
  
  g <- ggplot(NEI_balt_year_type, aes(Year, Emissions)) +
    geom_bar(stat='identity') + facet_wrap(~ Type) + ggtitle('Total emissions in Baltimore')
  
  ggsave('plot3.png')
  cat('Plot 3 has been saved in', getwd())
}

plot3()

