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
# merging date and time to one new column
alldata<-within(alldata,{Fulldate <- strptime(paste(Date,Time),
                                              format="%d/%m/%Y %R")})
#plot
png(filename = "plot3.png")
with(alldata,plot(Fulldate,as.numeric(Sub_metering_1),type="l",main="",
                  col="black",xlab="",ylab="Energy sub metering"
))
with(alldata,lines(Fulldate,as.numeric(Sub_metering_2),col="red"))
with(alldata,lines(Fulldate,as.numeric(Sub_metering_3),col="blue"))
legend("topright",legend=colnames(alldata)[7:9],
       col=c("black","red","blue"),lty = 1)
dev.off()
