## Title: efficiency-avoidLoops.R
## Author: "hubie"
## Source: http://ubuntuforums.org/showthread.php?t=1282686
## Date: Oct 5, 2009
## Description: Speed differences demonstrated for ways of iterating
## across data frames

nr <- 1000000
dataset1 <- matrix(ncol=4,nrow=nr)
dataset2 <- matrix(ncol=4,nrow=nr)

t1_start <- Sys.time()
for (i in 1:nrow(dataset1)) {
   dataset1[i,1] <- i
   dataset1[i,2] <- (i-1) %% 10 + 1
   dataset1[i,3] <- rnorm(1)
   dataset1[i,4] <- 1 + 3*dataset1[i,2] + dataset1[i,3]
}
t1_stop <- Sys.time()
print(sprintf("The loop way took %6.2f seconds", t1_stop - t1_start))

t2_start <- Sys.time()
dataset2[,1] <- seq(1:nr)
dataset2[,2] <- rep(seq(1:10), nr/10)
dataset2[,3] <- rnorm(nr)
dataset2[,4] <- 1 + 3*dataset2[,2] + dataset2[,3]
t2_stop <- Sys.time()

print(sprintf("The better way took %6.2f seconds", t2_stop - t2_start))

t1 <- as.numeric(t1_stop - t1_start)
t2 <- as.numeric(t2_stop - t2_start)
print(sprintf("It took %6.2f times longer to do it with a loop!",t1/t2))

