### R code from vignette source 'summeR-4-matrices-uniquebackupstring.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: tmpout
###################################################
tdir <- "tmpout"
if(!dir.exists(tdir)) dir.create(tdir, showWarnings=FALSE)


###################################################
### code chunk number 2: Roptions
###################################################
opts.orig <- options()
options(width=100, prompt="> ")
options(useFancyQuotes = FALSE)
set.seed(12345)
par.orig <- par(no.readonly = TRUE) 
pjmar <- c(4.1, 4.1, 1.5, 2.1)
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12, xpd=F)))
pdf.options(onefile=F,family="Times",pointsize=12)
if(!file.exists("theme")) file.symlink("../../../../template/theme", "theme")


###################################################
### code chunk number 3: v10
###################################################
x1a <- vector(mode = "double", length = 10)
x1b <- double(length = 10) 
x1c <- numeric(length = 10)
## numeric is older terminology
x1a
identical(x1a, x1b, x1c)


###################################################
### code chunk number 4: summeR-4-matrices-uniquebackupstring.Rnw:374-375
###################################################
length(x1a)


###################################################
### code chunk number 5: v20
###################################################
x2a <- c(10, 9, 8, 7, 6, 5, 4, 3, 2, 1)
x2b <- seq(10, 1, by = -1)
identical(x2a, x2b)


###################################################
### code chunk number 6: v40
###################################################
x <- c(4, 2, 1, 0, 3)
y <- c(1, 2, 5, 0, 1)
x + y
y - x


###################################################
### code chunk number 7: v60
###################################################
x <- c(1,2,3,4,5,6)
y <- c(1,2)
x + y


###################################################
### code chunk number 8: v80
###################################################
x <- c(1L, 2L, 3L)
class(x)
## same as as.numeric()
y <- as.double(x)
y
class(y)


###################################################
### code chunk number 9: v90
###################################################
x <- c(1.1, 2.2, 3.9)
is.integer(x)
y <- as.integer(x)
y


###################################################
### code chunk number 10: summeR-4-matrices-uniquebackupstring.Rnw:512-514
###################################################
x
t(x)


###################################################
### code chunk number 11: summeR-4-matrices-uniquebackupstring.Rnw:589-592
###################################################
x <- c(1, 12, 21)
y <- c(0.1, 0.5, 1/3)
t(x) %*% y


###################################################
### code chunk number 12: summeR-4-matrices-uniquebackupstring.Rnw:600-603 (eval = FALSE)
###################################################
## x <- c(1, 12, 21, 19, 18)
## y <- c(0.1, 0.5, 1/3)
## t(x) %*% y


###################################################
### code chunk number 13: summeR-4-matrices-uniquebackupstring.Rnw:655-659
###################################################
x <- c(1,2,3)
y <- c(4,5,6) 
x %*% y
t(x) %*% y


###################################################
### code chunk number 14: summeR-4-matrices-uniquebackupstring.Rnw:671-674
###################################################
x <- c(1,2,3)
y <- c(4,5,6) 
x * y


###################################################
### code chunk number 15: summeR-4-matrices-uniquebackupstring.Rnw:679-682
###################################################
x <- 1:3
y <- 1:10
x*y  


###################################################
### code chunk number 16: summeR-4-matrices-uniquebackupstring.Rnw:696-699
###################################################
(x <- c(1:3, 1:3, 1:3, 1))
(y <- 1:10)
x*y  


###################################################
### code chunk number 17: summeR-4-matrices-uniquebackupstring.Rnw:714-716
###################################################
X <- matrix(1:24, nrow = 4, ncol = 6, byrow = FALSE, dimnames = list(NULL, letters[1:6]))
X


###################################################
### code chunk number 18: summeR-4-matrices-uniquebackupstring.Rnw:729-732
###################################################
x1 <- 1:4; x2 <- 5:8; x3 <- 9:12;
x4 <- 13:16; x5 <- 17:20; x6 <- 21:24
cbind(x1, x2, x3, x4, x5, x6)


###################################################
### code chunk number 19: summeR-4-matrices-uniquebackupstring.Rnw:745-747
###################################################
dim(x1a)
dim(X)


###################################################
### code chunk number 20: summeR-4-matrices-uniquebackupstring.Rnw:755-760
###################################################
## Take 4th column from X
X4 <- X[ , 4]
is.matrix(X)
is.matrix(X4)
is.vector(X4)


