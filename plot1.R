# load necesary libraries
library(dplyr)
library(ggplot2)

# load data from file
consum <- read.csv("household_power_consumption.txt",sep = ";",na.strings = "?")

# filter obserations taken from 2007-02-01 and 2007-02-02
consum <- filter(consum, Date == "1/2/2007" | Date == "2/2/2007") 

# create plot with ggplot2
qplot(consum$Global_active_power, 
      geom="histogram",
      main = "Global Active Power",
      xlab = "Global Active Power (kilowats)", 
      ylab = "Frequency",
      fill=I("red"),col=I("black"), 
      binwidth = .45,
      xlim = c(0,8))

# save plot to a png file
dev.copy(png, file="plot1.png")
dev.off()
