### R code from vignette source 'sem-4-2-mediation-uniquebackupstring.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: sem-4-2-mediation-uniquebackupstring.Rnw:28-29
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 5: data10
###################################################
ddir <- "../../data"
fn <- "affect-2.csv"
dat <- read.csv(file.path(ddir, fn))


###################################################
### code chunk number 6: agencyhead
###################################################
head(dat)


###################################################
### code chunk number 7: data30
###################################################
library(lavaan)
library(semPlot)


###################################################
### code chunk number 8: lav10
###################################################
cfa.mod <- '
Agency =~ Agency1 + Agency2 + Agency3
Intrinsic =~ Intrin1 + Intrin2 + Intrin3
Extrinsic =~ Extrin1 + Extrin2 + Extrin3
Positive =~ PosAFF1 + PosAFF2 + PosAFF3
Negative =~ NegAFF1 + NegAFF2 + NegAFF3
'
cfa3 <- cfa(cfa.mod, data = dat, std.lv = TRUE)


###################################################
### code chunk number 9: lav30a
###################################################
summary(cfa3)


###################################################
### code chunk number 10: lav30b
###################################################
vl <- c("Intrin1" = "Intrinsic1", "Intrin2" = "Intrinsic2",  "Intrin3" = "Intrinsic3", "Extrin1" = "Extrinsic1", "Extrin2" = "Extrinsic2",  "Extrin3" = "Extrinsic3", "PosAFF1" = "Positive1", "PosAFF2" = "Positive2", "PosAFF3" = "Positive3",         "NegAFF1" = "Negative1", "NegAFF2" = "Negative2", "NegAFF3" = "Negative3")


###################################################
### code chunk number 11: lav30c
###################################################
library(semTable)
cfa3.tab <- semTable(list("Confirmatory Factor Analysis" = cfa3), columns = c("estsestars"), varLabels = vl, longtable = TRUE, print.results = FALSE)


###################################################
### code chunk number 12: lav30d
###################################################
cat(cfa3.tab)


###################################################
### code chunk number 13: cfa30
###################################################
mediat.mod.2 <- '
Agency =~ Agency1 + Agency2 + Agency3
Intrinsic =~ Intrin1 + Intrin2 + Intrin3
Extrinsic =~ Extrin1 + Extrin2 + Extrin3
Positive =~ PosAFF1 + PosAFF2 + PosAFF3
Negative =~ NegAFF1 + NegAFF2 + NegAFF3
Positive ~ b1*Intrinsic + Agency
Negative ~ b2*Extrinsic
Intrinsic ~ a1*Agency
Extrinsic ~ a2*Agency
Intrinsic ~~ Extrinsic
## define mediation parameters (indirect effects)
ind1 := a1 * b1
ind2 := a2 * b2
'


###################################################
### code chunk number 14: bootparm
###################################################
Nboot <- 500


###################################################
### code chunk number 15: med10
###################################################
mediat.out.2 <- sem(mediat.mod.2, data = dat, std.lv = TRUE, se = "boot", bootstrap = Nboot)
summary(mediat.out.2, standardized = TRUE, fit = TRUE)


###################################################
### code chunk number 16: med11
###################################################
saveRDS(mediat.out.2, file = file.path(odir, "mediat.out.2.rds"))


###################################################
### code chunk number 17: sem-4-2-mediation-uniquebackupstring.Rnw:605-607
###################################################
if(!exists("mediat.out.2"))
    mediat.out.2 <- readRDS(file.path(odir, "mediat.out.2.rds"))


###################################################
### code chunk number 18: med20
###################################################
semcfa.tab <- semTable(list("SEM" = mediat.out.2, "CFA" = cfa3), columns = c("estsestars"), varLabels = vl, longtable = TRUE, print.results = FALSE)


###################################################
### code chunk number 19: med30
###################################################
cat(semcfa.tab)


###################################################
### code chunk number 20: cfa40
###################################################
anova(cfa3, mediat.out.2)


###################################################
### code chunk number 21: cfa100
###################################################
# if nesting is not specified, the diff is not reported
compareLavaan(list("CFA" = cfa3, "SEM" = mediat.out.2), nesting = "CFA > SEM", fitmeas = c("chisq", "df", "pvalue", "rmsea", "cfi", "bic"),  type="latex")


###################################################
### code chunk number 22: stdboot
###################################################
mediat.out.2.std.A <- sem(mediat.mod.2, data = dat, std.lv = TRUE, std.ov=TRUE, se = "boot", bootstrap = Nboot)
summary(mediat.out.2.std.A, fit = TRUE)


###################################################
### code chunk number 23: stdupdate
###################################################
mediat.out.2.std.B <- update(mediat.out.2, std.lv = TRUE, std.ov = TRUE)
summary(mediat.out.2.std.B, fit = TRUE)


###################################################
### code chunk number 24: cfa50
###################################################
summary(mediat.out.2, standardized = TRUE)


###################################################
### code chunk number 25: sem-4-2-mediation-uniquebackupstring.Rnw:731-734
###################################################
mediat.out.2.std = update(mediat.out.2, std.lv = TRUE, std.ov = TRUE, meanstructure=TRUE)
semTable(list("Standardized" = mediat.out.2.std, "Not Standardized" = mediat.out.2), 
longtable = TRUE, columns = c("estsestars"), varLabels = vl)


###################################################
### code chunk number 26: semplot40
###################################################
semPaths(mediat.out.2)


###################################################
### code chunk number 27: cfa100
###################################################
mediat.mod.3 <- '
## measurement model
Agency =~ Agency1 + Agency2 + Agency3
Intrinsic =~ Intrin1 + Intrin2 + Intrin3
Extrinsic =~ Extrin1 + Extrin2 + Extrin3
Positive =~ PosAFF1 + PosAFF2 + PosAFF3
Negative =~ NegAFF1 + NegAFF2 + NegAFF3
## structural model
Positive ~ b1*Intrinsic + Agency
Negative ~ b2*Extrinsic
Intrinsic ~ a1*Agency
Extrinsic ~ a2*Agency
Intrinsic ~~ Extrinsic
## define mediation parameters (indirect effects)
c1 := a1 * b1
c2 := a2 * b2
c1 == c2
'


###################################################
### code chunk number 28: cfa110
###################################################
Nboot <- 500
mediat.out.3 <- sem(mediat.mod.3, data = dat,
                    std.lv = TRUE, se = "boot", bootstrap = Nboot)
summary(mediat.out.3, standardized = TRUE, fit = TRUE)


###################################################
### code chunk number 29: cfa111
###################################################
anova(mediat.out.3, mediat.out.2)


###################################################
### code chunk number 30: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 31: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


