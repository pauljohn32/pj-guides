## gamma-2.R
## PJ Feb 14, 2002 / 2014-08-07
## This is a template showing how to create a
## variable 10 different samples and show 10
## histograms on one page.

## Try this program a few times. Vary the "sampleSize"
## to observe any changes.

sh <- 1
sc <- 5
sampleSize <- 40

##  Suppose you want to generate 10 distributions
##  and display them in a single picture

## Keep a copy of the old par settings
op <- par(no.readonly = TRUE)

SAVEME <- FALSE
if (SAVEME) pdf(file = "distributions-gamma-02-1.pdf", width = 8.5,
                height = 10, onefile = FALSE, family = "Times", paper = "special")

par(mfrow=c(5,2))
createDist <-function(i){
  z <- rgamma(sampleSize, shape=sh, scale=sc)
  hist(z, breaks=10)
}

lapply(1:10,createDist)

if (SAVEME) dev.off()
par(op)
