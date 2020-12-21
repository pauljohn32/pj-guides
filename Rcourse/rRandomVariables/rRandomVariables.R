### R code from vignette source '/home/pauljohn/SVN/SVN-guides/Rcourse/rRandomVariables/rRandomVariablesn.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: p50
###################################################
##don't unlink, unless you want to run Tweedy again
##unlink("plots", recursive= TRUE)
dir.create("plots", showWarnings = FALSE)


###################################################
### code chunk number 2: Roptions
###################################################
options(width=180, prompt="> ", continue="  ")
options(useFancyQuotes = FALSE)
set.seed(12345)
op <- par()
pjmar <- c(5.1, 4.1, 1.5, 2.1)
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=10)))
pdf.options(onefile=F, family = "Times", pointsize = 10)


###################################################
### code chunk number 3: cauchy10
###################################################
set.seed(234234)
rcauchy(6)


###################################################
### code chunk number 4: cauchy20
###################################################
x <- rcauchy(500)
hist(x, prob= TRUE, main="500 Cauchies")


###################################################
### code chunk number 5: cauchy30
###################################################
x <- rcauchy(5000)
hist(x, prob= TRUE, main="5000 Cauchies")


###################################################
### code chunk number 6: cauchy40
###################################################
hist(x, prob= TRUE, breaks = 50, main="5000 Cauchies")


###################################################
### code chunk number 7: cauchy50
###################################################
hist(x[ x > -50 & x < 50], xlab="x, excluding observations outside (-50,50)", prob= TRUE, breaks = 50, main="5000 Cauchies")


###################################################
### code chunk number 8: rRandomVariablesn.Rnw:228-230
###################################################
excludedX <- x[ x < -50 | x > 50]
sort(excludedX)


###################################################
### code chunk number 9: cauchy60
###################################################
library(rockchalk)
mydf <- data.frame(x = x)
summarizeNumerics(mydf)


###################################################
### code chunk number 10: cauchy80
###################################################
boxplot(x, main="Cauchy")


###################################################
### code chunk number 11: d01b
###################################################
xmean <- 43; xsd <- 7
xrange <- c(xmean-4*xsd, xmean+4*xsd)
curve(dnorm(x, m = xmean, sd= xsd), from = xrange[1], to = xrange[2])
title("The Normal density, mu = 43, sigma = 7")


###################################################
### code chunk number 12: d02
###################################################
xseq <- seq(from = xrange[1], to = xrange[2], length.out = 100)


###################################################
### code chunk number 13: d06
###################################################
dxseq <- dnorm(xseq, m=xmean, sd=xsd)


###################################################
### code chunk number 14: d10
###################################################
plot(dxseq ~ xseq, type = "l", ylim = c(0,1.2* max(dxseq)), xlab = "x", ylab = paste("dnorm(x, m=",xmean,", sd=", xsd,")"), main = paste("Normal PDF with Expected value = ",xmean," and sigma =", xsd))


###################################################
### code chunk number 15: d10b
###################################################
plot(dxseq ~ xseq, type="n", ylim=c(0,1.2* max(dxseq)), xlab="x",ylab=paste("dnorm(x, m=", xmean,", sd=", xsd,")"))
lines(xseq, dxseq)
title(paste("Normal PDF with Expected value = ", xmean," and sigma =", xsd))


###################################################
### code chunk number 16: d20
###################################################
shape <- 1.1; scale <- 2.2
xrange <- c(0.0001, 5*shape*scale)
xseq <- seq( xrange[1], xrange[2], length.out = 200)


###################################################
### code chunk number 17: d21
###################################################
dxseq <- dgamma(xseq, shape=shape, scale=scale)


###################################################
### code chunk number 18: d22
###################################################
plot(dxseq ~ xseq, type="l", ylim=c(0,1.2* max(dxseq)), xlab="x",ylab=paste("dgamma(x, shape=",shape,", scale=",scale,")"), main=paste("PDF of Gamma(",shape,",",scale,")"))


