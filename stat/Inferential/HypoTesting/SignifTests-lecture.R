### R code from vignette source 'SignifTests-lecture.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: SignifTests-lecture.Rnw:34-35
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: SignifTests-lecture.Rnw:81-83
###################################################
unlink("plots", recursive=T)
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(width=100, prompt=" ", continue="  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par(no.readonly=T) 
pjmar <- c(5.1, 4.1, 1.5, 2.1) 
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=10)))
pdf.options(onefile=F,family="Times",pointsize=6)


###################################################
### code chunk number 4: idea10
###################################################
curve(dchisq(x, 5), from = 0, to = 30, ylab="density", xlab=expression(hat(theta)))


###################################################
### code chunk number 5: idea20
###################################################
curve(dchisq(x, 5), from = 0, to = 30, ylab="density", xlab=expression(hat(theta)))
text(25, 0.025, label=expression(hat(theta)[1]))
arrows(24.5, 0.02, 24.5, 0.005, length = 0.1, col = "red")


###################################################
### code chunk number 6: idea30
###################################################
curve(dchisq(x, 25), from = 0, to = 40, ylab="density", xlab=expression(hat(theta)))
text(25, 0.012, label=expression(hat(theta)[1]))
arrows(24.5, 0.01, 24.5, 0.005, length = 0.1, col = "red")


###################################################
### code chunk number 7: idea40
###################################################
par(mfcol=c(2,1))
curve(dchisq(x, 5), from = 0, to = 30, ylab="density", xlab=expression(hat(theta)))
text(25, 0.025, label=expression(hat(theta)[1]))
arrows(24.5, 0.02, 24.5, 0.005, length = 0.1, col = "red")
curve(dchisq(x, 25), from = 0, to = 40, ylab="density", xlab=expression(hat(theta)))
text(25, 0.012, label=expression(hat(theta)[1]))
arrows(24.5, 0.01, 24.5, 0.005, length = 0.1, col = "red")
par(mfcol=c(1,1))


###################################################
### code chunk number 8: tdist10
###################################################
curve(dt(x, df = 99), from = -3, to = 3, xlab = expression(hat(t)), ylab="density")
abline(v=c(-1.98, 1.98), col=gray(.80), lty =4)
text(0, 0.025, label="2 tailed! \n An estimate over here or there\n will lead us to reject H0")
arrows(c(-1.2,1.2), c(0.015, 0.015), c(-2.2,2.2), c(0.015, 0.015), col="red", length=0.1)


###################################################
### code chunk number 9: SignifTests-lecture.Rnw:689-690
###################################################
pt( 12/7, df = 95, lower = FALSE)


