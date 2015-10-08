# load libraries
library(dplyr)

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

# save plot as .png file
png("plot1.png", width=480, height=480)
hist(df$Global_active_power,col='red',xlab='Global Active Power (kilowatts)',main='Global Active Power')
dev.off();
