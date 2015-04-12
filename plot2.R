# @file plot2.R
# @author Colin Kegler
# 
# plot2.R defines one method, plot2, which generates a plot of Global Active Power vs time (the 2 day period)
# extract from Jan 1 to Jan 2nd, 2007 
# source : https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
#
#  Special note:  The file "consumption.R" must be run as a pre-cursor to using the function plot1


plot2 <- function() {
    
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
   
    #make custom axis labels and axisMark positions
    axisLabels = c("Thu", "Fri", "Sat")
    axisMarks <- as.POSIXct( c("2007-02-01 00:00:00","2007-02-02 00:00:00","2007-02-03 00:00:00") , format="%Y-%m-%d %H:%M:%S")
    
    # generate plot and create custom axis labels, parallel to X-axis, to accompany plot
    plot(extract$timestamp, extract$Global_active_power, xaxt='n',  type = "l", ylab="Gloabl Active Power (kilowatts)")
    axis.POSIXct(side=1,at=axisMarks,labels=axisLabels, las=2)
    
    
     dev.copy(png, file = "plot2.png")  ## Copy my plot to a PNG file
     dev.off()  ## Don't forget to close the PNG device!
    
}
