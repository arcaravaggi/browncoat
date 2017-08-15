# Import multiple csv files from subdirectories
# See https://github.com/arcaravaggi/UMAC_2017 for utilisation

# Function to specify focal directory and run R scripts in subdirectories
# Directory structure for the example:
# WD/month[i]/survey[i]
# month = month
imp.dat <- function(month){
  if(month == "jan"){
    folder.dir <- list.dirs("../01 January")
  } else if(month == "feb"){
    folder.dir <- list.dirs("../02 February")
  } else if(month =="mar"){
    folder.dir <- list.dirs("../03 March")
  } else if(month =="apr"){
    folder.dir <- list.dirs("../04 April")
  } else if(month =="may"){
    folder.dir <- list.dirs("../05 May")
  } else if(month =="jun"){
    folder.dir <- list.dirs("../06 June")
  }
  folder.dir <- folder.dir[-1]  # comment this out if the main folder also contains the script
  script.paths <- paste(folder.dir,"/","process.R", sep="")
  for (i in script.paths) {
    source(i)
  }
}

# remove rows with blank cells and NAs in a specified column (called in subscripts)
completeFun <- function(data, desiredCols) {
  data[data==""]<-NA
  completeVec <- complete.cases(data[, desiredCols])
  return(data[completeVec, ])
}

# Function to read in each .csv file in file_list and rbind them into a data frame 
# Includes insertion of additional columns (team, loc, month) for subsequent groupe analyses
# called in scripts located in subdirectories
# fol = path to folder that holds multiple .csv files
# col = column used to limit row removal (based on NAs)
# m = month
imp.csv <- function (fol, col, m){
  folder <- fol
  month <- m
  file_list <- list.files(path=folder, pattern="*.csv")
  temp.df <- do.call("rbind", 
                     lapply(file_list, function(x) 
                     {
                       tmp <- read.csv(paste(folder, x, sep=''))
                       tmp$team <- substr(x, 6, 8)
                       tmp$loc <- substr(x, 10, 13)
                       tmp$month <- month
                       return(tmp) 
                     }))
  completeFun(temp.df, col)
}


##### Script to be saved in each subdirectory######
# m = month
# col = consistent column for concatenation
#
dat1 <- imp.csv(fol = "./01 January/Camera_traps/", m = "jan", col = 7)
#
#
###################################################



# Import data which is automatically cleaned (see completeFun function)
# As individual months (see imp.dat function)

imp.dat(month = "may")

# Or all months

mth <- c("jan", "feb", "mar", "apr", "may", "jun")

for(i in seq_along(mth)){
  imp.dat(month = mth[i])
}