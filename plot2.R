## Plots Global Active Power x time for 2 days interval (01/Feb/2006 and 02/Feb/2006)

plot2 <- function(){
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
    
    ## printing data to file
    print("Plotting data to file")    
    png(file = "plot2.png")
    plot(filteredData$DateTime, filteredData$Global_active_power, type = "l", 
         xlab = "", ylab = "Global Active Power (kilowatts)")
    dev.off()
}