###################################################
### code chunk number 19: d23a
###################################################
shape <- 2.2; scale <- 2.5
xrange <- c(0.0001, 5*shape*scale)
xseq <- seq( xrange[1], xrange[2], length.out = 200)
dxseq <- dgamma(xseq, shape=shape, scale=scale)
plot(dxseq ~ xseq, type="l", ylim=c(0,1.2* max(dxseq)), xlab="x",ylab=paste("dgamma(x, shape=",shape,", scale=",scale,")"), main=paste("PDF of Gamma(",shape,",",scale,")"))


###################################################
### code chunk number 20: d23b
###################################################
shape <- 12.5; scale <- 0.5
xrange <- c(0.0001, 5*shape*scale)
xseq <- seq( xrange[1], xrange[2], length.out = 200)
dxseq <- dgamma(xseq, shape=shape, scale=scale)
plot(dxseq ~ xseq, type="l", ylim=c(0,1.2* max(dxseq)), xlab="x",ylab=paste("dgamma(x, shape=",shape,", scale=",scale,")"), main=paste("PDF of Gamma(",shape,",",scale,")"))


###################################################
### code chunk number 21: d23c
###################################################
shape <- 0.5; scale <- 1.5
xrange <- c(0.0001, 5*shape*scale)
xseq <- seq( xrange[1], xrange[2], length.out = 200)
dxseq <- dgamma(xseq, shape=shape, scale=scale)
plot(dxseq ~ xseq, type="l", ylim=c(0,1.2* max(dxseq)), xlab="x",ylab=paste("dgamma(x, shape=",shape,", scale=",scale,")"), main=paste("PDF of Gamma(",shape,",",scale,")"))


###################################################
### code chunk number 22: d30
###################################################
pnorm(-14.434, -7.1, 11)


###################################################
### code chunk number 23: d40
###################################################
m=-7.1; sd=11;
xrange <- c(m-4*sd, m+4*sd)
xseq <- seq( xrange[1], xrange[2], length.out=100)
xnaught <- 3
dxseq <- dnorm(xseq, m=m, sd=sd)
plot(dxseq ~ xseq, type="l", ylim=c(0,1.2* max(dxseq)), xlab="x",ylab=paste("dnorm(x, m=",m,", sd=",sd,")"), main=paste("Shaded Area = Probability of x Smaller than",xnaught,")"))
segments(xnaught,0,xnaught, dnorm(xnaught, m=m, sd=sd), lty=2)
polygon(c(xseq[xseq < xnaught], xnaught, xnaught, min(xseq)), c(dxseq[xseq < xnaught], dnorm(xnaught, m=m, sd=sd), 0, 0), col=gray(0.95))
area <- round(pnorm(xnaught, m=m, sd=sd),2)
text(-15, 0.001, paste("Area= ",area,"= \n pnorm(",xnaught,", m=",m,", sd=",sd,")",sep=""),pos=3)


###################################################
### code chunk number 24: d50
###################################################
   m= -7.1; sd=11
   xrange <- c(m-4*sd, m+4*sd)
   xseq <- seq(xrange[1], xrange[2], length.out = 100)
   pxseq <- pnorm(xseq, m = m, sd = sd)
   plot(pxseq ~ xseq, type="l", ylim = c(-0.1,1.1), xlab = "x", ylab = paste("pnorm(x, m=",m,",","sd=",sd,")"), main = bquote("CDF of Normal"(.(m) * "," * .(sd)^2)))


###################################################
### code chunk number 25: seed10
###################################################
set.seed(2343234)
runif(3, min = 0, max = 1)
runif(3, min = 0, max = 1)
set.seed(2343234)
runif(3, min = 0, max = 1)


###################################################
### code chunk number 26: simple10
###################################################
set.seed(324234)
m <- -7.1; sd <- 11
onexset <- rnorm(500, m = m, sd = sd)
m1 <- mean(onexset)
sd1 <- sd(onexset)
hist(onexset, breaks = 20, prob= TRUE, xlim=c(-4*sd, m+4*sd), main = "", xlab = "Observations from one sample")


