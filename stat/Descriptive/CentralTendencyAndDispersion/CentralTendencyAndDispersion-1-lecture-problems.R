### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.T11137/lyx_tmpbuf3/CentralTendencyAndDispersion-1-lecture-problems.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: CentralTendencyAndDispersion-1-lecture-problems.Rnw:18-19
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: CentralTendencyAndDispersion-1-lecture-problems.Rnw:72-74
###################################################
unlink("plots", recursive=T)
dir.create("plots", showWarnings=T)


###################################################
### code chunk number 3: Roptions
###################################################
options(width=100, prompt=" ", continue="  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par() 
pjmar <- c(5.1, 5.1, 1.5, 2.1) 
#pjmar <- par("mar")
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)


