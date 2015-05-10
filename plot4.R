## Plots global active power x time, global reactive power x time, 
## voltage x time and sub metering 1, 2 and 3 x time graphs for 
## 2 days interval (01/Feb/2006 and 02/Feb/2006)

plot4 <- function(){
    ## creates data directory if it doesn't exists
    if(!file.exists("data")){
        dir.create("data")
    }
    
    ## gets zip data from link, uncompress and read it
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    zipFileName <- "./data/household_power_consumption.zip"
    
    if(!file.exists(zipFileName)){
        download.file(url = url, zipFileName)
        ## store donwload date
        dateDownloaded <- date()
        print(paste("Donwload date: ", dateDownloaded))        
    }
    
    if(!file.exists("./data/household_power_consumption.txt")){
        print("Unzip file")
        unzip(zipFileName, files = "household_power_consumption.txt", exdir = "data")
    }
    
    print("Loading data")
    data <- read.csv("./data/household_power_consumption.txt", sep = ";", na.strings = "?")
    
    ## filter dates
    print("Filtering dates")
    startDate <- as.Date("2007-02-01")
    endDate <- as.Date("2007-02-02")
    filteredData <- subset(data, as.Date(Date, "%d/%m/%Y") >= startDate & as.Date(Date, "%d/%m/%Y") <= endDate)
    
    ## adds date time column
    print("Adding DateTime column")
    filteredData$DateTime <- strptime(paste(filteredData$Date, filteredData$Time), 
                                      "%d/%m/%Y %H:%M:%S", tz = "GMT")
    
    ## plotting data to file
    print("Plotting data to file")
    png(file = "plot4.png")

    ## setup 2 x 2 plotting
    par(mfcol = c(2, 2))
    
    ## Plots global active power 
    with(filteredData, plot(DateTime, Global_active_power, type = "l", 
                            xlab = "", ylab = "Global Active Power (kilowatts)"))
    
    ## Plots sub metering comparison
    with(filteredData, plot(DateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
    with(filteredData, lines(DateTime, Sub_metering_2, type = "l", col = "red"))
    with(filteredData, lines(DateTime, Sub_metering_3, type = "l", col = "blue"))
    legend("topright", lty = "solid", col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

    ## Plots voltage
    with(filteredData, plot(DateTime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))

    ## Plots global reactive power
    with(filteredData, plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime"))

    dev.off()
}