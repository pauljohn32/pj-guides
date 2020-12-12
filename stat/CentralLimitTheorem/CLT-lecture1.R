###################################################
### chunk number 1: p50
###################################################
#line 83 "/home/pauljohn/ps/SVN-repo/stat/CentralLimitTheorem/CLT-lecture1.Rnw"
unlink("figs", recursive=T)
dir.create("figs", showWarnings=F)


###################################################
### chunk number 2: Roptions
###################################################
#line 95 "/home/pauljohn/ps/SVN-repo/stat/CentralLimitTheorem/CLT-lecture1.Rnw"
options(width=80, prompt="  ", continue="  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par() 
pjmar <- c(5.1, 4.1, 1.5, 2.1) 
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=10)))
pdf.options(onefile=F,family="Times",pointsize=10)


###################################################
### chunk number 3: simple10
###################################################
#line 169 "/home/pauljohn/ps/SVN-repo/stat/CentralLimitTheorem/CLT-lecture1.Rnw"
set.seed(324234)
truemean <- 5.353
truesd <- 4.55
ymax <- 0.12
onexset <- rnorm(500, m=truemean, sd=truesd)
m1 <- mean(onexset)
sd1 <- sd(onexset)
hist(onexset, breaks=20, prob=T, xlim=c(truemean-4*truesd, truemean+4*truesd), ylim=c(0,ymax), main="",xlab="Observations from one sample")


###################################################
### chunk number 4: simple20
###################################################
#line 186 "/home/pauljohn/ps/SVN-repo/stat/CentralLimitTheorem/CLT-lecture1.Rnw"
x <- seq(truemean-4*truesd, truemean+4*truesd, by=0.1)
denx <- dnorm(x, m=truemean, s=truesd)
plot(x, denx, type="l",xlim=c(truemean-4*truesd, truemean+4*truesd), ylim=c(0,ymax), ylab="Density")


###################################################
### chunk number 5: simple30
###################################################
#line 198 "/home/pauljohn/ps/SVN-repo/stat/CentralLimitTheorem/CLT-lecture1.Rnw"
plot(x, denx, type="l",xlim=c(truemean-4*truesd, truemean+4*truesd), ylim=c(0,ymax), ylab="Density")

onedensity <- density(onexset)
lines(onedensity, lty=2)
legend("topleft",legend=c("Theoretical (PDF)", "Observed Density"), lty=c(1,2))


###################################################
### chunk number 6: simple40
###################################################
#line 211 "/home/pauljohn/ps/SVN-repo/stat/CentralLimitTheorem/CLT-lecture1.Rnw"
hist(onexset, breaks=20, prob=T, xlim=c(truemean-3*truesd, truemean+3*truesd), ylim=c(0,ymax),   main="",xlab="Observations from one sample")
lines(x, denx, lty=1)
lines(onedensity, lty=2)
legend("topleft", legend=c(paste("Exp. Value=",truemean), paste("Obs. Mean=",round(m1,2))))
legend("topright", legend=c(paste("Pop. Var.=",round(truesd*truesd,2)), paste("Obs. Var.=",round(sd1*sd1,2))))


###################################################
### chunk number 7: p10
###################################################
#line 483 "/home/pauljohn/ps/SVN-repo/stat/CentralLimitTheorem/CLT-lecture1.Rnw"
x <- seq(-10, 10, length.out=500)
pm0sd3 <- dnorm(x, mean=0, sd=3)
pmean <- dnorm(x, mean=0, sd=3/sqrt(100))
pmean2 <- dnorm(x, mean=0, sd=3/sqrt(2000))


###################################################
### chunk number 8: normal1
###################################################
#line 494 "/home/pauljohn/ps/SVN-repo/stat/CentralLimitTheorem/CLT-lecture1.Rnw"
plot(x, pm0sd3, type="l", ylab="density of x",xlab="x") 


###################################################
### chunk number 9: normal2
###################################################
#line 504 "/home/pauljohn/ps/SVN-repo/stat/CentralLimitTheorem/CLT-lecture1.Rnw"
plot(x, pmean, type="l", ylab="density of mean of x",xlab="mean of x")


###################################################
### chunk number 10: normal3
###################################################
#line 514 "/home/pauljohn/ps/SVN-repo/stat/CentralLimitTheorem/CLT-lecture1.Rnw"
 plot(x, pmean2, type="l", ylab="density of mean of x",xlab="mean of x")


###################################################
### chunk number 11: p30
###################################################
#line 561 "/home/pauljohn/ps/SVN-repo/stat/CentralLimitTheorem/CLT-lecture1.Rnw"
x <- seq(0,10)
xdpois <- dpois(x,lambda=3)
plot(x, xdpois, type="h", xlab="a Poisson variate with lambda=3",ylab="Probability")
points(x, xdpois)


###################################################
### chunk number 12: pois10
###################################################
#line 572 "/home/pauljohn/ps/SVN-repo/stat/CentralLimitTheorem/CLT-lecture1.Rnw"
 hist(0.5+rpois(10, lambda=3),xlim=c(0.5,10.5), prob=T, xlab="x", main="Poisson Sample N=10")
 points(x+0.5, xdpois)


###################################################
### chunk number 13: pois20
###################################################
#line 576 "/home/pauljohn/ps/SVN-repo/stat/CentralLimitTheorem/CLT-lecture1.Rnw"
 hist(0.5+rpois(100, lambda=3),xlim=c(0.5,10.5),prob=T, xlab="x", main="Poisson Sample N=100")
 points(x+0.5, xdpois, lty=4)


