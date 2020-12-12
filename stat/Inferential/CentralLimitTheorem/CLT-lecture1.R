### R code from vignette source 'CLT-lecture1.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: p50
###################################################
unlink("figs", recursive=T)
dir.create("figs", showWarnings=F)


###################################################
### code chunk number 2: Roptions
###################################################
options(width=80, prompt="> ", continue="  ")
options(useFancyQuotes = FALSE)
set.seed(12345)
op <- par()
pjmar <- c(5.1, 4.1, 1.5, 2.1)
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=10)))
pdf.options(onefile=F,family="Times",pointsize=10)


###################################################
### code chunk number 3: simple20
###################################################
truemean <- 5.353
truesd <- 4.55
ymax <- 0.12
x <- seq(truemean-4*truesd, truemean+4*truesd, by=0.1)
denx <- dnorm(x, m=truemean, s=truesd)
plot(x, denx, type="l",xlim=c(truemean-4*truesd, truemean+4*truesd), ylim=c(0,ymax), ylab="Density")


###################################################
### code chunk number 4: simple10a
###################################################
set.seed(324234)

onexset <- rnorm(500, m=truemean, sd=truesd)
m1 <- round(mean(onexset),2)
sd1 <- round(sd(onexset),2)
hist(onexset, breaks=20, prob=T, xlim=c(truemean-4*truesd, truemean+4*truesd), ylim=c(0,ymax), main="",xlab="Observations from one sample")
legend("topleft", c(paste("Mean =", m1), paste("StdDev =", sd1)))


###################################################
### code chunk number 5: simple30
###################################################
plot(x, denx, type="l",xlim=c(truemean-4*truesd, truemean+4*truesd), ylim=c(0,ymax), ylab="Density")

onedensity <- density(onexset)
lines(onedensity, lty=2)
legend("topleft",legend=c("Theoretical (PDF)", "Observed Density"), lty=c(1,2))


###################################################
### code chunk number 6: simple40
###################################################
hist(onexset, breaks=20, prob=T, xlim=c(truemean-3*truesd, truemean+3*truesd), ylim=c(0,ymax),   main="",xlab="Observations from one sample")
lines(x, denx, lty=1)
lines(onedensity, lty=2)
legend("topleft", legend=c(paste("Exp. Value=",truemean), paste("Obs. Mean=",round(m1,2))))
legend("topright", legend=c(paste("Pop. Var.=",round(truesd*truesd,2)), paste("Obs. Var.=",round(sd1*sd1,2))))


###################################################
### code chunk number 7: simple10b
###################################################
onexset <- rnorm(500, m=truemean, sd=truesd)
m1 <- round( mean(onexset), 2)
sd1 <- round(sd(onexset),2)
hist(onexset, breaks=20, prob=T, xlim=c(truemean-4*truesd, truemean+4*truesd), ylim=c(0,ymax), main="",xlab="Observations from one sample")
legend("topleft", c(paste("Mean =", m1), paste("StdDev =", sd1)))


###################################################
### code chunk number 8: simple10c
###################################################
onexset <- rnorm(500, m=truemean, sd=truesd)
m1 <- round(mean(onexset), 2)
sd1 <- round(sd(onexset),2)
hist(onexset, breaks=20, prob=T, xlim=c(truemean-4*truesd, truemean+4*truesd), ylim=c(0,ymax), main="",xlab="Observations from one sample")
legend("topleft", c(paste("Mean =", m1), paste("StdDev =", sd1)))


###################################################
### code chunk number 9: p10
###################################################
x <- seq(-10, 10, length.out=500)
pm0sd3 <- dnorm(x, mean=0, sd=3)
pmean <- dnorm(x, mean=0, sd=3/sqrt(100))
pmean2 <- dnorm(x, mean=0, sd=3/sqrt(2000))


###################################################
### code chunk number 10: normal1
###################################################
plot(x, pm0sd3, type="l", ylab="density of x",xlab="x")


###################################################
### code chunk number 11: normal2
###################################################
plot(x, pmean, type="l", ylab="density of mean of x",xlab="mean of x")


###################################################
### code chunk number 12: normal3
###################################################
 plot(x, pmean2, type="l", ylab="density of mean of x",xlab="mean of x")


###################################################
### code chunk number 13: bin10
###################################################
N <- 50
xbinom <- rbinom(N, size = 1, prob = 0.3)
hist(xbinom, xlab="x is either 0 or 1", main = "30 Observations from a Binomial")
m1 <- round(mean(xbinom), 4)
legend("top", c(paste("Mean=",m1)))


###################################################
### code chunk number 14: bin10b
###################################################
N <- 50
xbinom <- rbinom(N, size = 1, prob = 0.3)
hist(xbinom, main = "", xlab="x is either 0 or 1")
m1 <- round(mean(xbinom), 4)
legend("top", c(paste("Mean=",m1)))


###################################################
### code chunk number 15: bin10c
###################################################
xbinom <- rbinom(N, size = 1, prob = 0.3)
hist(xbinom, main = "", xlab="x is either 0 or 1")
m1 <- round(mean(xbinom), 4)
legend("top", c(paste("Mean=",m1)))


###################################################
### code chunk number 16: bin10d
###################################################
xbinom <- rbinom(N, size = 1, prob = 0.3)
hist(xbinom, main = "", xlab="x is either 0 or 1")
m1 <- round(mean(xbinom), 4)
legend("top", c(paste("Mean=",m1)))