###################################################
### code chunk number 27: simple40
###################################################
xrange <- c(m-4*sd, m+4*sd)
xseq <- seq(xrange[1], xrange[2], length.out = 100)
dxseq <- dnorm(xseq, m = m, sd = sd)
onedensity <- density(onexset)
ymax <- 1.2 * max(dxseq)
hist(onexset, breaks = 20, prob = TRUE, xlim = c(m-3*sd, m+3*sd), ylim = c(0,ymax),   main="",xlab = "x")
lines(xseq, dxseq, lty = 1)

lines(onedensity, lty=2)
legend("topleft", legend = c(paste("Exp. Value=", m), paste("Obs. Mean=", round(m1,2))))
legend("topright", legend = c(paste("Pop. Var.=", round(sd*sd,2)), paste("Obs. Var.=",round(sd1*sd1,2))))
legend("left", legend = c("Theoretical","Observed"), lty = c(1,2))


###################################################
### code chunk number 28: binom10
###################################################
set.seed(2324)
oneBinomial <- rbinom(1, size = 197, prob = 0.2)
oneBinomial


###################################################
### code chunk number 29: binom11
###################################################
oneBinomial <- rbinom(1, size = 197, prob = 0.2)
oneBinomial


###################################################
### code chunk number 30: binom20
###################################################
lotsOfBinomial <- rbinom(481, size = 197, prob = 0.2)
head(lotsOfBinomial)


###################################################
### code chunk number 31: binom30
###################################################
hist(lotsOfBinomial, prob = TRUE, breaks=40, xlab="Number of Successes Out of 197 Experiments", main="481 Draws from Binom(197, 0.2)")


###################################################
### code chunk number 32: binom31
###################################################
lotsOfBinomial2 <- rbinom(481, size=197, prob=0.2)
hist(lotsOfBinomial2, prob = TRUE, breaks = 40, xlab = "Number of Successes Out of 197 Experiments", main = "481 Draws from Binom(197, 0.2)")


###################################################
### code chunk number 33: binom35
###################################################
mean(lotsOfBinomial)
sd(lotsOfBinomial)
mean(lotsOfBinomial2)
sd(lotsOfBinomial2)


###################################################
### code chunk number 34: binom49
###################################################
xseq <- 10:70
xprob <- dbinom(xseq, size = 197, prob = 0.2)


###################################################
### code chunk number 35: binom50
###################################################
plot(xprob ~ xseq, type="h", xlab="Number of Successes", ylab="Probability Mass",  main="Binomial(197, 0.2)")
points(xseq, xprob)


###################################################
### code chunk number 36: binom60
###################################################
x <- rbinom(481, size=1, prob=0.2)
hist(x, prob = TRUE, xlab="Number of Successes Out of 1 Experiments", main="481 Draws from Binom(1, 0.2)")


###################################################
### code chunk number 37: binom61
###################################################
x <- rbinom(481, size=2000, prob=0.2)
hist(x, prob = TRUE, breaks = 50,  xlab = "Number of Successes Out of 2000 Experiments", main="481 Draws from Binom(2000, 0.2)")


###################################################
### code chunk number 38: binom62
###################################################
hist(x, prob = TRUE, breaks = 50,  xlab="Number of Successes Out of 2000 Experiments", main="481 Draws from Binom(2000, 0.2)")
lines(density(x), lty = 2)
xseq <- seq( min(x), max(x), by = 1)
xprob <- dnorm(xseq, m = 2000*0.2, sd = sqrt(2000*(0.2)*(0.8)))
lines(xseq, xprob, lwd = 6)
xbinprob <- dbinom(xseq, size = 2000, prob = 0.2)
lines(xseq, xbinprob, col = 2, lwd = 2, lty = 1)
legend("topright", legend = c("observed KDE","Binom Exact", "Normal Approx"), lty = c(2,1,1), lwd = c(1,2,3), col = c(1,2,1))


