### R code from vignette source 'summeR-3-3-sem-uniquebackupstring.Rnw'
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
if(!file.exists("output")) dir.create("output")


###################################################
### code chunk number 3: summeR-3-3-sem-uniquebackupstring.Rnw:246-248
###################################################
file.copy(from = "../summeR-3-2-lm/workingdata/affect.rds", to = "workingdata/affect.rds", overwrite = TRUE)
dat <- readRDS("workingdata/affect.rds")


###################################################
### code chunk number 4: summeR-3-3-sem-uniquebackupstring.Rnw:251-253
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 5: summeR-3-3-sem-uniquebackupstring.Rnw:257-258
###################################################
head(dat)


###################################################
### code chunk number 6: summeR-3-3-sem-uniquebackupstring.Rnw:261-262
###################################################
options(options.orig)


###################################################
### code chunk number 7: summeR-3-3-sem-uniquebackupstring.Rnw:542-544
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 8: summeR-3-3-sem-uniquebackupstring.Rnw:548-550
###################################################
lm1 <- lm(posAffect ~ agency + intMotiv + extMotiv*agency, data = dat)
coef(lm1)


###################################################
### code chunk number 9: summeR-3-3-sem-uniquebackupstring.Rnw:553-554
###################################################
options(options.orig)


###################################################
### code chunk number 10: summeR-3-3-sem-uniquebackupstring.Rnw:560-561
###################################################
dat$agency.X.extMotiv <- dat$agency * dat$extMotiv


###################################################
### code chunk number 11: summeR-3-3-sem-uniquebackupstring.Rnw:566-568
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 12: summeR-3-3-sem-uniquebackupstring.Rnw:572-575
###################################################
library(lavaan)
sem.fmla <- 'posAffect ~ agency + intMotiv + extMotiv + agency.X.extMotiv'
sem1 <- sem(sem.fmla, data = dat, meanstructure = TRUE)


###################################################
### code chunk number 13: summeR-3-3-sem-uniquebackupstring.Rnw:578-579
###################################################
options(options.orig)


###################################################
### code chunk number 14: summeR-3-3-sem-uniquebackupstring.Rnw:591-592
###################################################
sem1


###################################################
### code chunk number 15: summeR-3-3-sem-uniquebackupstring.Rnw:597-599
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 16: summeR-3-3-sem-uniquebackupstring.Rnw:603-604
###################################################
summary(sem1)


###################################################
### code chunk number 17: summeR-3-3-sem-uniquebackupstring.Rnw:607-608
###################################################
options(options.orig)


###################################################
### code chunk number 18: summeR-3-3-sem-uniquebackupstring.Rnw:614-616
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 19: summeR-3-3-sem-uniquebackupstring.Rnw:620-621
###################################################
summary(sem1, rsquare = TRUE, standardized = TRUE)


###################################################
### code chunk number 20: summeR-3-3-sem-uniquebackupstring.Rnw:624-625
###################################################
options(options.orig)


###################################################
### code chunk number 21: summeR-3-3-sem-uniquebackupstring.Rnw:632-635
###################################################
options(width=60)
parameterEstimates(sem1)
options(options.orig)


###################################################
### code chunk number 22: semtable10pre (eval = FALSE)
###################################################
## library(kutils)
## semtable10 <- semTable(sem1, fits = c("cfi", "rmsea"), longtable=TRUE, type = "latex", print.results = FALSE)
## cat(semtable10)


###################################################
### code chunk number 23: semtable10
###################################################
library(kutils)
semtable10 <- semTable(sem1, fits = c("cfi", "rmsea"), longtable=TRUE, type = "latex", print.results = FALSE)
cat(semtable10)


###################################################
### code chunk number 24: semplot10
###################################################
library(semPlot)
semPaths(sem1)


###################################################
### code chunk number 25: summeR-3-3-sem-uniquebackupstring.Rnw:687-691 (eval = FALSE)
###################################################
## coef(sem1)
## fitted(sem1)
## resid(sem1)
## anova(sem1)


###################################################
### code chunk number 26: summeR-3-3-sem-uniquebackupstring.Rnw:721-723
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 27: summeR-3-3-sem-uniquebackupstring.Rnw:727-730
###################################################
group.mod.1 <- 'posAffect ~ c(A, B)*agency'
group.out.1 <- sem(group.mod.1, data = dat, meanstructure = TRUE, group = "gender")
summary(group.out.1)


###################################################
### code chunk number 28: summeR-3-3-sem-uniquebackupstring.Rnw:733-734
###################################################
options(options.orig)


###################################################
### code chunk number 29: summeR-3-3-sem-uniquebackupstring.Rnw:740-742
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 30: summeR-3-3-sem-uniquebackupstring.Rnw:746-749
###################################################
group.mod.0 <- 'posAffect ~ c(B, B)*agency'
group.out.0 <- sem(group.mod.0, data = dat, meanstructure = TRUE, group = "gender")
summary(group.out.0)


###################################################
### code chunk number 31: summeR-3-3-sem-uniquebackupstring.Rnw:752-753
###################################################
options(options.orig)


###################################################
### code chunk number 32: summeR-3-3-sem-uniquebackupstring.Rnw:758-759
###################################################
anova(group.out.0, group.out.1)


###################################################
### code chunk number 33: summeR-3-3-sem-uniquebackupstring.Rnw:766-767
###################################################
parameterEstimates(group.out.1, ci = FALSE)[ , c(1,2, 3, 4, 5, 6, 7)]


