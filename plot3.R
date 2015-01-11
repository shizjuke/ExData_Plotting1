#read data
data <- read.table(file = "household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?")

# convert data$Data column to objects of class "Date" representing calendar dates
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#select rows
selected <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]

# concat columns Data and Time. Create column representing calendar dates and times
selected$DateTime = strptime(paste(selected$Date, selected$Time), format = "%Y-%m-%d %H:%M:%S")

# call to the device driver
png(file="plot3.png",width=480,height=480)

# set font family
par(family="sans")

#generate diagram
plot(Sub_metering_1 ~ as.POSIXct(DateTime), selected, type="l", col="black", xlab = "", ylab = "Energy sub metering")
lines(Sub_metering_2 ~ as.POSIXct(DateTime), selected, type="l", col="red")
lines(Sub_metering_3 ~ as.POSIXct(DateTime), selected, type="l", col="blue")

# add legend
legend("topright", lty=c(1,1,1), lwd=c(2.5,2.5,2.5),  col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# close PNG device
dev.off()
