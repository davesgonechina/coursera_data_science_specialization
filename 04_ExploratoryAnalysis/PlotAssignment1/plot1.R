plot1 <- function() {
  if(!file.exists("household_power_consumption.txt")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip","household_power_consumption.zip", method = "wget")
    unzip("household_power_consumption.zip", overwrite = TRUE)
  }
  hpc <- read.table("household_power_consumption.txt", sep=";", header=TRUE)
  plot1  <- hpc[grep("^[1-2]/2/2007", hpc$Date),]
  plot1$Global_active_power <- as.numeric(as.character(plot1$Global_active_power))
  png("plot1.png", width = 480, height = 480, units = "px", bg = "white")
  hist(plot1$Global_active_power, col = "red", xlab="Global Active Power (kilowatts)", main = "Global Active Power")
  dev.off()
}