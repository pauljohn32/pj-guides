### R code from vignette source 'summeR-1-3-packages-uniquebackupstring.Rnw'
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
### code chunk number 3: summeR-1-3-packages-uniquebackupstring.Rnw:274-275
###################################################
sessionInfo()


###################################################
### code chunk number 4: summeR-1-3-packages-uniquebackupstring.Rnw:295-296 (eval = FALSE)
###################################################
## library()


###################################################
### code chunk number 5: summeR-1-3-packages-uniquebackupstring.Rnw:763-765
###################################################
op <- options()
options(width = 50)


###################################################
### code chunk number 6: summeR-1-3-packages-uniquebackupstring.Rnw:768-769
###################################################
.libPaths()


###################################################
### code chunk number 7: summeR-1-3-packages-uniquebackupstring.Rnw:772-773
###################################################
options(op)


###################################################
### code chunk number 8: summeR-1-3-packages-uniquebackupstring.Rnw:783-784 (eval = FALSE)
###################################################
## library(package-name-here)


###################################################
### code chunk number 9: summeR-1-3-packages-uniquebackupstring.Rnw:788-789 (eval = FALSE)
###################################################
## help(package = "package-name-here")


###################################################
### code chunk number 10: summeR-1-3-packages-uniquebackupstring.Rnw:793-795
###################################################
library(MASS)
help(package = "MASS")


###################################################
### code chunk number 11: summeR-1-3-packages-uniquebackupstring.Rnw:809-810 (eval = FALSE)
###################################################
## options("repos")


