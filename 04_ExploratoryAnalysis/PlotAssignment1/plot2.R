plot2 <- function() {
  Sys.setlocale("LC_TIME", "en_US.UTF-8")
  if(!file.exists("household_power_consumption.txt")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip","household_power_consumption.zip", method = "wget")
    unzip("household_power_consumption.zip", overwrite = TRUE)
  }
  hpc <- read.table("household_power_consumption.txt", sep=";", header=TRUE)
  plot2  <- hpc[grep("^[1-2]/2/2007", hpc$Date),]
  plot2$Global_active_power <- as.numeric(as.character(plot2$Global_active_power))
  plot2$Datetime <- strptime(paste(plot2$Date, plot2$Time), "%d/%m/%Y %H:%M:%S")
  png("plot2.png", width = 480, height = 480, units = "px", bg = "white")
  plot(plot2$Datetime, plot2$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
  dev.off()
}