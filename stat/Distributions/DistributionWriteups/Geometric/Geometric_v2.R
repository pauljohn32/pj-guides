### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.XM9213/lyx_tmpbuf2/Geometric_v2.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Geometric_v2.Rnw:12-13
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Geometric_v2.Rnw:88-90
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
options(SweaveHooks=list(fig=function() par(ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 4: Geometric_v2.Rnw:205-235
###################################################


makePlot <- function(myrange, pr){

   myTitle <- paste("Prob.=",pr)

   myprobs <- dgeom(myrange, prob=pr)

   plot (myrange, myprobs, type="h", main=myTitle,xlab="Failures before first success",ylab="probability", ylim=c(0,.75))

   points(myrange, myprobs, pch=16, cex=0.5)

}



par(mfrow = c(3,3))

therange <- 0:19

pvals <- c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9)



for (i in 1:9) {

  makePlot(therange, pvals[i])

}



