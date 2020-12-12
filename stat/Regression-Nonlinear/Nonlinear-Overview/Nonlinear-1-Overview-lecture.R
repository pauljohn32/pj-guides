### R code from vignette source '/tmp/lyx_tmpdir.T30395/lyx_tmpbuf2/Nonlinear-1-Overview-lecture.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Nonlinear-1-Overview-lecture.Rnw:31-32
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Nonlinear-1-Overview-lecture.Rnw:101-102
###################################################
dir.create("plots", showWarnings=T)


###################################################
### code chunk number 3: Roptions
###################################################
options(device = pdf)
options(width=160, prompt="> ", continue="+  ")
options(useFancyQuotes = FALSE) 
set.seed(75645)
op <- par() 
pjmar <- c(5.1, 5.1, 1.5, 2.1) 
#pjmar <- par("mar")
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)
library(rockchalk)


###################################################
### code chunk number 4: ex20
###################################################
x <- runif(400, min=0, max=100)
y <- 10 -2 * x + 15 * sin(0.04*x) + 15*rnorm(400,0,1)
plot(x,y, type="n")
curve(10 -2 * x, add=T)
curve(10 -2*x + 15 * sin(0.04*x), col="red", add=T)
legend("bottomleft", legend=c("true relationship","linear approximation"), lwd=c(2,2), col=c("red","black"))


###################################################
### code chunk number 5: ex40
###################################################
plot(x,y)
mod2 <- lm(y~x)
abline(mod2, col="black", lwd=2)
curve(10 -2*x + 15 * sin(0.04*x), col="red", add=T)
legend("bottomleft", legend=c("true relationship","linear OLS Estimate"), lwd=c(2,2), col=c("red","black"))


###################################################
### code chunk number 6: ex50
###################################################
x <- runif(200, min=0, max=100)
x <- x[order(x)]
y <- 3 + 13.4 * x - .15 * x^2 + rnorm(200,m=0, s=22)
modf <- lm(y~x)
fakeeqn <- expression(paste(y[i]== 3 + 13.4*x[i] - 0.15*x[i]^2 + e[i]))
plot(x,y, xlab="Fake x", ylab="Fake y", main=fakeeqn)
abline(modf, col="red", lty=2,lwd=2)
curve(3 + 13.4 * x - .15 * x * x, add=T, lty=1, col="black", lwd=3)
legend("bottomleft", legend=c("OLS Linear Fit","True Nonlinear Curve"), col=c( "red", "black"), lty=c(2,1), lwd=c(2,3)) 


###################################################
### code chunk number 7: ex70
###################################################
curve(3 + 13.4 * x - .15 * x * x, lty=1, col="black", lwd=1, from=0, to=100, ylab="")
lines( c(19,29), c(210.6, 269), col="red",lwd=3)
lines( c(59,74), c( 278.60, 184), col="green",lwd=3)
lines( c(80,95), c( 125, -65), col="blue",lwd=3)
abline(v = c(19, 29, 59, 74, 80, 95), col = "gray70")


###################################################
### code chunk number 8: ex75
###################################################
curve(3 + 13.4 * x - .15 * x * x,lty=1, col="black", lwd=1, from=20, to=50, ylab="")
segments(x0=c(20,33, 43.4), x1 = c(33,43.4,50.1), y0= c(212,282, 302), y1=c( 282, 302, 297), col = rgb(1,0,0,.8), lwd = 2)
segments(x0=c(20,33, 43.4), x1 = c(33,43.4,50.1), y0= c(212,282, 302), y1=c( 282, 302, 297), col = rgb(1,0,0,.5), lwd =10)
mtext(text = c(expression(k[1]), expression(k[2]), expression(k[3])), side = 1, at = c(20, 33, 43.4), line = -2)


###################################################
### code chunk number 9: quad05
###################################################
curve(5 + 0.3 *x + 0.1*x^2, from = -5, to = 10, lty = 1, col = "black")
text(6, 8, expression(b[2] > 0), col = "black") 
curve(15 + 0.4 *x - 0.1*x^2, from = -5, to = 10, lty = 2, col = "blue", add = T, lwd = 2)
text(-2, 12, expression(b[2] < 0), col = "blue", lwd = 2) 


