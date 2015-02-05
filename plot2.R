readdata <- function(file){
  # This fucntion is used in all 4 plots, it reads the file into
  # a data.frame. 
  print("reading file hold on....")
  data<-read.csv2(file , na.strings = "?",stringsAsFactors = FALSE, dec = ".")
  #  we could translate the day to the R standard like in the following:
  #
  #  data$Date <- lapply(data$Date,function(x) as.Date(x,"%d/%m/%Y"))
  #
  #  but since format is not really needed in selection we better adjust the 
  #  selected days to the date format in the file.
  
  print("selecting days")
  select <- data$Date == "1/2/2007" |data$Date == "2/2/2007"
  data[select,]
}

data<-readdata("household_power_consumption.txt")

print("merging day and time and coercing to POSIXct")
data$DateTime<-paste(data$Date,data$Time)
data$DateTime<-as.POSIXct(data$DateTime,"%d/%m/%Y %T",tz="GMT")
# opening the device
png(file = "plot2.png")
plot(data$DateTime,data$Global_active_power,type="l",xlab="",
     ylab="Global Active Power(kilowatts)")
# and closing the device
dev.off()
