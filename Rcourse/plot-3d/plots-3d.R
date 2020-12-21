### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.T21527/lyx_tmpbuf2/plots-3d.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: plots-3d.Rnw:23-24
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: plots-3d.Rnw:73-74
###################################################
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(device = pdf)
options(width=160, prompt="> ", continue="+  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par() 
pjmar <- c(5.1, 5.1, 1.5, 2.1) 
#pjmar <- par("mar")
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 4: threed10
###################################################
x1 <- rnorm(100); x2 <- -4 + rpois(100,lambda=4);
y = 0.1 * x1 + 0.2 *x2 + rnorm(100);
dat <- data.frame(x1, x2, y); rm (x1, x2, y)
m1 <- lm(y ~ x1 + x2, data=dat)
summary(m1)


###################################################
### code chunk number 5: threed15
###################################################
x1r <- range(dat$x1)
x1seq <- seq(x1r[1], x1r[2], length = 30)
x2r <- range(dat$x2) 
x2seq <- seq(x2r[1], x2r[2], length = 30)


###################################################
### code chunk number 6: threed20
###################################################
z <- outer(x1seq, x2seq, function(a, b) predict(m1, newdata = data.frame(x1 = a, x2 = b)))


###################################################
### code chunk number 7: threed30
###################################################
persp(x = x1seq, y = x2seq, z = z)


###################################################
### code chunk number 8: threed40
###################################################
persp(x = x1seq, y = x2seq, z = z, zlim = c(-3,3), theta = 40)


###################################################
### code chunk number 9: threed50
###################################################
persp(x = x1seq, y = x2seq, z = z, zlim = c(-3,3), theta = 40, phi = -20)


###################################################
### code chunk number 10: threed60
###################################################
res <- persp(x = x1seq, y = x2seq, z = z, zlim = c(-3,3), theta = 40, phi = -15)
mypoints <- trans3d(dat$x1, dat$x2, dat$y, pmat = res)
points(mypoints, pch = 1, col = "red")


###################################################
### code chunk number 11: threed70
###################################################
res <- persp(x = x1seq, y = x2seq, z = z, zlim = c(-3,3), theta = 40, phi = -15)
mypoints <- trans3d(dat$x1, dat$x2, dat$y, pmat = res)
points(mypoints, pch = 1, col = "red")
vpred <- trans3d(dat$x1, dat$x2, fitted(m1),   pmat = res) 
vobs <- trans3d(dat$x1, dat$x2, dat$y,   pmat = res) 
segments(vpred$x, vpred$y, vobs$x, vobs$y, col = "red", lty = 2)


###################################################
### code chunk number 12: threed71
###################################################
res <- persp(x = x1seq, y = x2seq, z = z, zlim = c(-3,3), theta = 40, phi = -15)
mypoints <- trans3d(dat$x1, dat$x2, dat$y, pmat = res)
points(mypoints, pch = 1, col = "red")
res <- persp(x = x1seq, y = x2seq, z = z, zlim = c(-3,3), theta = 40, phi = -15)
mypoints <- trans3d(dat$x1, dat$x2, dat$y, pmat = res)
points(mypoints, pch = 1, col = "red")
vpred <- trans3d(dat$x1, dat$x2, fitted(m1),   pmat = res) 
vobs <- trans3d(dat$x1, dat$x2, dat$y,   pmat = res) 
segments(vpred$x, vpred$y, vobs$x, vobs$y, col = "red", lty = 2)


###################################################
### code chunk number 13: threed80
###################################################
x1 <- rnorm(100); x2 <- rpois(100,lambda=4) 
logist <- function(x1,x2){
y <- 1/(1 + exp((-1)*(-3 + 0.6*x1 + .5*x2))) } 
par(bg = "white") 
x1r <- range(x1) ; x1seq <- seq(x1r[1], x1r[2], length = 30)
x2r <- range(x2) ; x2seq <- seq(x2r[1], x2r[2], length = 30)
z <- outer(x1seq, x2seq, logist)
persp(x = x1seq, y = x2seq, z = z, theta = -30, zlim = c(-0.2,1.2))


###################################################
### code chunk number 14: threed200
###################################################
nrz <- nrow(z)
ncz <- ncol(z)
# Create a function interpolating colors in the range of specified colors
jet.colors <- colorRampPalette( c("blue", "green") )
# Generate the desired number of colors from this palette
nbcol <- 100
color <- jet.colors(nbcol)
# Compute the z-value at the facet centres
zfacet <- z[-1, -1] + z[-1, -ncz] + z[-nrz, -1] + z[-nrz, -ncz]
# Recode facet z-values into color indices
facetcol <- cut(zfacet, nbcol)
persp(x = x1seq, y = x2seq, z = z, col = color[facetcol], theta = -30, zlim = c(-0.2,1.2))


###################################################
### code chunk number 15: scatter3d04
###################################################
library(scatterplot3d)
x <- rnorm(80); y <- rpois(80,l=7); z <- 3 + 1.1*x + 0.4*y + 15*rnorm(80)
s3d <- scatterplot3d(x, y, z)


###################################################
### code chunk number 16: scatter3d05
###################################################
library(scatterplot3d)
s3d <- scatterplot3d(x, y, z, type = "p", color = "blue", angle = 45, pch = 18, main = "", xlab = "normal x", ylab = "poisson y", zlab = "linear z")


###################################################
### code chunk number 17: scatter3d10
###################################################
library(scatterplot3d)
s3d <- scatterplot3d(dat, type = "p", color = "blue", angle = 55, pch = 16, main = "", xlab = "x1", ylab = "x2", zlab = "y")


###################################################
### code chunk number 18: scatter3d11
###################################################
library(scatterplot3d)
s3d <- scatterplot3d(dat, type = "p", color = "blue", angle = 55, pch = 16, main = "scatterplot3d")
s3d$plane3d(m1)


###################################################
### code chunk number 19: scatter3d12
###################################################
s3d <- scatterplot3d(dat, type = "p", color = "blue", angle = 55, pch = 16, main = "scatterplot3d")
s3d$plane3d(m1, lty = "dotted", lwd = 0.7)
obser2d <- s3d$xyz.convert(dat$x1, dat$x2, dat$y)
pred2d <- s3d$xyz.convert(dat$x1, dat$x2, fitted(m1))
segments(obser2d$x, obser2d$y, pred2d$x, pred2d$y, lty = 4)


###################################################
### code chunk number 20: plots-3d.Rnw:802-803
###################################################
attributes(s3d)


###################################################
### code chunk number 21: scatter3d20
###################################################
library(mvtnorm) 
x1 <- x2 <- seq(-10, 10, length = 51) 
dens <- matrix(dmvnorm(expand.grid(x1, x2), sigma = rbind(c(3, 2), c(2, 3))), ncol = length(x1)) 
s3d <- scatterplot3d(x1, x2, seq(min(dens), max(dens), length = length(x1)), type = "n", grid = FALSE, angle = 70, zlab = expression(f(x[1], x[2])), xlab = expression(x[1]), ylab = expression(x[2]), main = "Bivariate normal distribution")
for(i in length(x1):1) {
  s3d$points3d(rep(x1[i], length(x2)), x2, dens[i,], type = "l") 
}
for(i in length(x2):1) { 
  s3d$points3d(x1, rep(x2[i], length(x1)), dens[,i], type = "l")
}
 text(s3d$xyz.convert(-1, 10, 0.07),
        labels = expression(f(x) == frac(1, sqrt((2 * pi)^n *
            phantom(".") * det(Sigma[X]))) * phantom(".") * exp * {
            bgroup("(", - scriptstyle(frac(1, 2) * phantom(".")) *
                (x - mu)^T * Sigma[X]^-1 * (x - mu), ")")}))

### fix. insert {} around Sigma[X] == ... ##
 text(s3d$xyz.convert(1.5, 10, 0.05),
        labels = expression("with" * phantom("m") *
            mu == bgroup("(", atop(0, 0), ")") * phantom(".") * "," *
                phantom(0) * {Sigma[X] == bgroup("(", atop(3 * phantom(0) * 2,
                2 * phantom(0) * 3), ")") }) )


###################################################
### code chunk number 22: scatter3d30
###################################################
x1 <- x2 <- seq(-10, 10, length = 51) 
dens <- matrix(dmvnorm(expand.grid(x1, x2), sigma = rbind(c(3, 2), c(2, 3))), ncol = length(x1)) 
s3d <- scatterplot3d(x1, x2, seq(min(dens), max(dens), length = length(x1)), type = "n", grid = FALSE, angle = 70, zlab = expression(f(x[1], x[2])), xlab = expression(x[1]), ylab = expression(x[2]), main = "Bivariate normal distribution")


###################################################
### code chunk number 23: scatter3d30b
###################################################
for(i in length(x1):1){
   s3d$points3d(rep(x1[i], length(x2)), x2, dens[i,], type = "l")
}


###################################################
### code chunk number 24: scatter3d40
###################################################
x1 <- x2 <- seq(-10, 10, length = 51) 
dens <- matrix(dmvnorm(expand.grid(x1, x2), sigma = rbind(c(3, 2), c(2, 3))), ncol = length(x1)) 
s3d <- scatterplot3d(x1, x2, seq(min(dens), max(dens), length = length(x1)), type = "n", grid = FALSE, angle = 70, zlab = expression(f(x[1], x[2])), xlab = expression(x[1]), ylab = expression(x[2]), main = "Bivariate normal distribution")
for(i in length(x1):1){
   s3d$points3d(rep(x1[i], length(x2)), x2, dens[i,], type = "l")
}


###################################################
### code chunk number 25: scatter3d30c
###################################################
for(i in length(x2):1) {
  s3d$points3d(x1, rep(x2[i], length(x1)), dens[,i], type = "l")
}


###################################################
### code chunk number 26: scatter3d50
###################################################
x1 <- x2 <- seq(-10, 10, length = 51) 
dens <- matrix(dmvnorm(expand.grid(x1, x2), sigma = rbind(c(3, 2), c(2, 3))), ncol = length(x1)) 
s3d <- scatterplot3d(x1, x2, seq(min(dens), max(dens), length = length(x1)), type = "n", grid = FALSE, angle = 70, zlab = expression(f(x[1], x[2])), xlab = expression(x[1]), ylab = expression(x[2]), main = "Bivariate normal distribution")
for(i in length(x1):1){
   s3d$points3d(rep(x1[i], length(x2)), x2, dens[i,], type = "l")
}
for(i in length(x2):1) {
  s3d$points3d(x1, rep(x2[i], length(x1)), dens[,i], type = "l")
}


###################################################
### code chunk number 27: scatter3d30d
###################################################
text(s3d$xyz.convert(-1, 10, 0.07),labels = expression(f(x) == frac(1, sqrt((2 * pi)^n * phantom(".") * det(Sigma[X]))) * phantom(".") * exp * { bgroup("(", - scriptstyle(frac(1, 2) * phantom(".")) *
(x - mu)^T * Sigma[X]^-1 * (x - mu), ")")}))

### fix. insert {} around Sigma[X] == ... ##
text(s3d$xyz.convert(1.5, 10, 0.05), labels = expression("with" * phantom("m") * mu == bgroup("(", atop(0, 0), ")") * phantom(".") * "," * phantom(0) * {Sigma[X] == bgroup("(", atop(3 * phantom(0) * 2, 2 * phantom(0) * 3), ")") }) )


###################################################
### code chunk number 28: scatter3d70
###################################################
x1 <- x2 <- seq(-10, 10, length = 51) 
dens <- matrix(dmvnorm(expand.grid(x1, x2), sigma = rbind(c(3, 2), c(2, 3))), ncol = length(x1)) 
s3d <- scatterplot3d(x1, x2, seq(min(dens), max(dens), length = length(x1)), type = "n", grid = FALSE, angle = 70, zlab = expression(f(x[1], x[2])), xlab = expression(x[1]), ylab = expression(x[2]), main = "Bivariate normal distribution")
for(i in length(x1):1){
   s3d$points3d(rep(x1[i], length(x2)), x2, dens[i,], type = "l")
}
for(i in length(x2):1) {
  s3d$points3d(x1, rep(x2[i], length(x1)), dens[,i], type = "l")
}
text(s3d$xyz.convert(-1, 10, 0.07),labels = expression(f(x) == frac(1, sqrt((2 * pi)^n * phantom(".") * det(Sigma[X]))) * phantom(".") * exp * { bgroup("(", - scriptstyle(frac(1, 2) * phantom(".")) *
(x - mu)^T * Sigma[X]^-1 * (x - mu), ")")}))

### fix. insert {} around Sigma[X] == ... ##
text(s3d$xyz.convert(1.5, 10, 0.05), labels = expression("with" * phantom("m") * mu == bgroup("(", atop(0, 0), ")") * phantom(".") * "," * phantom(0) * {Sigma[X] == bgroup("(", atop(3 * phantom(0) * 2, 2 * phantom(0) * 3), ")") }) )


###################################################
### code chunk number 29: mc1-0
###################################################
## Create data with x1 and x2 correlated at 0.10
require(rockchalk)
dat <- genCorrelatedData(rho=0.10, stde=7)
par(mar= c(1,1,1,1))


###################################################
### code chunk number 30: mc1-1
###################################################
mod1 <- mcGraph1(dat$x1, dat$x2, dat$y, theta=-30, phi=8)


###################################################
### code chunk number 31: mc-2-1
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, rescaley = 0.1, theta = -30)


