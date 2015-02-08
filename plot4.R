# this script will create plot1 (histogram)
# require dplyr packate in order to use mutate to add a new variable with the date
require(dplyr)
energyfile <- paste(getwd(), "household_power_consumption.txt", sep="/")

# load the data (only 2/1/2007)
# the file contain one record per minute, we will load 2880 records (2*24*20)
energy <- read.table (energyfile, sep=";", skip=grep("1/2/2007", readLines(energyfile)), nrows= 2880 - 1)

# set the column names
names(energy) <- c("date", "time", "global_active_power", "global_reactive_power", "voltage", "global_intensity", "sub_metering_1", "sub_metering_2", "sub_metering_3")

# add a variable with the date value in "asdate" field
energy_datetime <- mutate(energy, datetime = as.POSIXct(paste(energy$date, energy$time), format="%d/%m/%Y %H:%M:%S"))


# Plot 4
png("plot4.png")

# create the matrix of 2,2
par(mfrow = c(2,2))

# plot left top
plot(energy_datetime$datetime, energy_date$global_active_power, 
     type = "l", 
     ylab = "Global Active Power (kilowatts)" )

# plot right top
plot(energy_datetime$datetime, energy_date$voltage, 
     type = "l", 
     ylab = "Voltage", 
     xlab = "datetime")

# plot left bottom
plot(energy_datetime$datetime, energy_datetime$sub_metering_1, 
     type = 'n', 
     ylab="Energy sub metering",
     xlab = "")
lines(energy_datetime$datetime, energy_datetime$sub_metering_1, col = "black")
lines(energy_datetime$datetime, energy_datetime$sub_metering_2, col = "red")
lines(energy_datetime$datetime, energy_datetime$sub_metering_3, col = "blue")
legend("topright", c("sub_metering_1","sub_metering_2","sub_metering_3"), lty=c(1,1,1), col=c("black", "red", "blue") )

# plot right bottom
plot(energy_datetime$datetime, energy_date$global_reactive_power, 
     type = "l", 
     ylab = "Global reactive_power", 
     xlab = "datetime")

dev.off()
