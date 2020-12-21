### R code from vignette source 'summeR-1-4-getwd-uniquebackupstring.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: summeR-1-4-getwd-uniquebackupstring.Rnw:28-29
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: tmpout
###################################################
tdir <- "tmpout"
if(!dir.exists(tdir)) dir.create(tdir, showWarnings=FALSE)


###################################################
### code chunk number 3: Roptions
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
### code chunk number 4: summeR-1-4-getwd-uniquebackupstring.Rnw:308-309
###################################################
getwd()


###################################################
### code chunk number 5: summeR-1-4-getwd-uniquebackupstring.Rnw:317-318 (eval = FALSE)
###################################################
## setwd("...some...folder...you...specify...correctly")


###################################################
### code chunk number 6: summeR-1-4-getwd-uniquebackupstring.Rnw:345-346 (eval = FALSE)
###################################################
## setwd("C:/users/pauljohn/Documents/schoolwork/stats/exercise1")


###################################################
### code chunk number 7: summeR-1-4-getwd-uniquebackupstring.Rnw:454-456 (eval = FALSE)
###################################################
## library(kutils)
## initProject()


###################################################
### code chunk number 8: p5
###################################################
x <- rgamma(100, 1.5, 2.2)
y <- rnorm(100) + 0.2 * x
pdf("output/scatter1.pdf", height=6, width=6, paper="special")
plot(y ~ x, main="Scatterplot or Bust!")
dev.off() #turns off pdf output device


###################################################
### code chunk number 9: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 10: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


