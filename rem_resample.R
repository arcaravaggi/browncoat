# Resample camera trap zone of detection metrics (r & theta) and calculate
# 95% confidence intervals. For use in Random Encounter Modelling where
# zone of detection is based on individual captures rather than calculated a priori.

r <- runif(1000, 0, 0.00016)
theta <- runif(1000, 0, 1.4)

qDAT <- data.frame(r, theta)

#Randomly resample with replacement x number of times with a sample size of y
bDAT<-t(replicate(20,qDAT[sample(1:nrow(qDAT), 45, replace=F),],simplify=T))

#calculate means of each replicate
# mDAT <- sapply(bDAT,function(x) apply(x, 2, mean)) # Code depreciated

r <- as.numeric(lapply(bDAT[1:20], mean))
theta <- as.numeric(lapply(bDAT[21:40], mean))

mDAT <- data.frame(r,theta)

#calculate 95% CI
mDAT.ci <- matrix(NA, nrow = dim(mDAT)[2], ncol = 2)
for (i in 1:dim(mDAT)[2]) {
  temp <- t.test(mDAT[, i], conf.level = 0.95)
  mDAT.ci[i, ] <- temp$conf.int
}

colnames(mDAT.ci) <- c("lcl", "ucl")

colMeans(mDAT)
mDAT.ci