###################################################
### code chunk number 10: curves10
###################################################
curve(log(x), 0.1, 30, ylab = "", lty = 1, col = "black", ylim = c(-3, 7))
curve(sqrt(x), 0.1, 30, lty = 2, col = "green", add = TRUE)
curve(6 - 10/x, 0.1, 30, lty = 4, col = "orange", add = TRUE)
legend("topleft", legend = c("log(x)", "sqrt(x)", "6 -10/x"), lty = c(1,2,4), col = c("black", "green","orange"))


###################################################
### code chunk number 11: Nonlinear-1-Overview-lecture.Rnw:629-633
###################################################
library(car)
data(UN)
UN <- na.omit(UN)
UN <- UN[order(UN$gdp) ,]


###################################################
### code chunk number 12: infmort10
###################################################
par(mfrow=c(1,2))
hist(UN$infant.mortality, breaks = 20, xlab = "Data from John Fox's car package", main = "Infant Mortality")
hist(log(UN$infant.mortality), breaks = 20, xlab = "natural logarithm", main = "Logged Infant Mortality")


###################################################
### code chunk number 13: UN01
###################################################
UN$loggdp <- log(UN$gdp)
UN$infmortlog <- log(UN$infant.mortality)
par(mfrow=c(1,2))
plot(infant.mortality ~ gdp, data=UN, xlab="Gross Domestic Product (UN)", ylab="Infant Mortality (per 1000 births)", main="Unlogged Data")
plot(infmortlog ~ gdp, data=UN, xlab="Gross Domestic Product (UN)", ylab="log of Infant Mortality (per 1000 births)", main="Logged Infant Mortality")


###################################################
### code chunk number 14: gdp10
###################################################
par(mfrow=c(1,2))
hist(UN$gdp, breaks = 20, xlab = "Data from John Fox's car package", main = "GDP")
hist(log(UN$gdp), breaks = 20, xlab = "natural logarithm", main = "GDP logged")


###################################################
### code chunk number 15: UN05a
###################################################
plot(infant.mortality~gdp, data=UN, xlab="Gross Domestic Product (UN)", ylab="Infant Mortality (per 1000 births)", main="")


###################################################
### code chunk number 16: UN05b
###################################################
UN$gdplog <- log(UN$gdp)
UN$infmortlog <- log(UN$infant.mortality)
plot(infmortlog~gdplog, data=UN, xlab="log of Gross Domestic Product (UN)", ylab="log of Infant Mortality (per 1000 births)", main="")


###################################################
### code chunk number 17: Nonlinear-1-Overview-lecture.Rnw:741-743 (eval = FALSE)
###################################################
## dat$ylog <- log(dat$y)
## m1 <- lm(ylog ~ log(x), data = dat)


###################################################
### code chunk number 18: UN10
###################################################
logmod <- lm(infmortlog~gdplog, data=UN)
gdpseq <- plotSeq(UN$gdp, length.out=40)
newdf <- data.frame(gdp=gdpseq, gdplog=log(gdpseq))
newdf$logpredy <- predict(logmod, newdata=newdf)
plotSlopes(logmod, plotx = "gdplog", interval = "confidence", xlab = "log of Gross Domestic Product (UN)", ylab = "log of Infant Mortality (per 1000 births)", ylim = c(0, 9))


###################################################
### code chunk number 19: UN10a
###################################################
outreg(logmod, tight=F)


###################################################
### code chunk number 20: fake01
###################################################
STDE = 400; b0 = 3; b1 = .2; b2 = -0.075
x <- runif(400, 0, 100)
x <- x[order(x)]
dat <- data.frame(x)
dat$xsq <- x*x
dat$y <- b0 + b1 * dat$x + b2 * dat$xsq + rnorm(400, m=0, s = STDE)
rm(x)
xcorr <- cor(dat$x, dat$xsq)


