## gamma-4.R 
## PJ Feb 16, 2002 / 2014-08-07
## This is a template showing how to see the central
## limit theorem as it applies to a gamma distribution

## You should alread have run template_gamma1 and 2.
## So you know the shape parameter is important.


## Run this a few times, changing the value of sh at
## the top. What do you see?

## Reminder: the mean of a gamma distribution is
## shape*scale.

##------------------------------------------##
## ---------RUN THIS PART FIRST ------------##
sh <- 0.2
sc <- 1
sampleSize <- 500
nOfRuns <- 2000

op <- par(no.readonly = TRUE)

SAVEME <- FALSE


getGammaMeans <- function (x){
  e <- rgamma(sampleSize, shape = sh, scale = sc)
  mean(e)
}

samplingDist <- sapply(1:nOfRuns, getGammaMeans)


if (SAVEME) pdf(file = "distributions-gamma-04-1.pdf", width = 8.5,
                height = 10, onefile = FALSE, family = "Times", paper = "special")


mytitle <- paste("The Sampling Distribution of a Gamma(sh=",sh,",sc=",sc,")")
hist(samplingDist, breaks=10, main = mytitle)

if (SAVEME) dev.off()

##------------------------------------------------##
# ---------- SECOND PART STARTS HERE -------------- #

# If you did not run that first part yet, go back.
# Then run this really fun part!

if (SAVEME) pdf(file = "distributions-gamma-04-2.pdf", width = 8.5,
                height = 10, onefile = FALSE, family = "Times", paper = "special")

## I've done it. It works.
par(mfrow = c(2,1))

oneGamma <- rgamma(sampleSize, shape = sh, scale = sc)

oneHist <- hist(oneGamma,
                main = paste("here is one sample from your Gamma(sh=",sh,",sc=",sc,")"))

text(.6*max(oneGamma), .8*max(oneHist$counts),
     paste("E(x)=", sc*sh, "\nobserved mean=",
           round(mean(oneGamma),3)), pos = 2)

mytitle <- paste("The Sampling Distribution of the Mean of Gamma(sh=",sh,",sc=",sc,")")
samplinghist <- hist(samplingDist,breaks=10,main=mytitle)

text(max(samplingDist), 0.8*max(samplinghist$counts),
     paste("The mean is", round(mean(samplingDist),3), "\nstd dev is ",
           round(sd(samplingDist),3)), pos=2)
if (SAVEME) dev.off()
