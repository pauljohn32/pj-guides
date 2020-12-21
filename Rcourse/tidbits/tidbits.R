### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.T12921/lyx_tmpbuf2/tidbits.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: tidbits.Rnw:19-20
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: tidbits.Rnw:78-79
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
### code chunk number 4: chunk10 (eval = FALSE)
###################################################
## help.start() 


###################################################
### code chunk number 5: tidbits.Rnw:149-150 (eval = FALSE)
###################################################
## library(some-package-name)


###################################################
### code chunk number 6: tidbits.Rnw:155-158 (eval = FALSE)
###################################################
## library(help = "some-package-name")
## ##or, equivalently
## help(package = "some-package-name")


###################################################
### code chunk number 7: tidbits.Rnw:182-183 (eval = FALSE)
###################################################
## library(sos); library(help = sos); vignette("sos")


###################################################
### code chunk number 8: tidbits.Rnw:263-267 (eval = FALSE)
###################################################
## library(debug)
## x <- rnorm(100); y <- 0.5* x + 4*rnorm(100)
## mtrace(lm)
## mod <- lm(y~x)


