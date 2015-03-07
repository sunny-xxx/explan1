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

png(filename = "plot2.png", width = 480, height = 480)
plot(data$datetime, data$Global_active_power,
        type = "l",
        ylab = "Global Active Power (kilowatts)",
        xlab = NA)
dev.off()