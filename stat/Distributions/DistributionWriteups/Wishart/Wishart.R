### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.T10985/lyx_tmpbuf2/Wishart.Rnw'

###################################################
### code chunk number 1: Wishart.Rnw:14-15
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Wishart.Rnw:90-92
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
### code chunk number 4: wishex1 (eval = FALSE)
###################################################
## library(mvtnorm)
## meanV <- c(0,0,0,0)
## varV <- 3*diag(4)
## X <- rmvnorm(10, mean = meanV, sigma = varV)
## W <- t(X) %*% X
## W


###################################################
### code chunk number 5: Wishart.Rnw:161-162
###################################################
library(mvtnorm)
meanV <- c(0,0,0,0)
varV <- 3*diag(4)
X <- rmvnorm(10, mean = meanV, sigma = varV)
W <- t(X) %*% X
W


###################################################
### code chunk number 6: Wishart.Rnw:167-168
###################################################
library(mvtnorm)
meanV <- c(0,0,0,0)
varV <- 3*diag(4)
X <- rmvnorm(10, mean = meanV, sigma = varV)
W <- t(X) %*% X
W


###################################################
### code chunk number 7: Wishart.Rnw:173-174
###################################################
library(mvtnorm)
meanV <- c(0,0,0,0)
varV <- 3*diag(4)
X <- rmvnorm(10, mean = meanV, sigma = varV)
W <- t(X) %*% X
W