###################################################
### chunk number 14: pois30
###################################################
#line 580 "/home/pauljohn/ps/SVN-repo/stat/CentralLimitTheorem/CLT-lecture1.Rnw"
hist(0.5+rpois(2000, lambda=3),xlim=c(0.5,10.5), prob=T, xlab="x", main="Poisson Sample N=2000")
 points(x+0.5, xdpois, lty=4)


###################################################
### chunk number 15: pois40
###################################################
#line 583 "/home/pauljohn/ps/SVN-repo/stat/CentralLimitTheorem/CLT-lecture1.Rnw"
 hist(0.5+rpois(10000, lambda=3),xlim=c(0.5,10.5), prob=T, xlab="x", main="Poisson Sample N=10000")
 points(x+0.5, xdpois, lty=4)


###################################################
### chunk number 16: pois81
###################################################
#line 618 "/home/pauljohn/ps/SVN-repo/stat/CentralLimitTheorem/CLT-lecture1.Rnw"
   m10 <- replicate(1000, mean(rpois(10, lambda=3)))
   hist(m10,xlim=c(0.5,10.5), prob=T, xlab="x", main="Means with N=10")


###################################################
### chunk number 17: pois82
###################################################
#line 628 "/home/pauljohn/ps/SVN-repo/stat/CentralLimitTheorem/CLT-lecture1.Rnw"
m100 <- replicate(1000, mean(rpois(100, lambda=3)))
hist(m100,xlim=c(0.5,10.5),prob=T, xlab="x", main="Means with N=100")


###################################################
### chunk number 18: pois83
###################################################
#line 639 "/home/pauljohn/ps/SVN-repo/stat/CentralLimitTheorem/CLT-lecture1.Rnw"
 m2000 <- replicate(1000, mean(rpois(2000, lambda=3)))
 
 hist(m2000,xlim=c(0.5,10.5), prob=T, xlab="x", main="Means with N=2000")



###################################################
### chunk number 19: pois84
###################################################
#line 652 "/home/pauljohn/ps/SVN-repo/stat/CentralLimitTheorem/CLT-lecture1.Rnw"
m10000 <- replicate(1000, mean(rpois(10000, lambda=3)))
hist(m10000,xlim=c(0.5,10.5), prob=T, xlab="x", main="Means with N=10000")


###################################################
### chunk number 20: pois85
###################################################
#line 664 "/home/pauljohn/ps/SVN-repo/stat/CentralLimitTheorem/CLT-lecture1.Rnw"
hist(m10000, prob=T, xlab="x", main="Means with N=10000")
lines(density(m10000),lty=2)
mp <- mean(m10000)
sdp <- sd(m10000)
xp <- seq(range(m10000)[1], range(m10000)[2], length=200)
npd <- dnorm(xp, m=mp, s=sdp)
lines(xp, npd, lty=1)
legend("topright",legend=c("Observed","Theoretical"), lty=c(2,1))


###################################################
### chunk number 21: U10
###################################################
#line 681 "/home/pauljohn/ps/SVN-repo/stat/CentralLimitTheorem/CLT-lecture1.Rnw"
x <- seq(0,1, by=0.01)
xdunif <- dunif(x)
plot(x, xdunif, type="l", xlab="A Uniform Variate",ylab="Probability")
lines(c(0,0),c(0,1),lty=4)
lines(c(1,1),c(0,1),lty=4)


###################################################
### chunk number 22: u21
###################################################
#line 695 "/home/pauljohn/ps/SVN-repo/stat/CentralLimitTheorem/CLT-lecture1.Rnw"
un1 <- replicate(1000, mean(runif(30)))
hist(un1, xlim=c(0,1), prob=T, xlab="x", main="Means with N=30")


###################################################
### chunk number 23: u22
###################################################
#line 706 "/home/pauljohn/ps/SVN-repo/stat/CentralLimitTheorem/CLT-lecture1.Rnw"
un1 <- replicate(1000, mean(runif(500)))
hist(un1,xlim=c(0,1), prob=T, xlab="x", main="Means with N=500")


###################################################
### chunk number 24: u23
###################################################
#line 717 "/home/pauljohn/ps/SVN-repo/stat/CentralLimitTheorem/CLT-lecture1.Rnw"
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
### chunk number 25: b10
###################################################
#line 736 "/home/pauljohn/ps/SVN-repo/stat/CentralLimitTheorem/CLT-lecture1.Rnw"
x <- seq(0.001,0.999, by=0.001)
xd <- dbeta(x, 0.9, 0.9)
plot(x, xd, type="l", xlab="A Beta Variate",ylab="Probability")
lines(c(0,0),c(0,xd[1]),lty=4)
lines(c(1,1),c(0,xd[1]),lty=4)


###################################################
### chunk number 26: b23
###################################################
#line 749 "/home/pauljohn/ps/SVN-repo/stat/CentralLimitTheorem/CLT-lecture1.Rnw"
un1 <- replicate(100, mean(rbeta(2000, 0.9, 0.9)))
hist(un1,xlim=c(0.45,0.55), breaks=10, prob=T, xlab="x", main="")
lines(density(un1),lty=2)
mp <- mean(un1)
sdp <- sd(un1)
xp <- seq(range(un1)[1], range(un1)[2], length=200)
npd <- dnorm(xp, m=mp, s=sdp)
lines(xp, npd, lty=1)
legend("topright",legend=c("Observed","Theoretical"), lty=c(2,1))


