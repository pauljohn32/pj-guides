### R code from vignette source 'summeR-2-6-tables-uniquebackupstring.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: summeR-2-6-tables-uniquebackupstring.Rnw:27-28
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
### code chunk number 4: datain
###################################################
wdir23 <- "../summeR-2-3-recoding/workingdata"
list.files(wdir23)


###################################################
### code chunk number 5: datain
###################################################
file.copy(from = wdir23, to = ".", recursive = TRUE, overwrite = TRUE)


###################################################
### code chunk number 6: summeR-2-6-tables-uniquebackupstring.Rnw:303-305
###################################################
wdir <- "workingdata"
fl <- list.files(wdir, full.names = TRUE)


###################################################
### code chunk number 7: summeR-2-6-tables-uniquebackupstring.Rnw:309-310
###################################################
fl


###################################################
### code chunk number 8: summeR-2-6-tables-uniquebackupstring.Rnw:314-315
###################################################
ls()


###################################################
### code chunk number 9: summeR-2-6-tables-uniquebackupstring.Rnw:320-321
###################################################
anes2 <- readRDS(fl[1])


###################################################
### code chunk number 10: summeR-2-6-tables-uniquebackupstring.Rnw:325-326
###################################################
ls()


###################################################
### code chunk number 11: summeR-2-6-tables-uniquebackupstring.Rnw:332-333
###################################################
load(fl[2])


###################################################
### code chunk number 12: summeR-2-6-tables-uniquebackupstring.Rnw:338-339
###################################################
ls()


###################################################
### code chunk number 13: summeR-2-6-tables-uniquebackupstring.Rnw:344-345
###################################################
rm(fl)


###################################################
### code chunk number 14: mod1
###################################################
summary(mod1)


###################################################
### code chunk number 15: mod2
###################################################
summary(mod2)


###################################################
### code chunk number 16: summeR-2-6-tables-uniquebackupstring.Rnw:372-374
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 17: summeR-2-6-tables-uniquebackupstring.Rnw:379-380
###################################################
varLabs <- c("V043250" = "Age", "V041109AF" = "Gender Female", "V043116WD" = "Dem, Weak",  "V043116ID" = "Indep Lean Dem", "V043116I" = "Independent", "V043116IR" = "Indep Lean Repub", "V043116WR" = "Repub, Weak", "V043116R" = "Repub", "V043116SR" = "Repub, Str")


###################################################
### code chunk number 18: summeR-2-6-tables-uniquebackupstring.Rnw:383-384
###################################################
options(options.orig)


###################################################
### code chunk number 19: anes40a
###################################################
library(rockchalk)


###################################################
### code chunk number 20: anes45b
###################################################
or45b <- outreg(list("Model 1" = mod1, "Model 2" = mod2), tight = FALSE, varLabels = varLabs, print.results = FALSE)
cat(or45b)


###################################################
### code chunk number 21: anes40b
###################################################
or40b <- outreg(list("Model 1" = mod1), tight = FALSE, varLabels = varLabs)


###################################################
### code chunk number 22: outreg50 (eval = FALSE)
###################################################
## library(rockchalk)
## ## The first model's table
## or40b <- outreg(list("Model 1" = mod1), tight = FALSE, varLabels = varLabs)
## ## The second model's table
## or45b <- outreg(list("Model 1" = mod1, "Model 2" = mod2), tight = FALSE, varLabels = varLabs, print.results = FALSE)
## cat(or45b)


###################################################
### code chunk number 23: anes70c
###################################################
or70 <- outreg(list("Model 1" = mod1, "Model 2" = mod2, "Model 3" = mod3), tight = FALSE, varLabels = varLabs)


###################################################
### code chunk number 24: outreg70d (eval = FALSE)
###################################################
## or70 <- outreg(list("Model 1" = mod1, "Model 2" = mod2, "Model 3" = mod3), tight = FALSE, varLabels = varLabs)


###################################################
### code chunk number 25: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 26: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


