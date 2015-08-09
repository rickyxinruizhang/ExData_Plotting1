plot2<-function(){

  file<-file("household_power_consumption.txt","r")
  file_con<-read.csv(file,colClasses="character",nrows=2057260, sep=";")
  
  file_con<-subset(file_con, Date=="2/2/2007"|Date=="1/2/2007")  
  
  time=strptime(paste(file_con$Date,file_con$Time,sep=","), "%d/%m/%Y, %H:%M:%S")
  at1<-time==strptime(paste("1/2/2007","00:00:00",sep=","), "%d/%m/%Y, %H:%M:%S")|
    time==strptime(paste("1/2/2007","23:59:00",sep=","), "%d/%m/%Y, %H:%M:%S")|
    time==strptime(paste("2/2/2007","23:59:00",sep=","), "%d/%m/%Y, %H:%M:%S")
   
  png(file="plot2.png")
  with(file_con, plot(time, as.numeric(Global_active_power),
                       col="black",ylab="Global active power (kilowatts)", main="",type="l",xlab="",xaxt="n"))
  axis.POSIXct(1, at=time[at1],labels= c("Sun", "Mon", "Tues", "Wed", "Thu", 
                               "Fri", "Sat")[as.POSIXlt((time[at1]+61))$wday + 1]
   )         
             
   dev.off()
}