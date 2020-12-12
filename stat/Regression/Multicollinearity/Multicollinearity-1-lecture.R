### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.M28660/lyx_tmpbuf2/Multicollinearity-1-lecture.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Multicollinearity-1-lecture.Rnw:25-26
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Multicollinearity-1-lecture.Rnw:84-85
###################################################
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(device = pdf)
options(width=160, prompt="> ", continue="+  ")
options(useFancyQuotes = FALSE) 
#set.seed(12345)
op <- par() 
pjmar <- c(5.1, 5.1, 1.5, 2.1) 
#pjmar <- par("mar")
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 4: Multicollinearity-1-lecture.Rnw:204-301
###################################################

library(rockchalk)
set.seed(23232)

mcGraph1 <- function (x1, x2, y, theta=0, phi=15){
  x1range <- magRange(x1, 1.25)
  x2range <- magRange(x2, 1.25)
  yrange <- magRange(y, 1.5)
  
  zZero <- outer( plotSeq(x1range, l=5), plotSeq(x2range, l=5), function( a,b) { a*b*0 + yrange[1] } )
  
  res <- persp(x=plotSeq(x1range, l=5), y= plotSeq(x2range, l=5), z=zZero, zlim=yrange, lwd=1, xlab="x1",ylab="x2",zlab="y", theta=theta, phi=phi)
  
  yMinimum <- rep(yrange[1] , length(x1))
  mypoints1 <- trans3d (x1, x2, yMinimum, pmat = res )
  points( mypoints1, pch = 16, col= "blue")
}



mcGraph2 <- function(x1,x2,y, shrinky=1, theta=0, phi=15){
  x1range <- magRange(x1, 1.25)
  x2range <- magRange(x2, 1.25)
  yrange <- magRange(y, 1.5)
  
##
  zZero <- outer( plotSeq(x1range, l = 5), plotSeq(x2range, l = 5), function( a,b) { a*b*0 + yrange[1] } )

  res <- persp(x = plotSeq(x1range, l = 5), y = plotSeq(x2range, l = 5), z = zZero, zlim = yrange, lwd = 1, xlab = "x1", ylab = "x2", zlab = "y", theta = theta, phi=phi)
  
  mypoints1 <- trans3d ( x1, x2 ,yrange[1], pmat = res )
  newy <- shrinky * (y - yrange[1]) + yrange[1]
  mypoints2 <- trans3d ( x1 , x2 , newy , pmat = res )
  points( mypoints2, pch = 1, col= "blue")
  points( mypoints1, pch = 16, col=gray(0.8))
  
  mypoints2s <- trans3d ( x1, x2, (0.8)*newy, pmat =res )
  arrows ( mypoints1$x , mypoints1$y , mypoints2s$x , mypoints2s$y , col="red" , lty = 2, lwd=0.3, length=0.05)
}




mcGraph3 <- function(x1, x2, y, theta = 0, phi = 15){
  x1range <- magRange(x1, 1.25)
  x2range <- magRange(x2, 1.25)
  yrange <- magRange(y, 1.5)
  
  
  zZero <- outer( plotSeq(x1range, l = 5), plotSeq(x2range, l = 5), function( a, b) { a*b*0 + yrange[1] } )
  
  
  res <- persp(x = plotSeq(x1range, l = 5), y = plotSeq(x2range, l = 5), z = zZero, zlim = yrange, lwd = 1, xlab = "x1", ylab = "x2", zlab = "y", theta = theta, phi = phi)
  
  mypoints1 <- trans3d( x1, x2, yrange[1], pmat = res )
  
  mypoints2 <- trans3d( x1, x2, y, pmat = res )
  points( mypoints2, pch = 1, col = "blue")
  points( mypoints1, pch = 16, col = gray(0.8))
 
  m1 <- lm( y ~ x1 + x2)
  # summary (m1)
 
  x1seq <- plotSeq (x1range, length = 20)
  x2seq <- plotSeq (x2range , length = 20)
  
  zplane <- outer ( x1seq, x2seq, function(a, b) { predict(m1,
    newdata = data.frame( x1 = a, x2 = b ))} )
  
  for( i in 1:length(x1seq) ){
    lines(trans3d(x1seq[i], x2seq, zplane[i,], pmat = res), lwd = 0.3)
  }
  for( j in 1:length(x2seq) ){
    lines(trans3d(x1seq, x2seq[j], zplane[,j], pmat = res), lwd = 0.3)
  }
  
  mypoints4 <- trans3d (x1 , x2 , fitted(m1) , pmat =res )
##  points(mypoints4)
  
	newy <- ifelse(fitted(m1) < y, fitted(m1)+ 0.8*(y-fitted(m1)),
	fitted(m1) + 0.8 * (y-fitted(m1)))
  mypoints2s <- trans3d ( x1, x2, newy, pmat =res )
  
  arrows ( mypoints4$x , mypoints4$y , mypoints2s$x , mypoints2s$y , col = "red" , lty = 4, lwd = 0.3, length = 0.05)
  m1
}

