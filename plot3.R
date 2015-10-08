# load librarie
library(dplyr)

# set locale to English to get weekdays in English
Sys.setlocale("LC_TIME", "English")

url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
dest_filename <- './courseproject1/dataset.zip'


# store data in 'courseproject1' directory. If 'courseproject' directory does not exist in current working directory, then create it.

if (!file.exists("./courseproject1")) 
{
    dir.create("./courseproject1")
}

# download file if it's not already there

if (!file.exists(dest_filename)) 
{
    download.file(url, dest_filename)
}

# unzip the file if it's not done already
if(!file.exists("./courseproject1/exdata-data-household_power_consumption"))
{
    unzip (dest_filename, exdir = "./courseproject1")    
}


# read data
df <- read.table('./courseproject1/household_power_consumption.txt',sep=';',na.strings = '?', header = TRUE)

# convert column Date to datatype Date
df$Date=as.Date(df$Date,format="%d/%m/%Y")

# take only data from 01.02.2007 to 02.02.2007
df <- filter(df, Date==as.Date('2007-02-01')|Date==as.Date('2007-02-02'))

# merge date & time into new variable
df$timestamp <- as.POSIXct(paste(df$Date, df$Time))

# save plot as .png file
png("plot3.png", width=480, height=480)

plot(df$timestamp, df$Sub_metering_1, type="l", ylab= "Energy sub metering", xlab="")
lines(df$timestamp, df$Sub_metering_2, type="l", col="red")
lines(df$timestamp, df$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))
dev.off()
