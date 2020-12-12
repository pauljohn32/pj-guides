### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.XM8943/lyx_tmpbuf2/Exponential_v2.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Exponential_v2.Rnw:14-15
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Exponential_v2.Rnw:91-93
###################################################
unlink("plots", recursive=T)
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(width=100, prompt="> ", continue="+  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par() 
#pjmar <- c(5.1, 4.1, 1.0, 2.1) 
#options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=10)))
options(SweaveHooks=list(fig=function() par(ps=10)))
pdf.options(onefile=F,family="Times",pointsize=10)


###################################################
### code chunk number 4: Exponential_v2.Rnw:227-252
###################################################
upper <- 80
xvals <- seq(0,upper,by=0.02)
par(mfrow = c(3,3))
yvals1 <- dexp(xvals, rate=0.01)
plot (xvals, yvals1, type="l", main="Rate=0.01",xlab="x",ylab="probability")
yvals2 <- dexp(xvals, rate=0.05)
plot (xvals, yvals2, type="l", main="Rate=0.05",xlab="x",ylab="probability")
yvals3 <- dexp(xvals, rate=0.1)
plot (xvals, yvals3, type="l", main="Rate=0.1",xlab="x",ylab="probability")
upper <- 20
xvals <- seq(0,upper,by=0.2)
yvals4 <- dexp(xvals, rate=0.2)
plot (xvals, yvals4, type="l", main="Rate=0.2", xlab="x", ylab="probability")
yvals5 <- dexp(xvals, rate=.5)
plot (xvals, yvals5, type="l", main="Rate=.5", xlab="x", ylab="probability")
yvals6 <- dexp(xvals, rate=1)
plot (xvals, yvals6, type="l", main="Rate=1", xlab="x", ylab="probability")
upper <- 5
xvals <- seq(0,upper,by=0.005)
yvals7 <- dexp(xvals, rate=5)
plot (xvals, yvals7, type="l", main="Rate=5", xlab="x", ylab="probability")
yvals8 <- dexp(xvals, rate=10)
plot (xvals, yvals8, type="l", main="Rate=10", xlab="x", ylab="probability")
yvals9 <- dexp(xvals, rate=20)
plot (xvals, yvals9, type="l", main="Rate=20", xlab="x", ylab="probability")


