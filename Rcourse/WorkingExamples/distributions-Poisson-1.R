## Title: distributions-Poisson-1.R
## Author: Paul Johnson <pauljohn at ku.edu>
## Date posted: 2013-02-08
## Draw some random variables from a Poisson
## distribution.


## R's rpois function requres 2 arguments, the
## number of observations and the value of the parameter
## lambda, which is the expected value of Poisson variable.
## It is also the variance of that variable, which is a
## distinguishing feature of the Poisson random variable.

## Look it over


x <- rpois(12, lambda = 1)
x
hist(x, prob = TRUE, main = "12 Draws from Poisson(lambda=1)")

x <- rpois(312, lambda = 222)
hist(x, prob = TRUE, main = "312 Draws from Poisson(lambda=222)")

#Now make 10 pictures of Poisson for various mean values

## Ask for a full sheet of paper to write on:
dev.new( width = 8.5, height = 11)

par(mfcol=(c(5,2)))

for(i in 1:10){
  y <-  rpois(1250, lambda = 2 + 10*i)
  hist(y , breaks=10, xlim=c(0, 150),main=paste("Histogram of Poisson(lambda=", 10*i,") "))
}

#Do again for bigger values
for(i in 11:20){
  y <- rpois(1250, lambda = 2 + 10*i)
  hist(y, breaks=10, xlim=c(0, 300),main=paste("Histogram of Poisson(lambda=", 10*i,") "))
}



