## Plots Global Active Power histogram for 2 days interval (01/Feb/2006 and 02/Feb/2006)

plot1 <- function(){
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
    
    ## convert date column
    data$Date <- as.Date(data$Date, "%d/%m/%Y")
    
    ## filter dates
    startDate <- as.Date("2007-02-01")
    endDate <- as.Date("2007-02-02")
    filteredData <- subset(data, Date >= startDate & Date <= endDate)
    
    png(file = "plot1.png")
    hist(filteredData$Global_active_power, main = "Global Active Power", 
         xlab = "Global Active Power (kilowatts)", col = "red")
    dev.off()
}