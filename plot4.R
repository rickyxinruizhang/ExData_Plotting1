plot4<-function(){
  
  file<-file("household_power_consumption.txt","r")
  file_con<-read.csv(file,colClasses="character",nrows=2057260, sep=";")
  
  file_con<-subset(file_con, Date=="2/2/2007"|Date=="1/2/2007")  
  file_con<-transform(file_con, Global_active_power=as.numeric(Global_active_power))
  file_con<-file_con[!is.na(file_con$Global_active_power),]
  
  time=strptime(paste(file_con$Date,file_con$Time,sep=","), "%d/%m/%Y, %H:%M:%S")
  at1<-time==strptime(paste("1/2/2007","00:00:00",sep=","), "%d/%m/%Y, %H:%M:%S")|
    time==strptime(paste("1/2/2007","23:59:00",sep=","), "%d/%m/%Y, %H:%M:%S")|
    time==strptime(paste("2/2/2007","23:59:00",sep=","), "%d/%m/%Y, %H:%M:%S")
  tttt<<-sum(at1)
  png(file="plot4.png")
  par(mfrow=c(2,2))
  with(file_con, {
    #No.1
    plot(time, as.numeric(Global_active_power),
                      col="black",ylab="Global active power", main="",type="l",xlab="",xaxt="n")
    axis.POSIXct(1, at=time[at1],labels= c("Sun", "Mon", "Tues", "Wed", "Thu", 
                                           "Fri", "Sat")[as.POSIXlt((time[at1]+61))$wday + 1])

    #No.2
    plot(time, as.numeric(Voltage),
         col="black",ylab="Voltage", main="",type="l",xlab="datetime",xaxt="n")
    axis.POSIXct(1, at=time[at1],labels= c("Sun", "Mon", "Tues", "Wed", "Thu", 
                                           "Fri", "Sat")[as.POSIXlt((time[at1]+61))$wday + 1])
    
    #No.3
    plot(time,Sub_metering_1,type="l",col="black",xlab="",ylab="Engergy sub metering",xaxt="n")
    points(time,Sub_metering_2,type="l", col="red")
    points(time,Sub_metering_3,type="l",col="blue")  
    legend("topright",lty=c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n")
    axis.POSIXct(1, at=time[at1],labels= c("Sun", "Mon", "Tues", "Wed", "Thu", 
                                           "Fri", "Sat")[as.POSIXlt((time[at1]+61))$wday + 1])
    
    #No.4
    plot(time, as.numeric(Global_reactive_power),
         col="black",ylab="Global_reactive_power", main="",type="l",xlab="datetime",xaxt="n")
    axis.POSIXct(1, at=time[at1],labels= c("Sun", "Mon", "Tues", "Wed", "Thu", 
                                           "Fri", "Sat")[as.POSIXlt((time[at1]+61))$wday + 1])        
  })
  dev.off()
}