###################################################
### code chunk number 21: fake10
###################################################
plot(y ~ x, data = dat)


###################################################
### code chunk number 22: Nonlinear-1-Overview-lecture.Rnw:854-856 (eval = FALSE)
###################################################
## dat$xsq <- dat$x^2
## m1 <- lm(y ~ x + xsq, data = dat)


###################################################
### code chunk number 23: Nonlinear-1-Overview-lecture.Rnw:867-868 (eval = FALSE)
###################################################
## m2a <- lm(y ~ x + I(x*x), data = dat)


###################################################
### code chunk number 24: Nonlinear-1-Overview-lecture.Rnw:905-906 (eval = FALSE)
###################################################
## m1 <- lm(y ~ poly(x, 2), data = dat)


###################################################
### code chunk number 25: Nonlinear-1-Overview-lecture.Rnw:914-917
###################################################
xpoly <- poly(dat$x, 2)
head(xpoly)
(pcorr <- cor(xpoly[, 1], xpoly[ ,2]))


###################################################
### code chunk number 26: xpoly10
###################################################
par(mfrow = c(1,2))
plot(xsq ~ x, data = dat, xlab = "x", ylab = "x squared", main = "x and xsq")
text(20, 8500, label = paste("r = ", round(xcorr,3)))
plot(xpoly[ ,1], xpoly[ ,2], xlab = "Orthogonal column 1", ylab = "Orthogonal column 2", main = "Ortho Poly Columns")
text(0, 0.10, label = paste("r = ", round(pcorr,3)))


###################################################
### code chunk number 27: Nonlinear-1-Overview-lecture.Rnw:963-966
###################################################
mmc <- lm(xsq ~ x, data = dat)
dat$xrc <- resid(mmc)
rccorr <- cor(dat$xrc, dat$x)


###################################################
### code chunk number 28: xpolyrc10
###################################################
par(mfrow = c(1,2))
plot(xsq ~ x, data = dat, xlab = "x", ylab = "x squared", main = "x and xsq")
text(20, 8500, label = paste("r = ", round(xcorr,3)))
plot(xrc ~ x, data = dat,  xlab = "x", ylab = "residual-from-x-squared", main = "Residual Centered Columns")
text(40, 1500, label = paste("r = ", round(rccorr,3)))


###################################################
### code chunk number 29: Nonlinear-1-Overview-lecture.Rnw:989-991 (eval = FALSE)
###################################################
## dat$xctr <- scale(dat$x, scale = FALSE) 
## m1 <- lm(y ~ xctr + I(xctr^2), data = dat)


###################################################
### code chunk number 30: Nonlinear-1-Overview-lecture.Rnw:1002-1005
###################################################
dat$xmc <- scale(dat$x, scale = F)
dat$xmcsq <- dat$xmc * dat$xmc
mccorr <- cor(dat$xmc, dat$xmcsq)


###################################################
### code chunk number 31: xmc20
###################################################
par(mfrow = c(1,2))
plot(xsq ~ x, data = dat, xlab = "x", ylab = "x squared", main = "x and xsq")
text(20, 8500, label = paste("r = ", round(xcorr,3)))
plot(xmcsq ~ xmc, data = dat,  xlab = "mean-centered x", ylab = "mean-centered x-square", main = "Mean Centered Columns")
text(0, 2500, label = paste("r = ", round(mccorr,3)))


###################################################
### code chunk number 32: weird
###################################################
plot(xpoly[ ,2] ~ dat$xrc, xlab = "Residual-centered xsquare term", ylab = "Ortho Poly 2nd term")


###################################################
### code chunk number 33: poly05a
###################################################
library(rockchalk)
mod <- lm(y~x, data = dat)
outreg(mod, tight=F)