###################################################
### code chunk number 32: mc-2-3
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, rescaley = 0.2, theta = -30)


###################################################
### code chunk number 33: mc-2-5
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, rescaley = 0.3, theta = -30)


###################################################
### code chunk number 34: mc-2-6
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, rescaley = 0.4, theta = -30)


###################################################
### code chunk number 35: mc-2-7
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, rescaley = 0.5, theta = -30)


###################################################
### code chunk number 36: mc-2-8
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, rescaley = 0.6, theta = -30)


###################################################
### code chunk number 37: mc-2-9
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, rescaley = 0.7, theta = -30)


###################################################
### code chunk number 38: mc-2-10
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, rescaley = 0.80, theta = -30)


###################################################
### code chunk number 39: mc-2-11
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, rescaley = 0.90, theta = -30)


###################################################
### code chunk number 40: mc-2-13
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, rescaley = 1.0, theta = -30)


###################################################
### code chunk number 41: mc-2-20
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, rescaley = 1.0, theta = 20)


###################################################
### code chunk number 42: mc-2-21
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, rescaley = 1.0, theta = 40)


###################################################
### code chunk number 43: mc-2-22
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, rescaley = 1.0, theta = 60)


###################################################
### code chunk number 44: mc-2-23
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, rescaley = 1.0, theta = 80)


