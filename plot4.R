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
png(file = "plot4.png")

#defining the graphics grid
par(mfrow = c(2, 2))
#first plot row 1,col 1
plot(data$DateTime,data$Global_active_power,type="l",xlab="",
           ylab="Global Active Power")
#second plot row 1,col 2 oddly with c-axis label, how ugly!
plot(data$DateTime,data$Voltage,type="l",xlab="datetime",
           ylab="Voltage")
#third plot row 2,col 1
plot(data$DateTime,data$Sub_metering_1,type="l",xlab="",
           ylab="Energy sub metering")
lines(data$DateTime,data$Sub_metering_2,col="red")
lines(data$DateTime,data$Sub_metering_3,col="blue")
text<-c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
# legend without box lines needs to be slightly shifted to get a clean figure
# legend needs also to be scaled down a bit using cex
legend(x="topright",legend=text,col=c("black","red","blue"),
                  lwd=1,box.lty="blank",inset=0.01, cex = 0.9)
#fourth plot row 2,col 2
plot(data$DateTime,data$Global_reactive_power,type="l",xlab="datetime",
           ylab="Global_reactive_power")
# and closing the device
dev.off()