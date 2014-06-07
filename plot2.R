## james eisenhauer - Exploratory Data Analysis Project 1

library(lubridate)


### check for data file and download if missing
if (!file.exists("data/household_power_consumption.txt")){
  
  # create data folder  
  if (!file.exists("data")){
    dir.create("data")
  }
  # get the file url and download
  housepowerurl = paste('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', sep='')
  download.file(housepowerurl, destfile = "./data/housepower.zip", method = "curl")
  
  #unzip file
  unzip("./data/housepower.zip",overwrite = TRUE, exdir = "./data")
  
}

## end of get data file routine



## read data of file and put into var hpd(household power data) if it does not exist
if (!exists("hpd")){
  hpd <- read.table("./data/household_power_consumption.txt",header = TRUE, stringsAsFactors=FALSE, sep = ';', na.strings="?")
  #convert date to POSIXct class
  hpd$Date <- dmy(hpd$Date)
}


# subset data
sub.hpd <- subset(hpd, hpd$Date == ymd("2007-02-01") | hpd$Date == ymd("2007-02-02"))
# merge date and time
sub.hpd$Date <- paste(sub.hpd$Date,sub.hpd$Time)
sub.hpd$Date <- ymd_hms(sub.hpd$Date, tz ="GMT")
#create plot and save as png
png(filename="plot2.png", width = 480, height = 480)
plot(sub.hpd$Date, sub.hpd$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off
