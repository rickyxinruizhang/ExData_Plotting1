plot3<-function(){
  Sys.setlocale("LC_ALL", "English")
  file<-file("household_power_consumption.txt","r")
  file_con<-read.csv(file,colClasses="character",nrows=2057260, sep=";")
  file_con<-subset(file_con, Date=="2/2/2007"|Date=="1/2/2007")  
  file_con<-transform(file_con, Sub_metering_1=as.numeric(Sub_metering_1),
                                Sub_metering_2=as.numeric(Sub_metering_2),
                                Sub_metering_3=as.numeric(Sub_metering_3))

  time=strptime(paste(file_con$Date,file_con$Time,sep=","), "%d/%m/%Y, %H:%M:%S")
  at1<-time==strptime(paste("1/2/2007","00:00:00",sep=","), "%d/%m/%Y, %H:%M:%S")|
    time==strptime(paste("1/2/2007","23:59:00",sep=","), "%d/%m/%Y, %H:%M:%S")|
    time==strptime(paste("2/2/2007","23:59:00",sep=","), "%d/%m/%Y, %H:%M:%S")
  
  png(file="plot3.png")
  with(file_con, plot(time,Sub_metering_1,type="l",col="black",xlab="",ylab="Engergy sub metering",xaxt="n"))
  with(file_con, points(time,Sub_metering_2,type="l", col="red"))  
  with(file_con, points(time,Sub_metering_3,type="l",col="blue"))  
  legend("topright",lty=c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  axis.POSIXct(1, at=time[at1],labels= c("Sun", "Mon", "Tues", "Wed", "Thu", 
                                         "Fri", "Sat")[as.POSIXlt((time[at1]+61))$wday + 1]
  )         
  dev.off()
}