# Read the data into a table and subset only the dates needed
power_cons <- read.table("household_power_consumption.txt", sep = ";", skip = 1, col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))
sub_power_cons <- subset(power_cons, power_cons$Date == "1/2/2007" | power_cons$Date == "2/2/2007")

#Convert Classes into Appropriate Classes
sub_power_cons$Date <- as.Date(sub_power_cons$Date, format="%d/%m/%Y")
sub_power_cons$Time <- strptime(sub_power_cons$Time, format="%H:%M:%S")
sub_power_cons[1:1440,"Time"] <- format(sub_power_cons[1:1440,"Time"],"2007-02-01 %H:%M:%S")
sub_power_cons[1441:2880,"Time"] <- format(sub_power_cons[1441:2880,"Time"],"2007-02-02 %H:%M:%S")
sub_power_cons$Global_active_power <- as.numeric(sub_power_cons$Global_active_power)
sub_power_cons$Global_reactive_power <- as.numeric(sub_power_cons$Global_reactive_power)
sub_power_cons$Voltage <- as.numeric(sub_power_cons$Voltage)
sub_power_cons$Global_intensity <- as.numeric(sub_power_cons$Global_intensity)
sub_power_cons$Sub_metering_1 <- as.numeric(sub_power_cons$Sub_metering_1)
sub_power_cons$Sub_metering_2 <- as.numeric(sub_power_cons$Sub_metering_2)
sub_power_cons$Sub_metering_3 <- as.numeric(sub_power_cons$Sub_metering_3)

#Plot #3
with(sub_power_cons, plot(Time, Sub_metering_1, type = "l", xlab="", ylab="Energy sub metering"))
with(sub_power_cons,lines(Time,Sub_metering_2, col = "red"))
with(sub_power_cons,lines(Time,Sub_metering_3, col = "blue"))
title(main = "Energy sub-metering")
legend("topright", col = c("black", "red", "blue"), lty = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
