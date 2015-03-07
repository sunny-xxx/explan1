library(dplyr)
Sys.setlocale("LC_TIME", "English")

data <- read.table("household_power_consumption.txt",
                   header = T,
                   stringsAsFactors =  F,
                   sep = ";",
                   na.strings = "?")

data <- data %>%
        filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
        mutate(datetime = paste(Date, Time)) %>%
        select(c(datetime, Global_active_power:Sub_metering_3))

data$datetime <- strptime(data$datetime, "%d/%m/%Y %H:%M:%S")

png(filename = "plot3.png", width = 480, height = 480)
plot(data$datetime, data$Sub_metering_1, type = "l", xlab = NA, ylab = "Energy sub metering")
lines(data$datetime, data$Sub_metering_2, type = "l", col = "red")
lines(data$datetime, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1,
       lwd = 2,
       col = c("black", "red", "blue"))
dev.off()