###################################################
### code chunk number 39: rRandomVariablesn.Rnw:920-921
###################################################
library(tweedie)


###################################################
### code chunk number 40: tweedie10
###################################################
x <- rtweedie(1000, xi= 1, mu = 10, phi = 1)


###################################################
### code chunk number 41: tweedie10b
###################################################
hist(x, prob = TRUE, xlab = "1000 draws from Tweedie(1,10,1)", ylab = "Density", main="Tweedie(1,10,1)")
legnd <- c( paste("mean = ", round(mean(x),2)), paste("var =", round(var(x),2)), paste("sd = ", round(sd(x),2)))
legend("topright", legend = legnd)


###################################################
### code chunk number 42: tweedie20
###################################################
x <- rtweedie(1000, xi = 1, mu = 50, phi = 1)


###################################################
### code chunk number 43: tweedie20b
###################################################
hist(x, prob = TRUE, xlab = "1000 draws from Tweedie(1,50,1)", ylab = "Density", main="Tweedie(1,50,1)")
legnd <- c( paste("mean = ", round(mean(x),2)), paste("var =", round(var(x),2)), paste("sd = ", round(sd(x),2)))
legend("topright", legend = legnd)


###################################################
### code chunk number 44: tweedie30
###################################################
x <- rtweedie(1000, xi = 1, mu = 1, phi = 1)


###################################################
### code chunk number 45: tweedie30b
###################################################
hist(x, prob = TRUE, xlab = "1000 draws from Tweedie(1,1,1)", ylab = "Density", main = "Tweedie(1,1,1)")
legnd <- c( paste("mean = ", round(mean(x),2)), paste("var =", round(var(x),2)), paste("sd = ", round(sd(x),2)))
legend("topright", legend=legnd)


###################################################
### code chunk number 46: rRandomVariablesn.Rnw:1000-1001
###################################################
table(x)


###################################################
### code chunk number 47: rRandomVariablesn.Rnw:1004-1006
###################################################
x <- rtweedie(1000, xi = 1, mu = 20, phi = 1)
table(x)


###################################################
### code chunk number 48: tweedie60
###################################################
x <- rtweedie(1000, xi= 2, mu = 50, phi = 1)


###################################################
### code chunk number 49: tweedie60b
###################################################
hist(x, prob = TRUE,  xlab = "1000 draws from Tweedie(2,50,1)", ylab = "Density", main = "Tweedie(2,50,1)")
legnd <- c(paste("mean = ", round(mean(x),2)), paste("var =", round(var(x),2)), paste("sd = ", round(sd(x),2)))
legend("topright", legend=legnd)


###################################################
### code chunk number 50: rRandomVariablesn.Rnw:1052-1053
###################################################
head(x)


###################################################
### code chunk number 51: tweedie70
###################################################
x <- rtweedie(1000, xi= 3, mu = 50, phi = 1)
##x <- rtweedie(10, xi= 3, mu = 50, phi = 1)


###################################################
### code chunk number 52: tweedie70b
###################################################
hist(x, prob= TRUE, xlab="1000 draws from Tweedie(3,50,1)", ylab="Density", main="Tweedie(3,50,1)")
legnd <- c( paste("mean = ", round(mean(x),2)), paste("var =", round(var(x),2)), paste("sd = ", round(sd(x),2)))
legend("topright", legend=legnd)


###################################################
### code chunk number 53: tweedie80
###################################################
x <- rtweedie(1000, xi= 2, mu = 1, phi = 1)


###################################################
### code chunk number 54: tweedie80b
###################################################
hist(x, prob = TRUE, xlab = "1000 draws from Tweedie(3,1,1)", ylab = "Density", main = "Tweedie(3,1,1)")
legnd <- c( paste("mean = ", round(mean(x),2)), paste("var =", round(var(x),2)), paste("sd = ", round(sd(x),2)))
legend("topright", legend = legnd)