###################################################
### code chunk number 34: poly05
###################################################
fakeeqn <- expression(paste(y[i]== 3 + 0.2*x[i] - 0.075*x[i]^2 + e[i]))
plot(y ~ x, data = dat, xlab="x", ylab="y", main=fakeeqn)
abline(mod, col="red", lwd=3, lty=2)
x <- dat$x
curve(3 + 0.20 * x - 0.075 * x*x, add=T, lty=1, col="black", lwd=2)
legend("bottomleft", legend=c("OLS Linear","True Nonlinear Curve"), col=c( "red", "black"), lty=c(2,1), lwd=c(2,2)) 


###################################################
### code chunk number 35: poly10
###################################################
modpoly <- lm(y ~ x + xsq, data = dat)
plot(y ~ x, data = dat, xlab="Fake x", ylab="Fake y", main=fakeeqn)
xrange <- range(x)
xpred <- seq(xrange[1], xrange[2], length.out=50)
ypred <- predict(modpoly, newdata=data.frame(x=xpred, xsq=xpred*xpred))
lines(xpred, ypred, col="red", lwd=3, lty=2)
curve(3 + .2 * x - .075 * x*x, add=T, lty=1, col="black", lwd=2)
legend("bottomleft", legend=c("OLS x xsq","True Nonlinear Curve"), col=c( "red", "black"), lty=c(2,1), lwd=c(2,2)) 


###################################################
### code chunk number 36: poly10a
###################################################
library(rockchalk)
outreg(modpoly, tight=F)


###################################################
### code chunk number 37: poly20
###################################################
xc <- scale(dat$x, center=T, scale=F)
xcsquare <- xc*xc
modpoly2 <- lm(y ~ xc + xcsquare, data = dat)
plot(y ~ x, data = dat, xlab = "x", ylab="y", main=fakeeqn)
ypredc <- predict(modpoly2)
lines(mean(x)+xc, ypredc, col="red", lwd=3, lty=2)
curve(3 + 0.20 * x - .075 * x * x, add=T, lty=1, col="black", lwd=2)
legend("bottomleft", legend=c("OLS Centered x x-sq","True Nonlinear Curve"), col=c( "red", "black"), lty=c(2,1), lwd=c(2,2)) 


###################################################
### code chunk number 38: poly20a
###################################################
library(rockchalk)
outreg(modpoly2, tight=F)


###################################################
### code chunk number 39: poly30
###################################################
plot(x = 0:100, y= seq(-7000, 20, length.out = 101), ylim = c(-7000, 500), type = "n")
curve(3 + 0.20*x - .75*x*x, from = 0, to = 95, add = T, ylim =c(-7000,20), lty=1, col="black", lwd=2)
lines(x=c(0,20), y = c(0,0), col = "red", lwd = 2)
text(6, 80, pos=4, label = "tangent line where x = 0; the \"linear effect\" of x is small")


###################################################
### code chunk number 40: poly40
###################################################
plot(x = 0:100, y= seq(-7000, 20, length.out = 101), ylim = c(-7000, 500), type = "n", axes = F)
axis(1)
axis(2, pos=50)
curve(3 + 0.20*x - .75*x*x, from = 0, to = 95, add = T, ylim =c(-7000,20), lty=1, col="black", lwd=2)
lines(x=c(50,66.6), y = c(-1859,-2973), col = "red", lwd = 2)
text(60, -2400, pos=4, label = "Note the tangent line is steeper, \n       hence the linear \n              effect is greater")


###################################################
### code chunk number 41: ex99
###################################################
plot(predict(modpoly), predict(modpoly2), xlab="Predictions from Non Centered Data",ylab="Predictions from Centered Data")


###################################################
### code chunk number 42: cpi10
###################################################
library(foreign)
dat <- read.dta("/home/pauljohn/ps/SVN-guides/stat/DataSets/QoG/QoG_c_s_v6Apr11.dta")
vars <- c("p_polity2", "fh_ipolity2", "fh_pr", "gir_gii", 
"kk_gg", "qs_impar", "ti_cpi", "wbgi_cce", "ht_regtype", 
"hf_efiscore", "qs_proff", "bti_mes", "bti_ep", "bti_wr")
dat <- dat[ , vars]
plot(ti_cpi ~ fh_pr, data=dat, xlab="Political rights (Freedom House)", ylab="TI Corruptions Perceptions")


