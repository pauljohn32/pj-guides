## poisson-2.r
## Date: 2013-02-11
## Author: Paul E Johnson <pauljohn at ku.edu>
## Description: Create a Poisson samples and show observed
##   distributions on one page.
##   TODO: Insert true probabilities in plots

## Try this program a few times. Vary the "sampleSize"
## and "ell" to observe any changes.

ell <- 1
sampleSize <- 400

## Suppose you want to generate 8 distributions
## and display them in a single picture

par(mfrow=c(4,2), mar = c(2.1,1,3.1,1))


createDist <-function(i){
    z <- rpois(sampleSize,lambda=ell)
    title <- paste("Poisson(lambda = ",ell,"), sample size=", sampleSize, sep = "")
    t1 <- table(z)/sampleSize

    plot(t1, type = "h", xlab = "", main = title)
    points(unique(as.numeric(names(t1))), as.vector(t1))
}

lapply(1:8,createDist)
