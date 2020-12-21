## gamma-3.R
## PJ Feb 14, 2002 / 2014-08-07
## This is a template showing how to explore the impact
## of changes in the gamma parameters, scale and shape

## Run this a few times, changing the value of sc at
## the top

sc <- 1
sampleSize <- 500

op <- par(no.readonly = TRUE)

SAVEME <- FALSE

if (SAVEME) pdf(file = "distributions-gamma-03-1.pdf", width = 8.5,
                height = 10, onefile = FALSE, family = "Times", paper = "special")


par(mfrow = c(5,2))


createDist <-function(i){
  sh <- 0.5 + 0.5*(i-1)
  z <- rgamma(sampleSize,shape=sh,scale=sc)
  title <- paste("Histogram gamma shape=",sh," scale=",sc)
  hist(z,breaks=10,main=title)
}

lapply(1:10,createDist)

if (SAVEME) dev.off()
par(op)  ## resets par
