### R code from vignette source 'summeR-2-4-analysis-uniquebackupstring.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: summeR-2-4-analysis-uniquebackupstring.Rnw:27-28
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
### code chunk number 4: summeR-2-4-analysis-uniquebackupstring.Rnw:278-280
###################################################
dat1 <- read.table("data/oregon.csv", sep = ",", header = TRUE, stringsAsFactors = FALSE)
head(dat1)


###################################################
### code chunk number 5: oregon10
###################################################
plot(tann ~ elevation, data = dat1, xlab="Elevation above sea level", ylab="Annual Average Temperature (Celsius)", main="")


###################################################
### code chunk number 6: oregon20
###################################################
mod1 <- lm (tann ~ elevation, data = dat1)


###################################################
### code chunk number 7: oregon25
###################################################
summary(mod1)


###################################################
### code chunk number 8: summeR-2-4-analysis-uniquebackupstring.Rnw:364-365
###################################################
class(mod1)


###################################################
### code chunk number 9: summeR-2-4-analysis-uniquebackupstring.Rnw:381-382
###################################################
mod1sum <- summary(mod1)


###################################################
### code chunk number 10: summeR-2-4-analysis-uniquebackupstring.Rnw:389-390
###################################################
coef(mod1)


###################################################
### code chunk number 11: summeR-2-4-analysis-uniquebackupstring.Rnw:395-396
###################################################
coef(mod1sum)


###################################################
### code chunk number 12: summeR-2-4-analysis-uniquebackupstring.Rnw:402-403
###################################################
class(mod1sum)


###################################################
### code chunk number 13: oregon29
###################################################
confint(mod1)


###################################################
### code chunk number 14: oregon30
###################################################
par(mfcol = c(2,2))
plot(mod1)
par(mfcol = c(1,1))


###################################################
### code chunk number 15: oregon40
###################################################
library(rockchalk)
plotSlopes(mod1, plotx = "elevation", interval = "confidence", xlab = "Elevation above sea level", ylab = "Annual Average Temperature (Celsius)", main="")


###################################################
### code chunk number 16: regtable
###################################################
library(rockchalk)
or10 <- outreg(list("Temperature" = mod1)) 
cat(or10)


###################################################
### code chunk number 17: regtable20 (eval = FALSE)
###################################################
## dat1$elevationP1000 <- dat1$elevation / 1000
## mod2 <- lm(tann ~ elevationP1000, data = dat1)
## or20 <- outreg(list("Temperature" = mod2), varLabels = list("elevationP1000" = "Elev. per 1000 ft"))
## cat(or20)


###################################################
### code chunk number 18: summeR-2-4-analysis-uniquebackupstring.Rnw:516-517
###################################################
dat1$elevationP1000 <- dat1$elevation / 1000
mod2 <- lm(tann ~ elevationP1000, data = dat1)
or20 <- outreg(list("Temperature" = mod2), varLabels = list("elevationP1000" = "Elev. per 1000 ft"))
cat(or20)


###################################################
### code chunk number 19: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 20: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


