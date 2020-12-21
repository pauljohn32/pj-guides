### R code from vignette source 'summeR-1-2-docs-uniquebackupstring.Rnw'
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
### code chunk number 3: summeR-1-2-docs-uniquebackupstring.Rnw:248-249
###################################################
library()


###################################################
### code chunk number 4: summeR-1-2-docs-uniquebackupstring.Rnw:254-255 (eval = FALSE)
###################################################
## help.start()


###################################################
### code chunk number 5: summeR-1-2-docs-uniquebackupstring.Rnw:289-290
###################################################
help(package = "stats")


###################################################
### code chunk number 6: summeR-1-2-docs-uniquebackupstring.Rnw:295-296 (eval = FALSE)
###################################################
## help(topic = "lm")


###################################################
### code chunk number 7: summeR-1-2-docs-uniquebackupstring.Rnw:302-303 (eval = FALSE)
###################################################
## help("lm")


###################################################
### code chunk number 8: summeR-1-2-docs-uniquebackupstring.Rnw:309-310 (eval = FALSE)
###################################################
## help(lm)


###################################################
### code chunk number 9: summeR-1-2-docs-uniquebackupstring.Rnw:314-315
###################################################
?lm


###################################################
### code chunk number 10: summeR-1-2-docs-uniquebackupstring.Rnw:325-326
###################################################
options("help_type")


###################################################
### code chunk number 11: summeR-1-2-docs-uniquebackupstring.Rnw:332-333 (eval = FALSE)
###################################################
## options("help_type" = "text")


###################################################
### code chunk number 12: summeR-1-2-docs-uniquebackupstring.Rnw:337-338 (eval = FALSE)
###################################################
## help("ls", help_type = "text")


###################################################
### code chunk number 13: lmhelp (eval = FALSE)
###################################################
## ?lm


###################################################
### code chunk number 14: summeR-1-2-docs-uniquebackupstring.Rnw:535-536
###################################################
library(rpart)


###################################################
### code chunk number 15: summeR-1-2-docs-uniquebackupstring.Rnw:541-542 (eval = FALSE)
###################################################
## help(package = "rpart")


###################################################
### code chunk number 16: summeR-1-2-docs-uniquebackupstring.Rnw:557-558 (eval = FALSE)
###################################################
## vignette("longintro")


###################################################
### code chunk number 17: summeR-1-2-docs-uniquebackupstring.Rnw:599-600
###################################################
sessionInfo()


###################################################
### code chunk number 18: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 19: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


