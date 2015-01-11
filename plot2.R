#read data
data <- read.table(file = "household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?")

# convert data$Data column to objects of class "Date" representing calendar dates
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#select rows
selected <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]

# concat columns Data and Time. Create column representing calendar dates and times
selected$DateTime = strptime(paste(selected$Date, selected$Time), format = "%Y-%m-%d %H:%M:%S")

# call to the device driver
png(file="plot2.png",width=480,height=480)

# set font family and size
par(family="sans")

#generate diagram
plot(Global_active_power ~ as.POSIXct(DateTime), selected, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# close PNG device
dev.off()

