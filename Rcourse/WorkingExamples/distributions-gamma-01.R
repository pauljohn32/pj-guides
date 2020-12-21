## gamma-1.R
## PJ Feb 14, 2002 / 2014-08-07
## Create a
## gamma variable and then show its histogram.

sh <- 1
sc <- 5

z <- rgamma(1000, shape=sh, scale=sc)
hist(z)

## Lets play around with the title
hist(z, main = "My stinking Gamma (1,5) Histogram")
## use variables in a title:
hist(z, main = paste("My stinking Gamma(",sh,",",sc,") Histogram."))
