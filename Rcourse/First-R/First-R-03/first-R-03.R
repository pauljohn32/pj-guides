### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.T27521/lyx_tmpbuf2/first-R-03.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: first-R-03.Rnw:20-21
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: first-R-03.Rnw:90-91
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
### code chunk number 4: first-R-03.Rnw:225-226 (eval = FALSE)
###################################################
## getwd()


###################################################
### code chunk number 5: first-R-03.Rnw:350-351 (eval = FALSE)
###################################################
## setwd("c:/users/your-name-here/Documents/ps706/First-R-03")


###################################################
### code chunk number 6: first-R-03.Rnw:424-426 (eval = FALSE)
###################################################
## myPlotDir <- "outdir"
## dir.create(myPlotDir)


###################################################
### code chunk number 7: p5
###################################################
x <- rgamma(100, 1.5, 2.2)
y <- rnorm(100) + 0.2 * x
pdf("RegPlot1.pdf", height=6, width=6, paper="special")
plot(y ~ x, main="Here comes a line of best fit!")
mod1 <- lm(y ~ x)
abline(mod1)
dev.off() #turns off pdf output device


###################################################
### code chunk number 8: p10
###################################################
x <- rgamma(100, 1.5, 2.2)
y <- rnorm(100) + 0.2 * x
dir.create("plots2")
pdf("plots2/RegPlot1.pdf", height=6, width=6, paper="special")
plot(y ~ x, main = "I'm saved in plots folder!")
mod1 <- lm(y ~ x)
abline(mod1)
dev.off() #turns off pdf output device


