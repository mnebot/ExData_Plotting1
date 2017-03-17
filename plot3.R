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
cols <- c("Sub_metering_1"="black","Sub_metering_2"="red","Sub_metering_3"="blue")
ggplot(consum, aes(DateTime)) +
    geom_line(aes(y = Sub_metering_1, colour = "Sub_metering_1")) + 
    geom_line(aes(y = Sub_metering_2, colour = "Sub_metering_2")) + 
    geom_line(aes(y = Sub_metering_3, colour = "Sub_metering_3")) +
    xlab("") +
    scale_y_continuous("Energy submetering") + 
    scale_colour_manual(name="",values=cols) + 
    theme(legend.justification=c(1,1), legend.position=c(1,1)) + 
    scale_x_datetime(date_labels = "%a",breaks = date_breaks("1 day")) 



# save plot to a png file
dev.copy(png, file="plot3.png")
dev.off()
