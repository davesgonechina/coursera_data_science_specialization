plot3 <- function() {
  Sys.setlocale("LC_TIME", "en_US.UTF-8")
  if(!file.exists("household_power_consumption.txt")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip","household_power_consumption.zip", method = "wget")
    unzip("household_power_consumption.zip", overwrite = TRUE)
  }
  hpc <- read.table("household_power_consumption.txt", sep=";", header=TRUE)
  plot3  <- hpc[grep("^[1-2]/2/2007", hpc$Date),]
  plot3$Sub_metering_1 <- as.numeric(as.character(plot3$Sub_metering_1))
  plot3$Sub_metering_2 <- as.numeric(as.character(plot3$Sub_metering_2))
  plot3$Sub_metering_3 <- as.numeric(as.character(plot3$Sub_metering_3))
  plot3$Datetime <- strptime(paste(plot3$Date, plot3$Time), "%d/%m/%Y %H:%M:%S")
  png("plot3.png", width = 480, height = 480, units = "px", bg = "white")
  plot(plot3$Datetime, plot3$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  points(plot3$Datetime, plot3$Sub_metering_2, type = "l", xlab = "", ylab = "Energy sub metering", col = "red")
  points(plot3$Datetime, plot3$Sub_metering_3, type = "l", xlab = "", ylab = "Energy sub metering", col = "blue")
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  dev.off()
}