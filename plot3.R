library("dplyr")
library("lubridate")

# Reading data
data <- read.table("household_power_consumption.txt", header = T, sep = ";")
data$Date <- dmy(data$Date)
data$Datetime <- strptime(paste(data$Date, data$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")

# Subsetting data
lower_bound <- dmy("01/02/2007")
upper_bound <- dmy("02/02/2007")
subsetdata <- data[data$Date == lower_bound | data$Date == upper_bound,]

# Converting to numeric
for(i in c(3:9)){
        subsetdata[,i] <- as.numeric(as.character(subsetdata[,i]))
}

# Plot 3
png(filename = "plot3.png")
plot(subsetdata$Datetime,
     subsetdata$Sub_metering_1,
     type = "l",
     ylab = "Energy sub metering",
     xlab = ""
)
lines(subsetdata$Datetime,
      subsetdata$Sub_metering_2,
      col = "red")
lines(subsetdata$Datetime,
      subsetdata$Sub_metering_3,
      col = "blue")
legend(x = "topright",
       lwd = c(1,1,1),
       col = c("black", "red", "blue"),
       legend = colnames(subsetdata[,7:9]))
dev.off()