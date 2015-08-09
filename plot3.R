##------------ prepare data
library(lubridate)
## read in file to working directory
## (alternate techniques may be used for optimization)
    housepwr <- read.csv("household_power_consumption.txt", sep = ";",  stringsAsFactors = FALSE)

## select rows for two days Feb 1-2, 2007
    housepwr2  <- housepwr[(housepwr$Date %in% c("1/2/2007", "2/2/2007")),]

##  convert chr to date datatype
    housepwr2$datetimecombo <- strptime(paste(housepwr2$Date, housepwr2$Time), "%d/%m/%Y %H:%M:%S") 

##  prepare remaining data for all four plots
##  convert chr to numeric datatype (while there is a simpler approach
##  the following approach was chosen for incremental build & test)
    housepwr2$submeter1  <- as.numeric(housepwr2$Sub_metering_1)
    housepwr2$submeter2  <- as.numeric(housepwr2$Sub_metering_2)
    housepwr2$submeter3  <- housepwr2$Sub_metering_3
    housepwr2$Voltage    <- as.numeric(housepwr2$Voltage)
    housepwr2$Global_reactive_power <- as.numeric(housepwr2$Global_reactive_power)

##------------ Plot 3 untitled - overlay three sub-metering variables
    png("plot3.png", width = 480, height = 480)
    
    plot (housepwr2$datetimecombo, housepwr2$submeter1,
          type = "l",
          col  = "black",
          ylab = "Energy sub metering",
          xlab = " ")
    par (new = TRUE)
    lines (housepwr2$datetimecombo, housepwr2$submeter2,
           type = "l",
           col  = "red")
    lines (housepwr2$datetimecombo, housepwr2$submeter3,
           type = "l",
           col  = "blue")
    legend("topright", lty = c(1,1,1),
           col = c("black", "red", "blue"),
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    par (new = FALSE)
    dev.off()
