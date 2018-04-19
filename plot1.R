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

# Plot 1
png(filename = "plot1.png")
hist(subsetdata$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     col = "red"
)
dev.off()