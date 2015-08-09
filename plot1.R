plot1<-function(){
  file<-file("household_power_consumption.txt","r")
  file_con<-read.csv(file,colClasses = "character",nrows=2057260, sep=";")
  file_con<-subset(file_con, Date=="2/2/2007"|Date=="1/2/2007")  
#  head(file_con,6)
#  names(file_con)
#  class(file_con$Date)
#  head(file_con$Date, 10)[1]=="16/12/2006"
  png(file="plot1.png")
  with(file_con, hist(as.numeric(Global_active_power),col="red",xlab="Global active power (kilowatts)", main="Global Active Power"))
  dev.off()
}