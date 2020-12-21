### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.T27349/lyx_tmpbuf2/first-R-02.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: first-R-02.Rnw:20-21
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: first-R-02.Rnw:82-83
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
### code chunk number 4: lmhelp
###################################################
?lm


###################################################
### code chunk number 5: first-R-02.Rnw:524-525
###################################################
sessionInfo()