###################################################
### code chunk number 45: mc-2-50
###################################################
mod1 <- mcGraph3(dat$x1, dat$x2, dat$y, theta = -30)


###################################################
### code chunk number 46: mc-2-50m
###################################################
outreg(mod1[[1]], tight=FALSE)


###################################################
### code chunk number 47: mc-2-51
###################################################
mod1 <- mcGraph3(dat$x1, dat$x2, dat$y, theta = -10, phi=0)


###################################################
### code chunk number 48: mc-2-51m
###################################################
outreg(mod1[[1]], tight=FALSE)


###################################################
### code chunk number 49: mc-2-52
###################################################
mod1 <- mcGraph3(dat$x1, dat$x2, dat$y, theta = -10, phi=-10)


###################################################
### code chunk number 50: mc-2-52m
###################################################
mod1 <- mcGraph3(dat$x1, dat$x2, dat$y, theta = -10, phi=-10)
outreg(mod1[[1]], tight=FALSE)


###################################################
### code chunk number 51: plots-3d.Rnw:1532-1535
###################################################
## Create data with x1 and x2 correlated at 0.10
rm(dat)
dat2 <- genCorrelatedData(rho=0.9, stde=7)


###################################################
### code chunk number 52: plots-3d.Rnw:1539-1540
###################################################
par(mar=c(0.5,0.5,0.5,0.5))