###################################################
### code chunk number 21: summeR-4-matrices-uniquebackupstring.Rnw:766-769
###################################################
X4mat <- X[ , 4, drop = FALSE]
is.matrix(X4mat)
is.vector(X4mat)


###################################################
### code chunk number 22: summeR-4-matrices-uniquebackupstring.Rnw:775-777
###################################################
NROW(x1a)
NCOL(x1a)


###################################################
### code chunk number 23: summeR-4-matrices-uniquebackupstring.Rnw:872-877
###################################################
X1 <- matrix(1:12, nrow = 2)
X1
X2 <- matrix(13:24, ncol = 2)
X2
X1 %*% X2


###################################################
### code chunk number 24: summeR-4-matrices-uniquebackupstring.Rnw:956-957
###################################################
crossprod(X)


###################################################
### code chunk number 25: summeR-4-matrices-uniquebackupstring.Rnw:1026-1031
###################################################
library(MASS)
mu <- c(0, 0, 0)
Sigma <- diag(c(1, 1, 1))
Sigma
mvrnorm(5, mu, Sigma)


###################################################
### code chunk number 26: summeR-4-matrices-uniquebackupstring.Rnw:1035-1039
###################################################
mu <- rep(0, 3)
Sigma <- matrix(c(1, .3, -.1, .3, 1, .2, -.1, .2, 1), nrow = 3)
Sigma
mvrnorm(5, mu = mu, Sigma = Sigma)


###################################################
### code chunk number 27: summeR-4-matrices-uniquebackupstring.Rnw:1210-1212
###################################################
library(rockchalk)
Rho <- lazyCor(.5, d = 5)


###################################################
### code chunk number 28: summeR-4-matrices-uniquebackupstring.Rnw:1215-1216
###################################################
Rho


###################################################
### code chunk number 29: summeR-4-matrices-uniquebackupstring.Rnw:1221-1224
###################################################
Rho.d <- diag(Rho)
Rho.d
all.equal(Rho.d, rep(1, times = 5))


###################################################
### code chunk number 30: summeR-4-matrices-uniquebackupstring.Rnw:1229-1230
###################################################
isSymmetric(Rho)


###################################################
### code chunk number 31: summeR-4-matrices-uniquebackupstring.Rnw:1235-1240
###################################################
## Seems like should be more direct way, but...
z <- as.vector(Rho)
z
## single | for vector compare
any(z > 1 | z < -1)


###################################################
### code chunk number 32: summeR-4-matrices-uniquebackupstring.Rnw:1254-1258 (eval = FALSE)
###################################################
## eS <- eigen(Sigma, symmetric = TRUE)
## ev <- eS$values
## if (!all(ev >= -tol * abs(ev[1L])))
##         stop("'Sigma' is not positive definite")


###################################################
### code chunk number 33: summeR-4-matrices-uniquebackupstring.Rnw:1276-1278 (eval = FALSE)
###################################################
## library(rockchalk)
## example(mcGraph3)


###################################################
### code chunk number 34: summeR-4-matrices-uniquebackupstring.Rnw:1369-1375 (eval = FALSE)
###################################################
## mod1 <- lm(y ~ x1 + x2 + x3, data = any_data_you_have)
## summary(mod1)
## X <- model.matrix(mod1)
## XTX <- t(X) %*% X
## XTXinv <- solve(XTX)
## BetaHat <- XTXinv %*% t(X) %*% any_data_you_have$y


###################################################
### code chunk number 35: summeR-4-matrices-uniquebackupstring.Rnw:1384-1388 (eval = FALSE)
###################################################
## X <- model.matrix(lm.D9)
## XTX <- t(X) %*% X
## XTXinv <- solve(XTX)
## Beta <- XTXinv %*% t(X) %*% weight


###################################################
### code chunk number 36: summeR-4-matrices-uniquebackupstring.Rnw:1442-1443 (eval = FALSE)
###################################################
## lm


###################################################
### code chunk number 37: summeR-4-matrices-uniquebackupstring.Rnw:1451-1452 (eval = FALSE)
###################################################
## z <- .Call(C_Cdqrls, x, y, tol, FALSE)


###################################################
### code chunk number 38: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 39: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


