### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.T18382/lyx_tmpbuf0/TimeSeries-1-lecture.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: TimeSeries-1-lecture.Rnw:18-19
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: TimeSeries-1-lecture.Rnw:77-78
###################################################
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(device = pdf)
options(width=160, prompt=" ", continue="  ")
options(useFancyQuotes = FALSE) 
#set.seed(12345)
op <- par() 
pjmar <- c(5.1, 5.1, 1.5, 2.1) 
#pjmar <- par("mar")
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)


