

# IMPORTANT:
#------------------------------------------------------
# THE  RESULTING PLOTS ARE IN THE FIGURE FOLDER OF THE GITHUB REPO
#------------------------------------------------------


# Read the data from the text file, na.Strings is used to specify missing value character
raw_data <- read.csv(file = "household_power_consumption.txt", header=TRUE, sep=";",colClasses=c("character", "character", rep("numeric", 7)), na.strings="?")

# Convert first and second column to date and subset data from 2007-02-01 to 2007-02-02
dates <- as.POSIXlt(paste(raw_data$Date, raw_data$Time), format="%d/%m/%Y %H:%M:%S")
start_date <- as.POSIXlt.character("2007-02-01 00:00:00", format="%Y-%m-%d %H:%M:%S")
end_date <- as.POSIXlt.character("2007-02-02 23:59:59", format="%Y-%m-%d %H:%M:%S")
ind <- dates >= start_date & dates <= end_date
energy <- cbind(dates[ind], raw_data[ind,3:9], row.names=NULL)

# delete original data to save memory space
rm(raw_data)

# Start PNG graphics device according to assigment requirements
png(filename="plot3.png", width=480, height=480)

# Plot the plot
plot(energy[,6], col="black", ylab="Energy sub metering", xaxt="n", type="l", xlab="")
lines(energy[,7], col="red")
lines(energy[,8], col="blue")
axis(1, at=c(1,1441, 2881), labels=c("Thu", "Fri", "Sat"))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=rep("solid",3))

# Turn-off the PNG graphics device
dev.off()