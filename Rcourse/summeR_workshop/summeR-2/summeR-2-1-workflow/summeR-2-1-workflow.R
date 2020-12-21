### R code from vignette source 'summeR-2-1-workflow-uniquebackupstring.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: summeR-2-1-workflow-uniquebackupstring.Rnw:36-37
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
### code chunk number 4: summeR-2-1-workflow-uniquebackupstring.Rnw:430-433 (eval = FALSE)
###################################################
## library(kutils)
## ## Creates directories in current working directory
## initProject()


###################################################
### code chunk number 5: summeR-2-1-workflow-uniquebackupstring.Rnw:462-470 (eval = FALSE)
###################################################
## library(kutils)
## owd <- getwd()
## tdir <- tempdir()
## setwd(tdir)
## initProject()
## list.files()
## # go back to your original directory
## setwd(owd)


###################################################
### code chunk number 6: summeR-2-1-workflow-uniquebackupstring.Rnw:483-484 (eval = FALSE)
###################################################
## if(!file.exists("../data")) dir.create("../data", showWarnings = TRUE)


###################################################
### code chunk number 7: summeR-2-1-workflow-uniquebackupstring.Rnw:490-492 (eval = FALSE)
###################################################
## ddir <- "../data"
## if(!file.exists(ddir)) dir.create(ddir, showWarnings = TRUE)


###################################################
### code chunk number 8: summeR-2-1-workflow-uniquebackupstring.Rnw:498-503 (eval = FALSE)
###################################################
## fn <- "ortann.csv"
## URL <- paste0("http://pj.freefaculty.org/guides/", 
##                 "stat/DataSets/OregonTemps/", fn)
## download.file(URL, destfile = file.path(ddir, "oregon.csv"))
## list.files(ddir)


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