###################################################
### code chunk number 55: p10
###################################################
xseq <- seq(-10, 10, length.out = 500)
pm0sd3 <- dnorm(xseq, mean = 0, sd = 3)
pmean <- dnorm(xseq, mean = 0, sd = 3/sqrt(100))
pmean2 <- dnorm(xseq, mean = 0, sd = 3/sqrt(2000))


###################################################
### code chunk number 56: normal1
###################################################
plot(pm0sd3 ~ xseq, type = "l", ylab = "density of x", xlab = "x")


###################################################
### code chunk number 57: normal2
###################################################
plot(pmean ~ xseq, type = "l", ylab = "density of mean of x", xlab = "mean of x")


###################################################
### code chunk number 58: p30
###################################################
xseq <- seq(0,10)
xdpois <- dpois(xseq,lambda=3)
plot(xdpois ~ xseq, type = "h", xlab = "a Poisson variate with lambda=3", ylab = "Probability", ylim = c(0, 1.2*max(xdpois)) )
points(xseq, xdpois)


###################################################
### code chunk number 59: pois20
###################################################
 hist(0.5+rpois(100, lambda = 3), xlim = c(0.5, 10.5), prob = TRUE, xlab = "x", main = "Poisson Sample N=100")
 points(xseq+0.5, xdpois, lty=4)


###################################################
### code chunk number 60: pois82
###################################################
m100 <- replicate(1000, mean(rpois(100, lambda=3)))
hist(m100, xlim = c(0.5,10.5), prob = TRUE, xlab = "x", main = "Means with N=100")


###################################################
### code chunk number 61: pois30
###################################################
hist(0.5+rpois(2000, lambda=3), xlim = c(0.5,10.5), prob = TRUE, xlab = "x", main = "Poisson Sample N=2000")
 points(xseq+0.5, xdpois, lty=4)


###################################################
### code chunk number 62: pois83
###################################################
 m2000 <- replicate(1000, mean(rpois(2000, lambda = 3)))
 hist(m2000, xlim = c(0.5, 10.5), prob = TRUE, xlab = "x", main = "Means with N=2000")


###################################################
### code chunk number 63: pois85
###################################################
hist(m2000, prob = TRUE, xlab = "x", main = "Means with N=2000")
lines(density(m2000), lty = 2)
mp <- mean(m2000)
sdp <- sd(m2000)
xp <- seq(range(m2000)[1], range(m2000)[2], length = 200)
npd <- dnorm(xp, m = mp, s = sdp)
lines(xp, npd, lty = 1)
legend("topright",legend=c("Observed","Theoretical"), lty=c(2,1))


###################################################
### code chunk number 64: U10
###################################################
xseq <- seq(0,1, by=0.01)
xdunif <- dunif(xseq)
plot(xdunif ~ xseq, type="l", xlab="A Uniform Variate",ylab="Probability")
lines(c(0,0),c(0,1),lty=4)
lines(c(1,1),c(0,1),lty=4)


###################################################
### code chunk number 65: u21
###################################################
un1 <- replicate(1000, mean(runif(30)))
hist(un1, xlim=c(0,1), prob= TRUE, xlab="x", main="Means with N=30")


###################################################
### code chunk number 66: u22
###################################################
un1 <- replicate(1000, mean(runif(500)))
hist(un1,xlim=c(0,1), prob= TRUE, xlab="x", main="Means with N=500")


###################################################
### code chunk number 67: u23
###################################################
un1 <- replicate(100, mean(runif(2000)))
hist(un1,xlim=c(0.45,0.55), breaks=20, prob= TRUE, xlab="x", main="Means with N=2000")
lines(density(un1),lty=2)
mp <- mean(un1)
sdp <- sd(un1)
xseqp <- seq(range(un1)[1], range(un1)[2], length=200)
npd <- dnorm(xseqp, m=mp, s=sdp)
lines(xseqp, npd, lty=1)
legend("topright",legend=c("Observed","Theoretical"), lty=c(2,1))


