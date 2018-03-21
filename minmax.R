# Function to calculate minimum and maximum variance based on n bootstrapping 
# iterations (tnorm), with truncation
# dat = dataframe
# n = number of randomly generate integers
# m = mean breeding success rate (proportional)
# s = SD/SE/CI
# l = lower bounds of truncation (default = -100)
# u = upper bounds of truncation (default = 100)
# r = round to x digits
# fn = variance output ("min.e" or "max.e")
minmax <- function(dat, n = 1000, m, s, l = -100, u = 100, r = 5, fn){
  vec <- length(dat[,1])
  tnorm <- function(n, m, s, l, u, r) {   
    tdist <- round(rnorm(n, m, s), r)
    tdist[tdist < l] <- l
    tdist[tdist > u] <- u
    tdist
  }
  for (i in seq_along(dat[,1])) {
    mn <- m[i]
    sd <- s[i]
    if (fn == "min.e"){
      vec[i] <- min(tnorm(n, mn, sd, l, u, r))
    }
    else if (fn == "max.e"){
      vec[i] <- max(tnorm(n, mn, sd, l, u, r))
    }
  }
  return(vec)
}

#Create dummy data

species <- c('Chaffinch', 'Robin', 'Blackbird', 'Wren')
pop <- c(2000, 1700, 560, 780) # estimated population size
bs <- c(0.61, 0.53, 0.42, 0.67) # estimated breeding success
sd <- c(0.18, 0.07, 0.13, 0.09) # standard deviation of breeding success
count <- c(5, 11, 21, 8) # number of replicates

cDAT <- data.frame(species, pop, bs, sd, count, stringsAsFactors=FALSE)


cDAT["min_err"] <- minmax(dat = cDAT, m = cDAT$bs, s = cDAT$sd, l=0, fn="min.e")
cDAT["max_err"] <- minmax(dat = cDAT, m = cDAT$bs, s = cDAT$sd, u = 1, fn="max.e")
