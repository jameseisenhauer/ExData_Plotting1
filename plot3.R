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
sub3.hpd <- subset(hpd, hpd$Date == ymd("2007-02-01") | hpd$Date == ymd("2007-02-02"))
# merge date and time
sub3.hpd$Date <- paste(sub3.hpd$Date,sub3.hpd$Time)
sub3.hpd$Date <- ymd_hms(sub3.hpd$Date, tz ="GMT")

# create plot and save as png
png(filename="plot3.png", width = 480, height = 480)
plot(sub3.hpd$Date,sub3.hpd$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(sub3.hpd$Date,sub3.hpd$Sub_metering_2, type="l", col="red")
lines(sub3.hpd$Date,sub3.hpd$Sub_metering_3, type="l", col="blue")
legend("topright",legend=c("sub_metering_1","sub_metering_2","sub_metering_3"), lty=c(1, 1, 1),   
       lwd=c(2.5, 2.5, 2.5),  
       col=c("black", "red", "blue"),  )

dev.off