###################################################
### code chunk number 53: mc-3-1
###################################################
mod2 <- mcGraph1(dat2$x1, dat2$x2, dat2$y, theta=20, phi=8)


###################################################
### code chunk number 54: plots-3d.Rnw:1569-1570
###################################################
par(mar=c(0.5,0.5,0.5,0.5))


###################################################
### code chunk number 55: plots-3d.Rnw:1574-1575
###################################################
par(mar=c(0.5,0.5,0.5,0.5))


###################################################
### code chunk number 56: mc-3-2
###################################################
mod <- mcGraph2(dat2$x1, dat2$x2, dat2$y, theta = -30)


###################################################
### code chunk number 57: plots-3d.Rnw:1603-1604
###################################################
par(mar=c(0.5,0.5,0.5,0.5))


###################################################
### code chunk number 58: mc-3-3
###################################################
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)


###################################################
### code chunk number 59: mc-3-3m
###################################################
outreg(mod[[1]], tight=F)


###################################################
### code chunk number 60: plots-3d.Rnw:1643-1644
###################################################
par(mar=c(0.5,0.5,0.5,0.5))


###################################################
### code chunk number 61: mc-3-4
###################################################
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, interaction=TRUE, theta = -30)


###################################################
### code chunk number 62: mc-3-4m
###################################################
outreg(mod[[1]], tight=F)


###################################################
### code chunk number 63: pp10
###################################################
dat3 <- genCorrelatedData(N=150, beta = c(0, 0.15, 0.25, 0.1), stde = 150)
dat3$x3 <- rpois(150, lambda = 7)
dat3$x4 <- rgamma(150, 2, 1)
m1 <- lm(y ~ x1 + x2 + x3 + x4, data=dat3)


###################################################
### code chunk number 64: pp10m
###################################################
outreg(m1, tight = F)
par(mar=c(1,0.5,0.5,0.5))


###################################################
### code chunk number 65: pp20
###################################################
plotPlane(m1, plotx1 = "x1", plotx2 = "x2", theta = -40, npp = 15, drawArrows = TRUE)


