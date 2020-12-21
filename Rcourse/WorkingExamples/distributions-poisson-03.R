## poisson-3.R
## Date: 2013-02-11
## Author: Paul E. Johnson <pauljohn@ku.edu>
## Description: Explore the Poisson with various values
##   of the lambda parameter.

## Run this a few times, changing the value of sample
## size or values in the vector ell


sampleSize <- 500

par(mfrow=c(4,2), mar = c(2.1,1,3.1,1))

## I'm assigning some interesting values to use for
## the lambda coefficient
ell <- c(0.5, 1.0, 1.5, 2, 5, 10, 20, 50)

createDist <-function(i){
  z <- rpois(sampleSize, lambda=ell[i])
  title <- paste("Histogram Poisson lambda=", ell[i],", N=", sampleSize)
  t1 <- table(z)/sampleSize

  plot(t1, type = "h", xlab = "", main = title)
  points(unique(as.numeric(names(t1))), as.vector(t1))
}

lapply(1:8, createDist)
