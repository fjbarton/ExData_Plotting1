## download zip file into temp file then unzip just required rows into data frame
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), sep=";",skip=66637,nrows=2880)
unlink(temp)

## skipping means lose column headings so add them back
names(data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

## create png graphics device of required size
png(file="plot1.png",units="px",width=480,height=480)

## plot graph 1
hist(data$Global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts)",col="red")

## close grahics device to save file
dev.off()
