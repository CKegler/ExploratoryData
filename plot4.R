# @file plot4.R
# @author Colin Kegler
# 
# plot4.R defines one method, plot4, which generates a plot of Global Active Power vs time (the 2 day period)
# extract from Jan 1 to Jan 2nd, 2007 
# source : https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
#
#  Special note:  The file "consumption.R" must be run as a pre-cursor to using the function plot1


plot4 <- function() {
    
    theColClasses = c(rep("numeric", 7), "Date")
    
    ## Read outcome data
    extract <- read.table("data_extract.txt",
                          header=TRUE,
                          sep=";",
                          na.strings = "?",
                          
                          #colClasses = theColClasses,
                          stringsAsFactors=FALSE,
                          
    )
    
    extract$timestamp <- as.POSIXct(extract$timestamp , format="%Y-%m-%d %H:%M:%S")
    
    # create a 2x2 grid to present the 4 plots
    par(mfrow=c(2,2))
    
    
    #Plot 1
    hist(extract$Global_active_power, 
         breaks=12, 
         freq=TRUE, 
         col="red", 
         main="Global Active Power", 
         xlab="Gloabl Active Power (kilowatts)", 
         ylab="Frequency"
    )
 
    #make custom axis labels and axisMark positions
    axisLabels = c("Thu", "Fri", "Sat")
    axisMarks <- as.POSIXct( c("2007-02-01 00:00:00","2007-02-02 00:00:00","2007-02-03 00:00:00") , format="%Y-%m-%d %H:%M:%S")
    
    #Plot2
    plot(extract$timestamp, extract$Voltage, xaxt='n',  type = "l", ylab="Voltage")
    axis.POSIXct(side=1,at=axisMarks,labels=axisLabels, las=2)
    
    #Plot 3
    # generate plot and create custom axis labels, parallel to X-axis, to accompany plot
    plot(extract$timestamp, extract$Sub_metering_1, col="black", xaxt='n', type = "l", ylab="Energy Sub Metering")
    lines(extract$timestamp, extract$Sub_metering_2, col="red")
    lines(extract$timestamp, extract$Sub_metering_3, col="blue")
    
    #add a custom legend
#     legendLines <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
#     legend('topright', names(extract)[4,5,6] , legendLines , col=c("black", "red", "blue"))
    axis.POSIXct(side=1,at=axisMarks,labels=axisLabels, las=2)
    
    #Plot4
    plot(extract$timestamp, extract$Global_reactive_power, xaxt='n',  type = "l", ylab="Gloabl Reactive Power (kilowatts)")
    axis.POSIXct(side=1,at=axisMarks,labels=axisLabels, las=2)
    
    dev.copy(png, file = "plot4.png")  ## Copy my plot to a PNG file
    dev.off()  ## Don't forget to close the PNG device!
    
}
