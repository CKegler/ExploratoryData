read_electric_power <- function() {
    
    #[1] Read in the date column from power consumption dataset to determine index of beginning and end dates
    prelimColClasses = c("character",rep("NULL", 8))
    
    dateCol <- read.table(file="household_power_consumption.txt", colClasses=prelimColClasses,  sep = ";", header=TRUE, comment.char = "", flush=TRUE)
    
    dateCol$Date <- as.Date(dateCol$Date , "%d/%m/%Y")
    
    min20070201  <- min(grep(as.Date("2007-02-01")  , dateCol$Date))
    
    max20070202  <- max(grep(as.Date("2007-02-02")  , dateCol$Date))
    
    #[2] Now only read/scan in the subset of data for the pertinent date range.
    theColClasses = c("Date", "character",rep("numeric", 7))
    
    ## Read outcome data
    extract <- scan("household_power_consumption.txt",
                    # header=TRUE,
                    sep=";",
                    na.strings = "?",
                    what=list(Date="Date", Time="Time", 
                              Global_active_power="numeric" , 
                              Global_reactive_power="numeric",
                              Voltage="numeric", 
                              Global_intensity="numeric",
                              Sub_metering_1="numeric",
                              Sub_metering_2="numeric",
                              Sub_metering_3="numeric"
                    ),
                    #colClasses = theColClasses,
                    #stringsAsFactors=FALSE,
                    comment.char="",
                    
                    skip= min20070201,
                    nmax=  max20070202 - min20070201
    )
    
    extract <- within(extract, {timestamp=paste(extract$Date, extract$Time) })
    
    #extract <- within(extract, { timestamp=format(as.POSIXct(paste(extract$Date, extract$Time)), "%d/%m/%Y %H:%M:%S") })
    
    extract$timestamp <- as.POSIXct(extract$timestamp , format="%d/%m/%Y %H:%M:%S")
    #extract$Time <- as.Date(extract$Time , "%H:%M:%S")
    extract$Date <- NULL
    extract$Time <- NULL
    #extract
    
    # Use semi-colon delimiter, suppress row names, provide a header
    write.table(extract, "data_extract.txt", sep=";", na="?", row.names=FALSE, col.names=TRUE,append = FALSE) 
}
