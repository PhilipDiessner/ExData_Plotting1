# get data if not downloaded yet
hospdata <- "household_power_consumption.txt"
dataexists <- FALSE
if (!file.exists(hospdata)){
    webpath <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(webpath,"dataset.zip",mode="wb")
    unzip("dataset.zip")
}

# load and tidy as recommended
alldata <- na.omit(
            read.csv2(hospdata,na.strings = "?",
                stringsAsFactors = FALSE
                   )
                )
alldata <- subset(alldata,Date=="1/2/2007" | Date=="2/2/2007")
# plot as needed
png(filename = "plot1.png",width = 480, height = 480)
hist(as.numeric(alldata$Global_active_power),main="Global Active Power",
    col="red",xlim=c(0,6),ylim=c(0,1200),xlab="Global Active Power (kilowatts)")
dev.off()