genCorrelatedData <- function(N = 100, means = c(50,50), sds = c(10,10), rho = 0.0, stde = 1){ 
  require(MASS)
  corr.mat <- matrix(c(1,rho,rho,1), nrow = 2)
  sigma <- diag(sds) %*% corr.mat %*% diag(sds)
  x.mat <-  mvrnorm(n = N, mu = means, Sigma = sigma)
  y = 0 + 0.2* x.mat[,1] + 0.2 * x.mat[,2] + stde*rnorm (N, m = 0, s = 1)
  dat <- data.frame(x.mat, y)
  names(dat) <- c("x1", "x2", "y")
  dat
}


###################################################
### code chunk number 5: mc1-1
###################################################
## Create data with x1 and x2 correlated at 0.10
dat <- genCorrelatedData(rho=0, stde=7)
mod1 <- mcGraph1(dat$x1, dat$x2, dat$y, theta=-30, phi=8)


###################################################
### code chunk number 6: mc-2-1
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, shrinky = 0.0, theta = -30)


###################################################
### code chunk number 7: mc-2-2
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, shrinky = 0.05, theta = -30)


###################################################
### code chunk number 8: mc-2-3
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, shrinky = 0.1, theta = -30)


###################################################
### code chunk number 9: mc-2-4
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, shrinky = 0.2, theta = -30)


###################################################
### code chunk number 10: mc-2-5
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, shrinky = 0.3, theta = -30)


###################################################
### code chunk number 11: mc-2-6
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, shrinky = 0.4, theta = -30)


###################################################
### code chunk number 12: mc-2-7
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, shrinky = 0.5, theta = -30)


###################################################
### code chunk number 13: mc-2-8
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, shrinky = 0.6, theta = -30)


###################################################
### code chunk number 14: mc-2-9
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, shrinky = 0.7, theta = -30)


###################################################
### code chunk number 15: mc-2-10
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, shrinky = 0.80, theta = -30)


###################################################
### code chunk number 16: mc-2-11
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, shrinky = 0.90, theta = -30)


###################################################
### code chunk number 17: mc-2-13
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, shrinky = 1.0, theta = -30)


###################################################
### code chunk number 18: mc-2-20
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, shrinky = 1.0, theta = 20)


###################################################
### code chunk number 19: mc-2-21
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, shrinky = 1.0, theta = 40)


###################################################
### code chunk number 20: mc-2-22
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, shrinky = 1.0, theta = 60)


###################################################
### code chunk number 21: mc-2-23
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, shrinky = 1.0, theta = 80)


###################################################
### code chunk number 22: mc-2-24
###################################################
mod <- mcGraph2(dat$x1, dat$x2, dat$y, shrinky = 1.0, theta = 100)


###################################################
### code chunk number 23: mc-2-50
###################################################
mod1 <- mcGraph3(dat$x1, dat$x2, dat$y, theta = -30)
outreg(mod1, tight=FALSE)


###################################################
### code chunk number 24: mc-2-51
###################################################
mod1 <- mcGraph3(dat$x1, dat$x2, dat$y, theta = -10, phi=0)
outreg(mod1, tight=FALSE)


###################################################
### code chunk number 25: mc-2-52
###################################################
mod1 <- mcGraph3(dat$x1, dat$x2, dat$y, theta = -10, phi=-10)
outreg(mod1, tight=FALSE)


###################################################
### code chunk number 26: mc3-1
###################################################
## Create data with x1 and x2 correlated at 0.10
rm(dat)
dat2 <- genCorrelatedData(rho=0.9, stde=7)
mod2 <- mcGraph1(dat2$x1, dat2$x2, dat2$y, theta=20, phi=8)


###################################################
### code chunk number 27: mc-3-2
###################################################
mod <- mcGraph2(dat2$x1, dat2$x2, dat2$y, theta = -30)


