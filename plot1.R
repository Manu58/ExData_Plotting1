
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
  #  There are NA's in the data, but not in the days we select. checked with 
  #  sum(complete.cases(data))
   
  print("selecting days")
  select <- data$Date == "1/2/2007" |data$Date == "2/2/2007"
  data[select,]
}

data<-readdata("household_power_consumption.txt")
png(file = "plot1.png")
hist(data$Global_active_power,col="red",xlab="Global Active Power(kilowatts)",
     main="Global Active Power")
dev.off()

