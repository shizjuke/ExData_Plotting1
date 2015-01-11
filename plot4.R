#read data
data <- read.table(file = "household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?")

# convert data$Data column to objects of class "Date" representing calendar dates
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#select rows
selected <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]

# concat columns Data and Time. Create column representing calendar dates and times
selected$DateTime = strptime(paste(selected$Date, selected$Time), format = "%Y-%m-%d %H:%M:%S")

# call to the device driver
png(file="plot4.png",width=480,height=480)

# set figures layout and font family
par(mfrow = c(2, 2), family="sans")

#generate up left diagram
plot(Global_active_power ~ as.POSIXct(DateTime), selected, type = "l", xlab = "", ylab = "Global Active Power")

#generate up right diagram
plot(Voltage ~ as.POSIXct(DateTime), selected, type = "l", xlab = "datetime")

#generate bottom left diagram
plot(Sub_metering_1 ~ as.POSIXct(DateTime), selected, type="l", col="black", xlab = "", ylab = "Energy sub metering")
lines(Sub_metering_2 ~ as.POSIXct(DateTime), selected, type="l", col="red")
lines(Sub_metering_3 ~ as.POSIXct(DateTime), selected, type="l", col="blue")
legend("topright", lty=c(1,1,1), lwd=c(2.5,2.5,2.5), bty = "n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#generate bottom right diagram
plot(Global_reactive_power ~ as.POSIXct(DateTime), selected, type = "l", xlab = "datetime")

# close PNG device
dev.off()