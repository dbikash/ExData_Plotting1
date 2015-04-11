library("data.table")

# Step 1: Read zipped file directly as data frame and then convert to data table
# Note: fread() does not seem to work with zipped files
df <- read.table(
  unz("exdata_data_household_power_consumption.zip", "household_power_consumption.txt"), 
  header=TRUE,
  sep=";",
  na.strings="?",
  colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
)
dt <- data.table(df)

# Step 2: Convert date from character to Date format and subset required data.
# Unload unnecessary data to free up memory
dt$Date <- as.Date(dt$Date, format="%d/%m/%Y")
my_dt <- dt[Date=="2007-02-01" | Date=="2007-02-02"]
rm(df)
rm(dt)

# Step 3: Add a new column "DateTime" from Date and Time fields in POSIXct format
my_dt$DateTime <- as.POSIXct(paste(my_dt$Date, my_dt$Time),
                             format="%Y-%m-%d %H:%M:%S")

# Step 4: Plot Global Active Power vs DateTime
png(filename="plot2.png", width=480, height=480)
with(my_dt, plot(DateTime, Global_active_power,type="l",
                 ylab = "Global Active Power (kilowatts)"))
dev.off()