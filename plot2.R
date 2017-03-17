# load necesary libraries
library(dplyr)
library(ggplot2)
library(lubridate)
library(scales)

# load data from file
consum <- read.csv("household_power_consumption.txt",sep = ";",na.strings = "?")

# filter obserations taken from 2007-02-01 and 2007-02-02
consum <- filter(consum, Date == "1/2/2007" | Date == "2/2/2007")

# format DateTime
consum <- transform(consum, DateTime =  as.POSIXct(strptime(paste(Date, Time,sep = "/"),format = "%d/%m/%Y/%H:%M:%S")) )

# create plot with ggplot2
qplot(geom="line",
      x = consum$DateTime,
      y = consum$Global_active_powe,
      xlab ="",
      ylab = "Global Active Power (kilowats)") + 
    scale_x_datetime(date_labels = "%a",breaks = date_breaks("1 day")) 

# save plot to a png file
dev.copy(png, file="plot2.png")
dev.off()
