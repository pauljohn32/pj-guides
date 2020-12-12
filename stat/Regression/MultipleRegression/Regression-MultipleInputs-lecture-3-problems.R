### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.T24624/lyx_tmpbuf2/Regression-MultipleInputs-lecture-3-problems.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Regression-MultipleInputs-lecture-3-problems.Rnw:14-15
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Regression-MultipleInputs-lecture-3-problems.Rnw:68-70
###################################################
unlink("plots3", recursive=T)
dir.create("plots3", showWarnings=T)


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