###################################################
### code chunk number 34: cfaTable10pre (eval = FALSE)
###################################################
## library(kutils)
## cfaTable10 <- compareLavaan(list("Restricted" = group.out.0, "Unrestricted" = group.out.1), fitmeas = c("chisq", "df", "rmsea", "cfi"), nesting = NULL, type = "latex", file = "output/cfaTable10.tex", print.results = FALSE)
## cat(cfaTable10)


###################################################
### code chunk number 35: cfaTable10
###################################################
library(kutils)
cfaTable10 <- compareLavaan(list("Restricted" = group.out.0, "Unrestricted" = group.out.1), fitmeas = c("chisq", "df", "rmsea", "cfi"), nesting = NULL, type = "latex", file = "output/cfaTable10.tex", print.results = FALSE)
cat(cfaTable10)


###################################################
### code chunk number 36: summeR-3-3-sem-uniquebackupstring.Rnw:807-809
###################################################
modlm1 <- lm(posAffect ~ -1 + gender/agency, data = dat)
summary(modlm1, signif.stars = FALSE)


###################################################
### code chunk number 37: summeR-3-3-sem-uniquebackupstring.Rnw:815-817
###################################################
modlm2 <- lm(posAffect ~ -1 + gender + agency, data = dat)
summary(modlm2, signif.stars = FALSE)


###################################################
### code chunk number 38: summeR-3-3-sem-uniquebackupstring.Rnw:823-824
###################################################
anova(modlm1, modlm2)


###################################################
### code chunk number 39: sem100
###################################################
mediat.mod.0 <- '
posAffect ~ intMotiv
negAffect ~ extMotiv
intMotiv + extMotiv ~ agency
intMotiv ~~ extMotiv
'
mediat.out.0 <- sem(mediat.mod.0, data = dat)
summary(mediat.out.0, rsquare = TRUE, fit = TRUE)


###################################################
### code chunk number 40: semplot20
###################################################
semPaths(mediat.out.0)


###################################################
### code chunk number 41: sem120
###################################################
mediat.mod.1 <- '
posAffect ~ intMotiv + agency
negAffect ~ extMotiv
intMotiv + extMotiv ~ agency
intMotiv ~~ extMotiv
'
mediat.out.1 <- sem(mediat.mod.1, data = dat)


###################################################
### code chunk number 42: semplot31
###################################################
semPaths(mediat.out.1)


###################################################
### code chunk number 43: sem125
###################################################
anova(mediat.out.0, mediat.out.1)


###################################################
### code chunk number 44: sem126
###################################################
summary(mediat.out.1, rsquare = TRUE, fit = TRUE)


###################################################
### code chunk number 45: semboot1
###################################################
Nboot <- 500
mediat.mod.1 <- '
posAffect ~ b1*intMotiv + agency
negAffect ~ b2*extMotiv
intMotiv ~ a1*agency
extMotiv ~ a2*agency
intMotiv ~~ extMotiv
## define mediation parameters (indirect effects)
ind1 := a1 * b1
ind2 := a2 * b2
'
mediat.out.1 <- sem(mediat.mod.1, data = dat,
                    se = "boot", bootstrap = Nboot)


###################################################
### code chunk number 46: semboot2
###################################################
parameterEstimates(mediat.out.1, boot.ci.type = "bca.simple")


###################################################
### code chunk number 47: cfa10
###################################################
cfa.mod <- '
## factor loadings
Agency =~ Agency1 + Agency2 + Agency3
Intrinsic =~ Intrin1 + Intrin2 + Intrin3
Extrinsic =~ Extrin1 + Extrin2 + Extrin3
Positive =~ PosAFF1 + PosAFF2 + PosAFF3
Negative =~ NegAFF1 + NegAFF2 + NegAFF3
'
cfa.out <- cfa(cfa.mod, data = dat, std.lv = TRUE)


###################################################
### code chunk number 48: cfa20
###################################################
summary(cfa.out, standardized = TRUE, fit = TRUE)


###################################################
### code chunk number 49: cfa30
###################################################
mediat.mod.2 <- '
## measurement model declares the latent constructs
Agency =~ Agency1 + Agency2 + Agency3
Intrinsic =~ Intrin1 + Intrin2 + Intrin3
Extrinsic =~ Extrin1 + Extrin2 + Extrin3
Positive =~ PosAFF1 + PosAFF2 + PosAFF3
Negative =~ NegAFF1 + NegAFF2 + NegAFF3
## structural model represents relationships
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
### code chunk number 50: cfa35
###################################################
mediat.out.2 <- sem(mediat.mod.2, data = dat,
                    std.lv = TRUE, se = "boot", bootstrap = Nboot)
summary(mediat.out.2, standardized = TRUE, fit = TRUE)


###################################################
### code chunk number 51: cfa40
###################################################
anova(cfa.out, mediat.out.2)


###################################################
### code chunk number 52: cfa50
###################################################
summary(mediat.out.2, standardized = TRUE)
parameterEstimates(mediat.out.1, standardized = TRUE, ci = FALSE)[which(parameterEstimates(mediat.out.1)[,"lhs"] %in% c("ind1", "ind2")), ]


###################################################
### code chunk number 53: semplot40
###################################################
semPaths(mediat.out.2)


###################################################
### code chunk number 54: cfa100
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
ind1 := a1 * b1
ind2 := a2 * b2
ind1 == ind2
'


###################################################
### code chunk number 55: cfa110
###################################################
mediat.out.3 <- sem(mediat.mod.3, data = dat,
                    std.lv = TRUE, se = "boot", bootstrap = Nboot)
summary(mediat.out.3, standardized = TRUE, fit = TRUE)


###################################################
### code chunk number 56: cfa111
###################################################
anova(mediat.out.3, mediat.out.2)


###################################################
### code chunk number 57: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 58: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