###################################################
### code chunk number 28: mc-3-3
###################################################
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 29: mc-4-1
###################################################
dat2 <- genCorrelatedData(rho=0.0, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 30: mc-4-2
###################################################
dat2 <- genCorrelatedData(rho=0.0, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 31: mc-4-3
###################################################
dat2 <- genCorrelatedData(rho=0.0, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 32: mc-4-4
###################################################
dat2 <- genCorrelatedData(rho=0.0, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 33: mc-4-5
###################################################
dat2 <- genCorrelatedData(rho=0.0, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 34: mc-4-6
###################################################
dat2 <- genCorrelatedData(rho=0.0, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 35: mc-4-7
###################################################
dat2 <- genCorrelatedData(rho=0.0, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 36: mc-4-8
###################################################
dat2 <- genCorrelatedData(rho=0.0, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 37: mc-4-9
###################################################
dat2 <- genCorrelatedData(rho=0.0, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 38: mc-4-10
###################################################
dat2 <- genCorrelatedData(rho=0.0, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 39: mc-4-11
###################################################
dat2 <- genCorrelatedData(rho=0.0, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 40: mc-4-12
###################################################
dat2 <- genCorrelatedData(rho=0.0, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 41: mc-4-13
###################################################
dat2 <- genCorrelatedData(rho=0.0, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 42: mc-4-14
###################################################
dat2 <- genCorrelatedData(rho=0.0, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 43: mc-4-15
###################################################
dat2 <- genCorrelatedData(rho=0.0, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 44: mc-4-16
###################################################
dat2 <- genCorrelatedData(rho=0.0, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 45: mc-4-17
###################################################
dat2 <- genCorrelatedData(rho=0.0, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 46: mc-4-18
###################################################
dat2 <- genCorrelatedData(rho=0.0, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 47: mc-4-19
###################################################
dat2 <- genCorrelatedData(rho=0.0, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 48: mc-4-20
###################################################
dat2 <- genCorrelatedData(rho=0.0, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 49: mc-5-1
###################################################
dat2 <- genCorrelatedData(rho=0.9, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 50: mc-5-2
###################################################
dat2 <- genCorrelatedData(rho=0.9, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 51: mc-5-3
###################################################
dat2 <- genCorrelatedData(rho=0.9, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 52: mc-5-4
###################################################
dat2 <- genCorrelatedData(rho=0.9, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 53: mc-5-5
###################################################
dat2 <- genCorrelatedData(rho=0.9, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 54: mc-5-6
###################################################
dat2 <- genCorrelatedData(rho=0.9, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 55: mc-5-7
###################################################
dat2 <- genCorrelatedData(rho=0.9, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 56: mc-5-8
###################################################
dat2 <- genCorrelatedData(rho=0.9, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 57: mc-5-9
###################################################
dat2 <- genCorrelatedData(rho=0.9, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 58: mc-5-10
###################################################
dat2 <- genCorrelatedData(rho=0.9, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 59: mc-5-11
###################################################
dat2 <- genCorrelatedData(rho=0.9, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 60: mc-5-12
###################################################
dat2 <- genCorrelatedData(rho=0.9, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 61: mc-5-13
###################################################
dat2 <- genCorrelatedData(rho=0.9, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 62: mc-5-14
###################################################
dat2 <- genCorrelatedData(rho=0.9, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 63: mc-5-15
###################################################
dat2 <- genCorrelatedData(rho=0.9, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 64: mc-5-16
###################################################
dat2 <- genCorrelatedData(rho=0.9, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 65: mc-5-17
###################################################
dat2 <- genCorrelatedData(rho=0.9, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 66: mc-5-18
###################################################
dat2 <- genCorrelatedData(rho=0.9, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 67: mc-5-19
###################################################
dat2 <- genCorrelatedData(rho=0.9, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 68: mc-5-20
###################################################
dat2 <- genCorrelatedData(rho=0.9, stde=7)
mod <- mcGraph3(dat2$x1, dat2$x2, dat2$y, theta = -30)
outreg(mod, tight=F)


###################################################
### code chunk number 69: hell10
###################################################
data(religioncrime)
mod1 <- lm(crime ~ heaven, data=religioncrime)	
outreg(mod1)


###################################################
### code chunk number 70: hell15
###################################################
plot(crime ~ heaven, data=religioncrime)	
abline(mod1)


###################################################
### code chunk number 71: hell20
###################################################
mod2 <- lm(crime ~ hell, data=religioncrime)	
outreg(mod2)


###################################################
### code chunk number 72: hell25
###################################################
plot(crime ~ hell, data=religioncrime)	
abline(mod2)


###################################################
### code chunk number 73: hell30
###################################################
mod3 <- lm(crime ~ heaven + hell, data=religioncrime)	
outreg(mod3)


###################################################
### code chunk number 74: hell50
###################################################
with(religioncrime,      rockchalk::mcGraph1(heaven, hell, crime)      )	


###################################################
### code chunk number 75: hell60
###################################################
with(religioncrime,      
rockchalk::mcGraph2(heaven, hell, crime) )


###################################################
### code chunk number 76: hell70
###################################################
  mod1 <- with(religioncrime,      rockchalk::mcGraph3(heaven, hell, crime))


###################################################
### code chunk number 77: hell100
###################################################
mcDiagnose(mod3)


