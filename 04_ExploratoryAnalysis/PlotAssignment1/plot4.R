plot4 <- function() {
  Sys.setlocale("LC_TIME", "en_US.UTF-8")
  if(!file.exists("household_power_consumption.txt")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip","household_power_consumption.zip", method = "wget")
    unzip("household_power_consumption.zip", overwrite = TRUE)
  }
  hpc <- read.table("household_power_consumption.txt", sep=";", header=TRUE)
  plot4  <- hpc[grep("^[1-2]/2/2007", hpc$Date),]
  plot4$Global_active_power <- as.numeric(as.character(plot4$Global_active_power))
  plot4$Global_reactive_power <- as.numeric(as.character(plot4$Global_reactive_power))
  plot4$Voltage <- as.numeric(as.character(plot4$Voltage))
  plot4$Sub_metering_1 <- as.numeric(as.character(plot4$Sub_metering_1))
  plot4$Sub_metering_2 <- as.numeric(as.character(plot4$Sub_metering_2))
  plot4$Sub_metering_3 <- as.numeric(as.character(plot4$Sub_metering_3))
  plot4$Datetime <- strptime(paste(plot4$Date, plot4$Time), "%d/%m/%Y %H:%M:%S")
  png("plot4.png", width = 480, height = 480, units = "px", bg = "white")
  par(mfrow = c(2, 2))
  plot(plot4$Datetime, plot4$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
  plot(plot4$Datetime, plot4$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
  plot(plot4$Datetime, plot4$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  points(plot4$Datetime, plot4$Sub_metering_2, type = "l", xlab = "", ylab = "Energy sub metering", col = "red")
  points(plot4$Datetime, plot4$Sub_metering_3, type = "l", xlab = "", ylab = "Energy sub metering", col = "blue")
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(plot4$Datetime, plot4$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
  dev.off()
}