###################################################
### code chunk number 66: pp25
###################################################
plotPlane(m1, plotx1 = "x1", plotx2 = "x2", theta = -40, npp = 8, llwd = 0.105, drawArrows = TRUE, ticktype = "detailed")


###################################################
### code chunk number 67: pp30
###################################################
ps30 <- plotSlopes(m1, plotx = "x1", modx = "x2", modxVals = "std.dev.", llwd = 3)


###################################################
### code chunk number 68: pp50
###################################################
## method 1: "linesFrom" in plotPlane
#pp50 <- plotPlane(m1, plotx1 = "x1", plotx2 = "x2", linesFrom = ps30)
## method 2: addLines as secondary step:
pp50 <- plotPlane(m1, plotx1 = "x1", plotx2 = "x2", llwd = 1, npp = 8)
addLines(to = pp50, from = ps30, lwd = 6)


###################################################
### code chunk number 69: pp100A
###################################################
xf <- gl(4, 20)
xfn <- as.numeric(xf)
x1 <- rnorm(80)
x2 <- rnorm(80)
xfcontrasts <- contrasts(xf)[xf, ]
y <- 2 + 0.2 * x1 + xfcontrasts %*% c(0.1, 0.2, -0.04) + rnorm(80, s=3)
dat <- data.frame(xf, xfn, x1, x2, y) 
rm(xf, xfn, x1, x2, y) 


###################################################
### code chunk number 70: pp100B
###################################################
drawGroup <- function(j, dat){
    newdat1 <- data.frame(x1=plotSeq(dat$x1, length.out=2), x2 = mean(dat$x2, na.rm=TRUE), xf= levels(dat$xf)[j])
    newdat1$fit <- predict(m1, newdata= newdat1)
    yseq <-  plotSeq(dat$y[dat$xfn == j], length.out=8)
    yseq <- mean(yseq) + 0.95 * (yseq - mean(yseq))
    x1seq <- plotSeq(dat$x1[dat$xfn == j], length.out=8)
    x1seq <- mean(x1seq) + 0.95 * (x1seq - mean(x1seq))
    for ( z in yseq){
        lines( trans3d(range(x1seq),  rep(unique(dat$xfn)[j],2),  c(z,z), res), lwd=0.2, col= mycol[j])
    }
    for ( jj in x1seq){
        lines(trans3d(c(jj,jj), rep(unique(dat$xfn)[j],2), range(yseq), res), lwd=0.2, col=mycol[j])
    }

    lines(trans3d(newdat1$x1, j, newdat1$fit, res), col=mycol[j])
    with(dat[dat$xfn %in% j, ],  points(trans3d(x1, j, y, res), col=mycol[j]))
}

m1 <- lm(y ~ x1 * xf+ x2, data=dat)
#res <- perspEmpty(x1=dat$x1, x2=dat$xfn, y=dat$y, x1lab="x1 numeric", x2lab="x2 categorical", #theta=80, phi=15, ticktype="detailed")
#mycol <- rainbow(7:14)

#drawGroup(1, dat)
#drawGroup(4, dat)
#drawGroup(3, dat)
#drawGroup(2, dat)


###################################################
### code chunk number 71: pp201
###################################################
par(mar=c(2.5,1, 1, 1))
res <- perspEmpty(x1 = plotSeq(dat$x1, 5), x2 = 1:length(levels(dat$xf)), y=dat$y, x1lab="x1 numeric", x2lab="x2 categorical", theta=80, phi=15, ticktype="detailed")
mycol <- rainbow(7:14)
drawGroup(1, dat)


###################################################
### code chunk number 72: pp202
###################################################
par(mar=c(2.5,1, 1, 1))
res <- perspEmpty(x1 = plotSeq(dat$x1, 5), x2 = 1:length(levels(dat$xf)), y = dat$y, x1lab="x1 numeric", x2lab="x2 categorical", theta=80, phi=15, ticktype="detailed")
mycol <- rainbow(7:14)
drawGroup(1, dat)
drawGroup(4, dat)


###################################################
### code chunk number 73: pp203
###################################################
par(mar=c(2.5,1, 1, 1))
res <- perspEmpty(x1 = plotSeq(dat$x1, 5), x2 = 1:length(levels(dat$xf)), y=dat$y, x1lab="x1 numeric", x2lab="x2 categorical", theta=80, phi=15, ticktype="detailed")
mycol <- rainbow(7:14)
drawGroup(1, dat)
drawGroup(4, dat)
drawGroup(3, dat)
drawGroup(2, dat)


