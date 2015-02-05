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
png(file = "plot3.png")
#plotting the three lines
plot(data$DateTime,data$Sub_metering_1,type="l",xlab="",
     ylab="Energy sub metering")
lines(data$DateTime,data$Sub_metering_2,col="red")
lines(data$DateTime,data$Sub_metering_3,col="blue")
# construction of the legend, text contains the variable names, lwd (or type) 
# must be set
text<-c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
legend(x="topright",legend=text,col=c("black","red","blue"),lwd=1)
# and closing the device
dev.off()