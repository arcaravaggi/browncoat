# Calculate sunrise and sunset for a given location at a given time of year
#
# lat = latitude in decimal degrees
# lon = longitude in decimal degrees
# date = target date; format yyyy-mm-dd
# timezone = target time zone (default = UTC)
# days = provide sunrise/set for x days, where date is the first day (default = 1)
#
# Example
# sun.rs(51.672667, -3.519628, "2017-04-25", days = 10)

library(maptools) 
library(stringr)

sun.rs <- function(lat, lon, date, timezone="UTC", days=1){ 
  #Don't switch lon & lat in the matrix, even though they're the other way around
  loc <- matrix(c(lat, lon), nrow=1) 
  day <- as.POSIXct(date, tz=timezone) 
  sequence <- seq(from=day, length.out=days , by="days") 
  rise <- sunriset(loc, sequence, direction="sunrise", POSIXct=TRUE) 
  set <- sunriset(loc, sequence, direction="sunset", POSIXct=TRUE) 
  sun <- data.frame(rise, set) 
  sun <- sun[,-c(1,3)] 
  sr <- str_split_fixed(rise$time, " ", 2)
  ss <- str_split_fixed(set$time, " ", 2)
  sun <- data.frame(sr, ss)
  colnames(sun)<-c("sunrise.date", "sunrise.time", "sunset.date", "sunset.time") 
  return(sun) 
} 