###################################################
### code chunk number 68: b10
###################################################
xseq <- seq(0.001,0.999, by=0.001)
xd <- dbeta(xseq, 0.9, 0.9)
plot(xd ~ xseq, type="l", xlab="A Beta Variate",ylab="Probability")
lines(c(0,0),c(0,xd[1]),lty=4)
lines(c(1,1),c(0,xd[1]),lty=4)


###################################################
### code chunk number 69: b23
###################################################
un1 <- replicate(100, mean(rbeta(2000, 0.9, 0.9)))
hist(un1,xlim=c(0.45,0.55), breaks=10, prob= TRUE, xlab="x", main="")
lines(density(un1),lty=2)
mp <- mean(un1)
sdp <- sd(un1)
xseqp <- seq(range(un1)[1], range(un1)[2], length=200)
npd <- dnorm(xseqp, m=mp, s=sdp)
lines(xseqp, npd, lty=1)
legend("topright",legend=c("Observed","Theoretical"), lty=c(2,1))


###################################################
### code chunk number 70: replic10
###################################################
grabTofB <- function(){
    x <- rpois(1000, lambda=17)
    y <- 2 + .223 * x + 15 * rnorm(1000)
    seB <- coef(summary(lm(y~x)))[2,3]
}
rep1000<- replicate(1000,grabTofB())
m1000 <- round(mean(rep1000),2)
sd1000 <- round(sd(rep1000),2)
h1000 <- hist(rep1000, prob= TRUE, main="Distribution of T Statistics for Slope", xlab="T stat for slope estimate")
legend("topright",legend=c(paste("mean=",m1000),paste("sd=",sd1000)))


###################################################
### code chunk number 71: rgw10
###################################################
set.seed(1234)
x1 <- rnorm(3)
x2 <- rpois(3, lambda = 7)
x3 <- rnorm(3)
X <- cbind(x1, x2, x3)
X


###################################################
### code chunk number 72: rgw20 (eval = FALSE)
###################################################
## set.seed(1234)
## x1 <- rnorm(3)
## x2 <- rgamma(3, 1, 1)
## x3 <- rnorm(3)
## Y <- cbind(x1, x2, x3)


###################################################
### code chunk number 73: rgw25
###################################################
X


###################################################
### code chunk number 74: rgw30
###################################################
set.seed(1234)
x1 <- rnorm(3)
x2 <- rgamma(3, 1, 1)
x3 <- rnorm(3)
Y <- cbind(x1, x2, x3)


###################################################
### code chunk number 75: rgw50
###################################################
  set.seed(12345)
  X0 <- MASS::mvrnorm(n=10, mu = c(0,0,0), Sigma = diag(3))
  ## create a smaller data set, starting at same position
  set.seed(12345)
  X1 <- MASS::mvrnorm(n=5, mu = c(0,0,0), Sigma = diag(3))
  ## Create a larger data set
  set.seed(12345)
  X2 <- MASS::mvrnorm(n=15, mu = c(0,0,0), Sigma = diag(3))


###################################################
### code chunk number 76: rRandomVariablesn.Rnw:1523-1526
###################################################
X0[1:5, ]
X1[1:5, ]
X2[1:5, ]


###################################################
### code chunk number 77: rRandomVariablesn.Rnw:1554-1557
###################################################
X0[1:5, ]
X1[1:5, ]
X2[1:5, ]


###################################################
### code chunk number 78: rgw70
###################################################
  library(mvtnorm)
  set.seed(12345)
  X0 <- mvtnorm::rmvnorm(n=10, mean = c(0,0,0), sigma = diag(3))
  ## create a smaller data set, starting at same position
  set.seed(12345)
  X1 <- mvtnorm::rmvnorm(n=5,  mean = c(0,0,0), sigma = diag(3))
  X0
  X1


