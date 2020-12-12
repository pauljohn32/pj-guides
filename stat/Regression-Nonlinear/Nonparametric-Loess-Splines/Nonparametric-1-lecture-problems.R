### R code from vignette source 'Nonparametric-1-lecture-problems.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Nonparametric-1-lecture-problems.Rnw:15-16
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Nonparametric-1-lecture-problems.Rnw:69-70
###################################################
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(device = pdf)
options(width=160, prompt=" ", continue="  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par() 
pjmar <- c(5.1, 5.1, 1.5, 2.1) 
#pjmar <- par("mar")
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 4: prob1a (eval = FALSE)
###################################################
## dat <- read.table("cystfibr.txt", header=T)
## plot(weight ~ height, data = dat) 
## mod1 <- lm(weight ~ height, data = dat)
## summary(mod1)
## abline(mod1)


###################################################
### code chunk number 5: prob1b (eval = FALSE)
###################################################
## lfit <- loess(weight ~ height, data = dat, span = 0.5, degree = 2, family = "gaussian")
## dat <- dat[order(dat$height) ,]
## lopred <- predict(lfit, newdata = dat) 
## plot(weight ~ height, data = dat) 
## lines(dat$height, lopred)
## abline(mod1, lwd = 0.7, lty=2)
## legend("topleft", legend = c("loess","OLS"), lwd = c(1,0.7), lty = 1:2)


###################################################
### code chunk number 6: prob1c (eval = FALSE)
###################################################
## with(dat, scatter.smooth( height, weight))
## abline(mod1, lwd = 0.7, lty = 2)
## legend("topleft", legend = c("loess","OLS"), lwd = c(1,0.7), lty = 1:2)


###################################################
### code chunk number 7: prob1d (eval = FALSE)
###################################################
## mod4 <- lm( weight ~ ns(height, df = 4), data = dat) 
## summary(mod4)
## #dang. Should have sorted dat by height first.
## dat <- dat[order(dat$height), ] 
## mod4pred <- predict(mod4, newdata = dat)
## plot(weight ~ height, data = dat) 
## lines(dat$height, mod4pred, col = green, lty = 4, lwd = 2)


###################################################
### code chunk number 8: prob2a (eval = FALSE)
###################################################
## dat$heightsq <- dat$height * dat$height
## mod2 <- lm(weight~height + heightsq, data = dat)
## summary(mod2)
## heightseq <- seq(min(dat$height), max(dat$height), length.out = 100)
## weightpred <- predict(mod2, newdata = data.frame(height = heightseq, heightsq = heightseq*heightseq))
## plot(weight ~ height, data = dat)
## lines(heightseq, weightpred, lty = 4, col = "red", lwd = 2)


###################################################
### code chunk number 9: prob2b (eval = FALSE)
###################################################
## dat$heightc <- dat$height - mean(dat$height, na.rm = TRUE)
## ## same as dat$heightc <- scale(dat$height, scale = FALSE)


