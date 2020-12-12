### R code from vignette source '/tmp/lyx_tmpdir.MT7942/lyx_tmpbuf2/Missing-1-lecture.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Missing-1-lecture.Rnw:31-32
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Missing-1-lecture.Rnw:88-89
###################################################
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(width=100, prompt="> ", continue="+  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par() 
pjmar <- c(4.1, 4.1, 1.5, 2.1) 
##pjmar <- par("mar")
par(mar=pjmar, ps=11)
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12, xpd=F)))
pdf.options(onefile=F,family="Times",pointsize=12)


