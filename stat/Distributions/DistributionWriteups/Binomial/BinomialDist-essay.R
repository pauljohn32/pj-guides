### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.XM7887/lyx_tmpbuf0/BinomialDist-essay.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: BinomialDist-essay.Rnw:16-17
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: BinomialDist-essay.Rnw:93-95
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
#pjmar <- c(5.1, 4.1, 1.0, 2.1) 
#options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=10)))
options(SweaveHooks=list(fig=function() par(ps=10)))
pdf.options(onefile=F,family="Times",pointsize=10)


###################################################
### code chunk number 4: BinomialDist-essay.Rnw:227-232
###################################################
N <- 437; p<- 0.63; x1 <- max(0, N*p-4*sqrt(p*(1-p)*N)); x2 <- min(N*p+4*sqrt(p*(1-p)*N),N)
x <- as.integer(x1): as.integer(x2+1)
pseq <- dbinom(x, N, p)
plot(x, pseq, type="h", xlab="k", ylab=paste("Prob(k, N=",N,", p=", p,")"))
points(x, pseq, pch=18,cex=0.5)


###################################################
### code chunk number 5: BinomialDist-essay.Rnw:403-408
###################################################
N <- 2000; p<- 0.50; x1 <- max(0, N*p-4*sqrt(p*(1-p)*N)); x2 <- min(N*p+4*sqrt(p*(1-p)*N),N)
x <- as.integer(x1): as.integer(x2+1)
pseq <- dbinom(x, N, p)
plot(x, pseq, type="h", xlab="k", ylim=c(0, 1.3*max(pseq)), ylab=paste("Prob(k, N=",N,", p=", p,")"))
points(x, pseq, pch=18,cex=0.5)


###################################################
### code chunk number 6: BinomialDist-essay.Rnw:422-427
###################################################
N <- 4; p<- 0.50; x1 <- max(0, N*p-3*sqrt(p*(1-p)*N)); x2 <- min(N*p+4*sqrt(p*(1-p)*N),N)
x <- as.integer(x1): as.integer(x2+1)
pseq <- dbinom(x, N, p)
plot(x, pseq, type="h", xlab="k", ylim=c(0, 1.3*max(pseq)), ylab=paste("Prob(k, N=",N,", p=", p,")"))
points(x, pseq, pch=18,cex=0.5)


###################################################
### code chunk number 7: BinomialDist-essay.Rnw:440-445
###################################################
N <- 4; p<- 0.150; x1 <- max(0, N*p-3*sqrt(p*(1-p)*N)); x2 <- min(N*p+4*sqrt(p*(1-p)*N),N)
x <- as.integer(x1): as.integer(x2+1)
pseq <- dbinom(x, N, p)
plot(x, pseq, type="h", xlab="k", ylim=c(0, 1.3*max(pseq)), ylab=paste("Prob(k, N=",N,", p=", p,")"))
points(x, pseq, pch=18,cex=0.5)


###################################################
### code chunk number 8: BinomialDist-essay.Rnw:460-465
###################################################
N <- 2000; p<- 0.150; x1 <- max(0, N*p-4*sqrt(p*(1-p)*N)); x2 <- min(N*p+4*sqrt(p*(1-p)*N),N)
x <- as.integer(x1): as.integer(x2+1)
pseq <- dbinom(x, N, p)
plot(x, pseq, type="h", xlab="k", ylab=paste("Prob(k, N=",N,", p=", p,")"))
points(x, pseq, pch=18,cex=0.5)


###################################################
### code chunk number 9: BinomialDist-essay.Rnw:478-483
###################################################
N <- 2000; p<- 0.01; x1 <- max(0, N*p-4*sqrt(p*(1-p)*N)); x2 <- min(N*p+4*sqrt(p*(1-p)*N),N)
x <- as.integer(x1): as.integer(x2+1)
pseq <- dbinom(x, N, p)
plot(x, pseq, type="h", xlab="k", ylab=paste("Prob(k, N=",N,", p=", p,")"))
points(x, pseq, pch=18,cex=0.5)


