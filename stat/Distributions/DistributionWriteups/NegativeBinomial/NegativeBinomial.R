### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.XM9936/lyx_tmpbuf2/NegativeBinomial.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: NegativeBinomial.Rnw:16-17
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: NegativeBinomial.Rnw:92-94
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
### code chunk number 4: ANegBi (eval = FALSE)
###################################################
## drawBinom <- function (S, p){
##   x<- seq(0,200)
##   xprob <- dnbinom(x,size=S,prob=p)
##   mytitle <- paste("x",S,p)
##   plot(x, xprob,type="s",main=mytitle,xlab=paste("number of failures before ",S,"successes"))
## }
## 
## par(mfcol=c(3,2))
## sizes <- c(20,40,60)
## pvals <- c(0.33,0.67)
## for (i in 1:2){
##    for (j in 1:3){
##      drawBinom (sizes[j], pvals[i] )
##   }
## }


###################################################
### code chunk number 5: NegativeBinomial.Rnw:293-294
###################################################
drawBinom <- function (S, p){
  x<- seq(0,200)
  xprob <- dnbinom(x,size=S,prob=p)
  mytitle <- paste("x",S,p)
  plot(x, xprob,type="s",main=mytitle,xlab=paste("number of failures before ",S,"successes"))
}

par(mfcol=c(3,2))
sizes <- c(20,40,60)
pvals <- c(0.33,0.67)
for (i in 1:2){
   for (j in 1:3){
     drawBinom (sizes[j], pvals[i] )
  }
}


###################################################
### code chunk number 6: NegativeBinomial.Rnw:311-314
###################################################
x7 <- seq(0, 100)
xprob7 <- dnbinom(x7, size = 50, prob = 0.5)
plot(xprob7, type="s")


