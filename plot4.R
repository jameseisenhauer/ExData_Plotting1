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
sub4.hpd <- subset(hpd, hpd$Date == ymd("2007-02-01") | hpd$Date == ymd("2007-02-02"))
# merge date and time
sub4.hpd$Date <- paste(sub4.hpd$Date,sub4.hpd$Time)
sub4.hpd$Date <- ymd_hms(sub4.hpd$Date, tz ="GMT")


png(filename="plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
with(sub4.hpd, {
  plot(sub4.hpd$Date, sub4.hpd$Global_active_power, type="l", ylab="Global Active Power", xlab="")
  plot(sub4.hpd$Date, sub4.hpd$Voltage, type="l", xlab="datetime", ylab="Voltage")
  plot(sub4.hpd$Date,sub4.hpd$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
  lines(sub4.hpd$Date,sub4.hpd$Sub_metering_2, type="l", col="red")
  lines(sub4.hpd$Date,sub4.hpd$Sub_metering_3, type="l", col="blue")
  legend("topright",legend=c("sub_metering_1","sub_metering_2","sub_metering_3"), lty=c(1, 1, 1),   
         lwd=c(2.5, 2.5, 2.5),  
         col=c("black", "red", "blue"),  )
  plot(sub4.hpd$Date, sub4.hpd$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  
})

dev.off
