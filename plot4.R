## download zip file into temp file then unzip just required rows into data frame
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), sep=";",skip=66637,nrows=2880)
unlink(temp)

## skipping means lose column headings so add them back
names(data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

## create png graphics device of required size
png(file="plot4.png",units="px",width=480,height=480)

## convert data and time variables
data$Time <- strptime(paste(data$Date,data$Time,sep=" "),"%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date,"%d/%m/%Y")

## set up 2x2 layout
par(mfrow=c(2,2))

## plot graphs
## top left
plot(data$Time,data$Global_active_power,type="l",xlab="",ylab="Global Active Power")
## top right
plot(data$Time,data$Voltage,type="l",xlab="datetime",ylab="Voltage")
## bottom left
plot(data$Time,data$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(data$Time,data$Sub_metering_2,type="l",col="red")
lines(data$Time,data$Sub_metering_3,type="l",col="blue")
legend("topright",lty=c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
## bottom right
plot(data$Time,data$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")

## close grahics device to save file
dev.off()
