# @file plot1.R
# @author Colin Kegler
# 
# plot1.R defines one method, plot1, which generates a histogram of Global Active Power. The historgram is based on a data
# extract from Jan 1 to Jan 2nd, 2007 from the  UC Irvine Machine Learning Repository
# source : https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
#
#  Special note:  The file "consumption.R" must be run as a pre-cursor to using the function plot1


plot1 <- function() {
    
    theColClasses = c(rep("numeric", 7), "Date")
    
    ## Read outcome data
    extract <- read.table("data_extract.txt",
                          header=TRUE,
                          sep=";",
                          na.strings = "?",
                          
                          #colClasses = theColClasses,
                          stringsAsFactors=FALSE,
                          
    )
  
    extract$timestamp <- as.POSIXct(extract$timestamp , format="%d/%m/%Y %H:%M:%S")
  
    hist(extract$Global_active_power, 
         breaks=12, 
         freq=TRUE, 
         col="red", 
         main="Global Active Power", 
         xlab="Gloabl Active Power (kilowatts)", 
         ylab="Frequency"
         )
    
    dev.copy(png, file = "plot1.png")  ## Copy my plot to a PNG file
    dev.off()  ## Don't forget to close the PNG device!
    
}
