### R code from vignette source 'summeR-4-2-iteration-uniquebackupstring.Rnw'
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
### code chunk number 3: summeR-4-2-iteration-uniquebackupstring.Rnw:333-340
###################################################
x <- vector()
y <- vector()
for (i in 1:10) {
   x[i] <- log(i)
   y[i] <- exp(x[i])
}
cbind(i = 1:10, x, y)


###################################################
### code chunk number 4: summeR-4-2-iteration-uniquebackupstring.Rnw:355-361
###################################################
x <- log(1:10)
y <- vector()
for (johnelway in seq_along(x)){
  y[johnelway] <- exp(x[johnelway])
}
cbind(johnelway = seq_along(x), x, y)


###################################################
### code chunk number 5: summeR-4-2-iteration-uniquebackupstring.Rnw:374-379 (eval = FALSE)
###################################################
## myL <- list()
## ## pretend myL is full of some precious objects
## for (i in seq_along(myL)){
##   myL[[i]] <- someFunctionYouMakeUp(myL[[i]])
## }


###################################################
### code chunk number 6: summeR-4-2-iteration-uniquebackupstring.Rnw:387-391 (eval = FALSE)
###################################################
## newL <- list()
## for (i in 1:10){
##   newL[[i]] <- someFunctionYouMakeUp(myL[[i]])
## }


###################################################
### code chunk number 7: rep10
###################################################
## Declare a vector heinz57, do something to each element
heinz57 <- vector(mode = "numeric", length = 57)
for(i in 1:57) {
    heinz57[i] <- log(i)
}


###################################################
### code chunk number 8: rep20
###################################################
x1 <- log(1:57)
identical(x1, heinz57)


###################################################
### code chunk number 9: summeR-4-2-iteration-uniquebackupstring.Rnw:450-451 (eval = FALSE)
###################################################
## dat$z <- ifelse(dat$x1 > dat$y, dat$x1, dat$x2)


###################################################
### code chunk number 10: summeR-4-2-iteration-uniquebackupstring.Rnw:456-464 (eval = FALSE)
###################################################
## dat$z2 <- NA
## for(i in 1:NROW(dat)){
##     dat$z2[i] <- if(dat$x1[i] > dat$y[i]){
##         dat$x1[i] 
##     } else {
##         dat$x2[i]
##     }
## }


###################################################
### code chunk number 11: summeR-4-2-iteration-uniquebackupstring.Rnw:490-494 (eval = FALSE)
###################################################
## alist <- vector(mode = "list", length = 10000)
## for(i in 1:10000){
##     alist2[[i]] <- matrix(rnorm(9), ncol = 3)
## }


###################################################
### code chunk number 12: summeR-4-2-iteration-uniquebackupstring.Rnw:533-536
###################################################
set.seed(234)
getDF <- function(i) {data.frame(ds = i, x1 = rnorm(100), x2 = rnorm(100))}
jumboData <- lapply(1:150, getDF)


###################################################
### code chunk number 13: summeR-4-2-iteration-uniquebackupstring.Rnw:542-543
###################################################
colMresults <- lapply(jumboData, colMeans)


###################################################
### code chunk number 14: summeR-4-2-iteration-uniquebackupstring.Rnw:547-550
###################################################
is.list(colMresults)
print(colMresults[[1]])
print(colMresults[[2]])


###################################################
### code chunk number 15: summeR-4-2-iteration-uniquebackupstring.Rnw:556-559
###################################################
colMstacked <- do.call(rbind, colMresults)
dim(colMstacked)
head(colMstacked)


###################################################
### code chunk number 16: summeR-4-2-iteration-uniquebackupstring.Rnw:572-573 (eval = FALSE)
###################################################
##     aNewList <- lapply(someList, FUN = someFunction)


###################################################
### code chunk number 17: summeR-4-2-iteration-uniquebackupstring.Rnw:579-580 (eval = FALSE)
###################################################
##     aNewList <- lapply(someList, FUN = someFunction, arg2 = 7, arg3 = 5)


###################################################
### code chunk number 18: summeR-4-2-iteration-uniquebackupstring.Rnw:592-596
###################################################
getDF <- function(i, m1 = 0, m2 = 0, s1 = 1, s2 = 1) {
   data.frame(ds = i, x1 = rnorm(100, m1, s1), 
                      x2 = rnorm(100, m2, s2))}
jumboData <- lapply(1:150, getDF, m1 = 90, s1 = 10, m2 = 33, s2 = 10)


###################################################
### code chunk number 19: summeR-4-2-iteration-uniquebackupstring.Rnw:601-603
###################################################
colM3T <- t(sapply(jumboData, colMeans))
colM3T[1:5, ]


###################################################
### code chunk number 20: hist133
###################################################
ex133 <- jumboData[[133]]
head(ex133)


###################################################
### code chunk number 21: hist134
###################################################
hist(ex133$x1, xlab = "x1", prob = TRUE, main = "Sample 133", ylim = c(0, 0.07))
mtext("Histogram with KDE smooth", 3, -1)
lines(density(ex133$x1))
legend("right", legend = paste(c("mean =", "std.dev ="), round(c(mean(ex133$x1), sd(ex133$x1, 2)),2)))


###################################################
### code chunk number 22: summeR-4-2-iteration-uniquebackupstring.Rnw:645-649
###################################################
colMresults2 <- sapply(jumboData, colMeans)
dim(colMresults2)
## That's 150 columns with 3 rows each. The first 3 columns
colMresults2[ , 1:3]


###################################################
### code chunk number 23: summeR-4-2-iteration-uniquebackupstring.Rnw:658-660
###################################################
colMresults2T <- t(colMresults2)
head(colMresults2T)


###################################################
### code chunk number 24: summeR-4-2-iteration-uniquebackupstring.Rnw:674-677
###################################################
colMresults3 <- vapply(jumboData, colMeans, numeric(3))
## 3rd argument gives structure required in output from colMeans
str(colMresults3)


###################################################
### code chunk number 25: summeR-4-2-iteration-uniquebackupstring.Rnw:684-685
###################################################
colMresults3[ , 1:5]


###################################################
### code chunk number 26: poisson10
###################################################
samp <- rpois(20, lambda=3)


###################################################
### code chunk number 27: poisson20
###################################################
median(samp)


###################################################
### code chunk number 28: poisson30
###################################################
calcMed <- function(x, ind){
  median(x[ind])
}


###################################################
### code chunk number 29: poisson90
###################################################
library(boot)
bpois <- boot(samp, calcMed, R = 1000)
bpois


###################################################
### code chunk number 30: poisson100
###################################################
  plot(bpois)


###################################################
### code chunk number 31: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 32: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


