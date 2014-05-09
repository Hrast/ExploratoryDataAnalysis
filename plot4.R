data<-read.table("./household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

data$Date<-as.Date(strptime(data$Date, format = "%d/%m/%Y"))

datesub <- ((as.POSIXlt(data$Date)$mday) == 1 | (as.POSIXlt(data$Date)$mday) == 2) & (as.POSIXlt(data$Date)$mon) == 1 & (as.POSIXlt(data$Date)$year) == 107 

cleandata <- data[datesub, ]

cleandata$Time<-strptime(cleandata$Time, format = "%H:%M:%S")
cleandata$Global_active_power<-as.numeric(cleandata$Global_active_power)
cleandata$Global_reactive_power<-as.numeric(cleandata$Global_reactive_power)
cleandata$Voltage<-as.numeric(cleandata$Voltage)
cleandata$Sub_metering_1<-as.numeric(cleandata$Sub_metering_1)
cleandata$Sub_metering_2<-as.numeric(cleandata$Sub_metering_2)
cleandata$Sub_metering_3<-as.numeric(cleandata$Sub_metering_3)

timestamp=strptime(paste(format(cleandata$Date,"%Y-%m-%d"), format(cleandata$Time,"%H:%M:%S")), "%Y-%m-%d %H:%M:%S")

png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

par(mfcol=c(2,2))

with(cleandata, plot(Global_active_power, type="l", xlab = "", ylab="Global Active Power (kilowatts)",xaxt = "n"))
r <-c(1, nrow(cleandata)/2+1,nrow(cleandata))
s <-c(format(timestamp[r]+60, "%a"))
axis(1, r, s)

with(cleandata, plot(Sub_metering_1, type="l", xlab = "", ylab="Energy sub metering",xaxt = "n"))
with(cleandata, lines(Sub_metering_2, type="l", col="red" ))
with(cleandata, lines(Sub_metering_3, type="l", col="blue" ))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lwd=1,cex=0.8,bty="n")
r <-c(1, nrow(cleandata)/2+1,nrow(cleandata))
s <-c(format(timestamp[r]+60, "%a"))
axis(1, r, s)

with(cleandata, plot(Voltage, type="l", xlab = "datetime", xaxt = "n"))
r <-c(1, nrow(cleandata)/2+1,nrow(cleandata))
s <-c(format(timestamp[r]+60, "%a"))
axis(1, r, s)

with(cleandata, plot(Global_reactive_power, type="l", xlab = "datetime", xaxt = "n"))
r <-c(1, nrow(cleandata)/2+1,nrow(cleandata))
s <-c(format(timestamp[r]+60, "%a"))
axis(1, r, s)

dev.off()
