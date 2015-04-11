library("data.table")

# Step 1: Read zipped file directly as data frame and then convert to data table
df <- read.table(
  unz("exdata_data_household_power_consumption.zip", "household_power_consumption.txt"), 
  header=TRUE,
  sep=";",
  na.strings="?",
  colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
)
dt <- data.table(df)

# Step 2: Convert date from character to Date format and subset required data;
#         Add a new column "DateTime" from Date and Time fields in POSIXct format
#         Unload unnecessary data to free up memory 
dt$Date <- as.Date(dt$Date, format="%d/%m/%Y")
my_dt <- dt[Date=="2007-02-01" | Date=="2007-02-02"]
my_dt$DateTime <- as.POSIXct(paste(my_dt$Date, my_dt$Time),
                             format="%Y-%m-%d %H:%M:%S")
rm(df)
rm(dt)

#Step 3: Plot Energy sub meterings against DateTime
png(filename="plot3.png", width=480, height=480)
with(mydt2, plot(DateTime, Sub_metering_1,ylab = "Energy sub metering", type="n"))
with(mydt2, points(DateTime, Sub_metering_1, type="l"))
with(mydt2, points(DateTime, Sub_metering_2, type="l", col="red"))
with(mydt2, points(DateTime, Sub_metering_3, type="l", col="blue"))
legend("topright", pch="_", col=c("black","red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
