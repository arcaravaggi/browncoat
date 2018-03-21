# Function for calculation of Confidence Intervals with varying critical values 
# Includes option for Finite Population Correction
# dat = dataframe
# pop = estimated population size
# bs = estimated breeding success
# z = critical value (default 1.96 [95% CI])
# n = sample size (default = 1)
# p = population size
# f = Finite Population Correction (FPC)
cInt <- function(dat, loc, pop, bs, z = 1.96, n = 1, p, fpc =  "TRUE"){
  vec <- length(dat[,1])
  for(i in 1:nrow(dat)){
    n <- n
    p <- pop
    s <- bs
    f <- (p-n)/(p-1)
      if(fpc == "TRUE"){ 
        ci.fpc <- (z*(s/sqrt(n)))*sqrt(f)
        vec <- ci.fpc
      }  else {
        ci.std <- z*(s/sqrt(n))
        vec <- ci.std
      }
  }
  print(vec)
}


#Create dummy data

species <- c('Chaffinch', 'Robin', 'Blackbird', 'Wren')
pop <- c(2000, 1700, 560, 780) # estimated population size
bs <- c(0.61, 0.53, 0.42, 0.67) # estimated breeding success
sd <- c(0.18, 0.07, 0.13, 0.09) # standard deviation of breeding success
count <- c(5, 11, 21, 8) # number of replicates

cDAT <- data.frame(species, pop, bs, sd, count, stringsAsFactors=FALSE)

# 95% CI

output <- cInt(dat = cDAT, 
               pop = cDAT$pop,
               bs = cDAT$bs,
               n = cDAT$count,
               z = 1.96, fpc = "TRUE")

cDAT["ci"]   <- output

# 70% CI

cInt(dat = cDAT, pop = 5000, bs = 0.25, n = 8, z = 1.03)
