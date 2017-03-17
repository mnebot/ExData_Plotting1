# load necesary libraries
library(dplyr)
library(ggplot2)
library(lubridate)
library(scales)
library(gridExtra)

# load data from file
consum <- read.csv("household_power_consumption.txt",sep = ";",na.strings = "?")

# filter obserations taken from 2007-02-01 and 2007-02-02
consum <- filter(consum, Date == "1/2/2007" | Date == "2/2/2007")

# format DateTime
consum <- transform(consum, DateTime =  as.POSIXct(strptime(paste(Date, Time,sep = "/"),format = "%d/%m/%Y/%H:%M:%S")) )

# create individual plots with ggplot2
p1 <- qplot(geom="line",
            x = consum$DateTime,
            y = consum$Global_active_powe,
            xlab ="",
            ylab = "Global Active Power (kilowats)") + 
    scale_x_datetime(date_labels = "%a",breaks = date_breaks("1 day")) 

p2 <- qplot(geom="line",
            x = consum$DateTime,
            y = consum$Voltage,
            xlab ="datetime",
            ylab = "Voltage") + 
    scale_x_datetime(date_labels = "%a",breaks = date_breaks("1 day")) 

cols <- c("Sub_metering_1"="black","Sub_metering_2"="red","Sub_metering_3"="blue")
p3 <- ggplot(consum, aes(DateTime)) +
    geom_line(aes(y = Sub_metering_1, colour = "Sub_metering_1")) + 
    geom_line(aes(y = Sub_metering_2, colour = "Sub_metering_2")) + 
    geom_line(aes(y = Sub_metering_3, colour = "Sub_metering_3")) +
    xlab(" ") +
    scale_y_continuous("Energy submetering") + 
    scale_colour_manual(name="",values=cols) + 
    theme(legend.justification=c(1,1), legend.position=c(1,1)) + 
    scale_x_datetime(date_labels = "%a",breaks = date_breaks("1 day")) 

p4 <- qplot(geom="line",
            x = consum$DateTime,
            y = consum$Global_reactive_power,
            xlab = "datetime",
            ylab = "Global_reactive_power") + 
    scale_x_datetime(date_labels = "%a",breaks = date_breaks("1 day")) 

# Arrange plots on a grid
grid.arrange(p1,p2,p3,p4)

# save plot to a png file
dev.copy(png, file="plot4.png")
dev.off()