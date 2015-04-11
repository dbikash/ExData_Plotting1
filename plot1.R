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

# Step3: Plot histogram of Global Active Power to png file
png(filename="plot1.png", width=480, height=480)
hist(my_dt$Global_active_power, main = "Global Active Power",
     col = "orangered",
     xlab = "Global Active Power (kilowatts)",
     ylim = c(0,1200))
dev.off()