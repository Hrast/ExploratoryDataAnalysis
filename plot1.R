data<-read.table("./household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

data$Date<-as.Date(strptime(data$Date, format = "%d/%m/%Y"))

datesub <- ((as.POSIXlt(data$Date)$mday) == 1 | (as.POSIXlt(data$Date)$mday) == 2) & (as.POSIXlt(data$Date)$mon) == 1 & (as.POSIXlt(data$Date)$year) == 107 

cleandata <- data[datesub, ]

cleandata$Global_active_power<-as.numeric(cleandata$Global_active_power)

png(filename = "plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))
hist(cleandata$Global_active_power, main = "Global Active Power", col="Red", xlab="Global Active Power (kilowatts)")

dev.off()
