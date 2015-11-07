

# The line number of the first record with date 2007-2-1 was found outside 
# of R with the command:
#     grep -m1 -n -o -P ^1/2/2007 household_power_consumption.txt

first_line <- 66638

# The line number of the last record with date 2007-2-2 was obtained by finding
# the first record of 2007-2-3:
#     grep -m1 -n -o -P ^3/2/2007 household_power_consumption.txt
# and subtracting one.

last_line <- 69517

electricity <- read.table("../household_power_consumption.txt",
                          header = FALSE,
                          col.names = c("Date", "Time", "ActivePower",
                                        "ReactivePower", "Voltage", "Intensity",
                                        "Sub1", "Sub2", "Sub3"),
                          sep = ";",
                          dec = ".",
                          na.strings = "?",
                          colClasses = c("character", "character", "numeric", 
                                         "numeric", "numeric", "numeric", 
                                         "numeric", "numeric", "numeric"),
                          skip = first_line - 1,
                          nrows = last_line - first_line + 1)

# Convert the first two columns to date and time objects, respectively.
electricity$Date <- as.Date(electricity$Date, "%d/%m/%Y")
electricity$Time <- strptime(electricity$Date, "%T")

png("plot1.png", 480, 480)

hist(electricity$ActivePower, 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     col="red")

dev.off()