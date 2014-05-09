data<-read.table("./household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

data$Date<-as.Date(strptime(data$Date, format = "%d/%m/%Y"))

datesub <- ((as.POSIXlt(data$Date)$mday) == 1 | (as.POSIXlt(data$Date)$mday) == 2) & (as.POSIXlt(data$Date)$mon) == 1 & (as.POSIXlt(data$Date)$year) == 107 

cleandata <- data[datesub, ]

cleandata$Time<-strptime(cleandata$Time, format = "%H:%M:%S")
cleandata$Global_active_power<-as.numeric(cleandata$Global_active_power)

timestamp=strptime(paste(format(cleandata$Date,"%Y-%m-%d"), format(cleandata$Time,"%H:%M:%S")), "%Y-%m-%d %H:%M:%S")

png(filename = "plot2.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

with(cleandata, plot(Global_active_power, type="l", xlab = "", ylab="Global Active Power (kilowatts)",xaxt = "n"))
r <-c(1, nrow(cleandata)/2+1,nrow(cleandata))
s <-c(format(timestamp[r]+60, "%a"))
axis(1, r, s)

dev.off()
