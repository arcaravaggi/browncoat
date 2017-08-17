setwd("C:/Users/Anthony Caravaggi/Dropbox/Academic/SHINE project/Data/Weather stations")

# Read in all csv files in directory
files <- list.files(pattern = "*.csv")
allstations <- read.table(file = "allstations.txt", header = TRUE, 	sep="\t")

# Read csvs to list
stations <- sapply(files, read.csv)

# Specify columns to retain in build.lst
keeps <- c("date", "rain", "maxtp", "mintp", "soil", "cbl")

# Order of dataframe columns for arrange.vars in build.lst
df.order <- c("date" = 1, "rain" = 2, "maxtp" = 3, "mintp" = 4 , "soil" = 5, "cbl" = 6)

# Rebuild list function
# Re-order and drop columns to ensure consistency then add a column with the df name for ID purposes
#
# my_list  = list name
# col.order = vector of ordered column names
# retain = vector of column names to be retained
build.lst <- function (my_list, col.order, retain){
  # Place columns to be retained at the start of the df (load arrange.vars function, below)
  lapply(my_list, function(x) {
    x <- arrange.vars(x, col.order)
    x})
  # Drop non-essential columns from all dataframes in list; run drop over list, keeping required columns
  my_list <- lapply(my_list, function(x) {
    x <- x[ , retain, drop = FALSE]
    x
  })
  # Add column to list containing df name
  my_list <- Map(cbind, my_list, id = names(my_list))
  my_list
}

stations <- build.lst(stations, df.order, keeps)

# Bind to singular dataframe
sDAT <- do.call("rbind", stations)

# Merge with allstations and rearrange
sDAT <- (merge(allstations, sDAT, by = 'id'))
sDAT <- arrange.vars(sDAT2, df.order)

# Vector to replace month characters with numeric in date.format
m.rep <- c(jan=1,feb=2,mar=3,apr=4,may=5,jun=6,jul=7,aug=8,sep=9,oct=10,nov=11,dec=12)

# Split a charactre & number d-m-y date column (e.g. 01-JAN-80) into columns
# for day, month, and year, and recombine into valid date column
# 
# df = dataframe
# d.col = dataframe date column
# m.vec = vector to replace month characters with numeric
date.format <- function (df, d.col, m.vec){
  df$d <- substr(d.col, 1, 2)
  df$m <- substr(d.col, 4, 6)
  df$y <- substr(d.col, 8, 10)
  # Convert character month to numeric
  numMonth <- function(x) 
    m.vec[tolower(x)]
  df$m <- numMonth(df$m)
  df$date.num <- as.Date(with(df, paste(d, m, y,sep="/")), "%d/%m/%y")
  df <- as.data.frame(df)
}

sDAT2 <- date.format(sDAT, sDAT$date, m.rep)





##################### FUNCTIONS ########################

arrange.vars <- function(data, vars){
  ##stop if not a data.frame (but should work for matrices as well)
  stopifnot(is.data.frame(data))
  
  ##sort out inputs
  data.nms <- names(data)
  var.nr <- length(data.nms)
  var.nms <- names(vars)
  var.pos <- vars
  ##sanity checks
  stopifnot( !any(duplicated(var.nms)), 
             !any(duplicated(var.pos)) )
  stopifnot( is.character(var.nms), 
             is.numeric(var.pos) )
  stopifnot( all(var.nms %in% data.nms) )
  stopifnot( all(var.pos > 0), 
             all(var.pos <= var.nr) )
  
  ##prepare output
  out.vec <- character(var.nr)
  out.vec[var.pos] <- var.nms
  out.vec[-var.pos] <- data.nms[ !(data.nms %in% var.nms) ]
  stopifnot( length(out.vec)==var.nr )
  
  ##re-arrange vars by position
  data <- data[ , out.vec]
  return(data)
}

