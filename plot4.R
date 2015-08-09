

##------------ prepare data
    library(lubridate)
## read in file (alternate techniques may be used for optimization)
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

##------------ Plot 4 Panel of four plots
 
    png("plot4.png", width = 480, height = 480)
    par ( mfrow = c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
    
## panel A
    plot (housepwr2$datetimecombo, as.numeric(housepwr2$Global_active_power),
          type = "l",
          ylab = "Global Active Power",
          xlab = " ")

## panel B
    housepwr2$Voltage <- as.numeric(housepwr2$Voltage)
    plot (housepwr2$datetimecombo, housepwr2$Voltage,
          type = "l", col = "black",
          ylab = "Voltage",
          xlab = "datetime")

## panel C
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
    legend("topright", pch = 1, cex = 0.9, bty = "n",
           col = c("black", "red", "blue"),
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    par(new = FALSE)


## panel D
    plot (housepwr2$datetimecombo, housepwr2$Global_reactive_power,
          type = "l", col = "black",
          ylab = "Global_reactive_power",
          xlab = "datetime")
    
    par ( mfrow = c(1,1))
    dev.off()