###################################################
### code chunk number 17: bin20a
###################################################
calcMean <- function(i) mean(rbinom(N, 1, 0.3))
means <- sapply(1:100, calcMean)
hist(means, xlab = "estimates of proportion of success")
m1 <- round(mean(means), 4)
legend("top", c(paste("Mean of means=", m1)))


###################################################
### code chunk number 18: bin20b
###################################################
N <- 2000
calcMean <- function(i) mean(rbinom(N, 1, 0.3))
means <- sapply(1:1000, calcMean)
hist(means, xlab = "estimates of proportion of success")
m1 <- round(mean(means), 4)
legend("top", c(paste("Mean of means=", m1)))


###################################################
### code chunk number 19: p30
###################################################
x <- seq(0,10)
xdpois <- dpois(x,lambda=3)
plot(x, xdpois, type="h", xlab="a Poisson variate with lambda=3",ylab="Probability")
points(x, xdpois)


###################################################
### code chunk number 20: pois10
###################################################
 hist(0.5+rpois(10, lambda=3),xlim=c(0.5,10.5), prob=T, xlab="x", main="Poisson Sample N=10")
 points(x+0.5, xdpois)


###################################################
### code chunk number 21: pois20
###################################################
 hist(0.5+rpois(100, lambda=3),xlim=c(0.5,10.5),prob=T, xlab="x", main="Poisson Sample N=100")
 points(x+0.5, xdpois, lty=4)


###################################################
### code chunk number 22: pois30
###################################################
hist(0.5+rpois(2000, lambda=3),xlim=c(0.5,10.5), prob=T, xlab="x", main="Poisson Sample N=2000")
 points(x+0.5, xdpois, lty=4)


###################################################
### code chunk number 23: pois40
###################################################
 hist(0.5+rpois(10000, lambda=3),xlim=c(0.5,10.5), prob=T, xlab="x", main="Poisson Sample N=10000")
 points(x+0.5, xdpois, lty=4)


###################################################
### code chunk number 24: pois81
###################################################
   m10 <- replicate(1000, mean(rpois(10, lambda=3)))
   hist(m10,xlim=c(0.5,10.5), prob=T, xlab="x", main="Means with N=10")


###################################################
### code chunk number 25: pois82
###################################################
m100 <- replicate(1000, mean(rpois(100, lambda=3)))
hist(m100,xlim=c(0.5,10.5),prob=T, xlab="x", main="Means with N=100")


###################################################
### code chunk number 26: pois83
###################################################
 m2000 <- replicate(1000, mean(rpois(2000, lambda=3)))

 hist(m2000,xlim=c(0.5,10.5), prob=T, xlab="x", main="Means with N=2000")



###################################################
### code chunk number 27: pois84
###################################################
m10000 <- replicate(1000, mean(rpois(10000, lambda=3)))
hist(m10000,xlim=c(0.5,10.5), prob=T, xlab="x", main="Means with N=10000")


###################################################
### code chunk number 28: pois85
###################################################
hist(m10000, prob=T, xlab="x", main="Means with N=10000")
lines(density(m10000),lty=2)
mp <- mean(m10000)
sdp <- sd(m10000)
xp <- seq(range(m10000)[1], range(m10000)[2], length=200)
npd <- dnorm(xp, m=mp, s=sdp)
lines(xp, npd, lty=1)
legend("topright",legend=c("Observed","Theoretical"), lty=c(2,1))


###################################################
### code chunk number 29: U10
###################################################
x <- seq(0,1, by=0.01)
xdunif <- dunif(x)
plot(x, xdunif, type="l", xlab="A Uniform Variate",ylab="Probability")
lines(c(0,0),c(0,1),lty=4)
lines(c(1,1),c(0,1),lty=4)


###################################################
### code chunk number 30: u21
###################################################
un1 <- replicate(1000, mean(runif(30)))
hist(un1, xlim=c(0,1), prob=T, xlab="x", main="Means with N=30")


###################################################
### code chunk number 31: u22
###################################################
un1 <- replicate(1000, mean(runif(500)))
hist(un1,xlim=c(0,1), prob=T, xlab="x", main="Means with N=500")


###################################################
### code chunk number 32: u23
###################################################
un1 <- replicate(100, mean(runif(2000)))
hist(un1,xlim=c(0.45,0.55), breaks=20, prob=T, xlab="x", main="Means with N=2000")
lines(density(un1),lty=2)
mp <- mean(un1)
sdp <- sd(un1)
xp <- seq(range(un1)[1], range(un1)[2], length=200)
npd <- dnorm(xp, m=mp, s=sdp)
lines(xp, npd, lty=1)
legend("topright",legend=c("Observed","Theoretical"), lty=c(2,1))


###################################################
### code chunk number 33: b10
###################################################
x <- seq(0.001,0.999, by=0.001)
xd <- dbeta(x, 0.9, 0.9)
plot(x, xd, type="l", xlab="A Beta Variate",ylab="Probability")
lines(c(0,0),c(0,xd[1]),lty=4)
lines(c(1,1),c(0,xd[1]),lty=4)


###################################################
### code chunk number 34: b23
###################################################
un1 <- replicate(100, mean(rbeta(2000, 0.9, 0.9)))
hist(un1,xlim=c(0.45,0.55), breaks=10, prob=T, xlab="x", main="")
lines(density(un1),lty=2)
mp <- mean(un1)
sdp <- sd(un1)
xp <- seq(range(un1)[1], range(un1)[2], length=200)
npd <- dnorm(xp, m=mp, s=sdp)
lines(xp, npd, lty=1)
legend("topright",legend=c("Observed","Theoretical"), lty=c(2,1))