###################################################
### code chunk number 43: cpi20
###################################################
m0 <- lm(ti_cpi ~ fh_pr, data=dat)
m2b <- lm(ti_cpi ~ poly(fh_pr, 2, raw = TRUE), data=dat) 
newdf <- data.frame(fh_pr = plotSeq(dat$fh_pr, length.out=25)) 
m2bpred <- predict(m2b, newdata =newdf)


###################################################
### code chunk number 44: cpi21
###################################################
plot(ti_cpi ~ fh_pr, data=dat, xlab="Political rights (Freedom House)", ylab="TI Corruptions Perceptions")
abline(m0, lwd = 2)
lines(newdf$fh_pr, m2bpred, lty=1, lwd=5, col="red")
legend("topright", legend=c("m0: linear", "m2b: fh_sq"), lty=c(1,1),lwd=c(2,5),col=c("black","red"))


###################################################
### code chunk number 45: Nonlinear-1-Overview-lecture.Rnw:1478-1480
###################################################
dat$fh_pr_mc <- drop(scale(dat$fh_pr, scale = FALSE))
newdf$fh_pr_mc <- plotSeq(dat$fh_pr_mc, 25)


###################################################
### code chunk number 46: cpi50
###################################################
m2 <- lm(ti_cpi ~ fh_pr + I(fh_pr^2), data=dat)
m2pred <- predict(m2, newdata = newdf)
m3 <- lm(ti_cpi ~ poly(fh_pr, 2), data=dat)
m3pred <- predict(m3, newdata=newdf)
m4 <- lm(ti_cpi ~ fh_pr_mc + I(fh_pr_mc^2), data=dat)
m4pred <- predict(m4, newdata=newdf)                                         


###################################################
### code chunk number 47: cpi51
###################################################
plot(ti_cpi ~ fh_pr, data=dat, xlab="Political rights (Freedom House)", ylab="TI Corruptions Perceptions")
lines(newdf$fh_pr, m2pred, lty=1, lwd=12, col="green")
lines(newdf$fh_pr, m3pred, lty=3, lwd=15, col="red") 
lines(newdf$fh_pr, m4pred, lty=5, lwd=4, col="yellow") 
legend("topright", title = "quadratic", legend=c("m2:squared","m3:poly(fh,2)","m4:mean-centered"), lty = c(1,3,5), lwd = c(12,15,4), col=c("green", "red","yellow"))


###################################################
### code chunk number 48: UN70a
###################################################
nmod2 <- nls(infant.mortality ~ A + B*(gdp^C), data=UN, start=list(A=10,B=21,C=-1/10), control=nls.control(warnOnly=TRUE))
summary(nmod2)


###################################################
### code chunk number 49: UN71
###################################################
newdf <- data.frame(gdp = plotSeq(UN$gdp, 100))
newdf$p2nls <- predict(nmod2, newdata = newdf)
plot(infant.mortality~gdp, data = UN, xlab = "Gross Domestic Product (UN)", ylab = "Infant Mortality (per 1000 births)", main = "", type = "n")
points(UN$gdp, UN$infant.mortality, col = gray(.7))
lines(newdf$gdp, newdf$p2nls)


###################################################
### code chunk number 50: Nonlinear-1-Overview-lecture.Rnw:1729-1730
###################################################
newdf$gdplog <- log(newdf$gdp)


###################################################
### code chunk number 51: UN77
###################################################
lomod <- loess(infant.mortality~gdp, data=UN, family="symmetric") 
plot(lomod) 
predlo <- predict(lomod) 
plot(infant.mortality~gdp, data=UN, xlab="Gross Domestic Product (UN)", ylab="Infant Mortality (per 1000 births)", main="", type="n") 
points(UN$gdp, UN$infant.mortality, col=gray(.7)) 
lines(newdf$gdp, newdf$p2nls)
lines(UN$gdp, predlo, col="green",lwd=2)
legend("topright", legend = c("nls", "loess (robust)"), lwd = c(1,2), col = c("black","green"))


