### R code from vignette source 'multilevelSEM.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: multilevelSEM.Rnw:34-35
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
options(width=100, prompt = " ", continue = "  ")
options(useFancyQuotes = FALSE)
set.seed(12345)
par.orig <- par(no.readonly = TRUE) 
pjmar <- c(4.1, 4.1, 1.5, 2.1)
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12, xpd=F)))
pdf.options(onefile=F,family="Times",pointsize=12)
if(!file.exists("theme") && file.exists("../../../../template/theme")) file.symlink("../../../../template/theme", "theme")


###################################################
### code chunk number 4: dat10
###################################################
pdf.options(onefile=FALSE, family="Times", paper="special", height=4, width=6, pointsize=10)


###################################################
### code chunk number 5: dat20
###################################################
## Setting working environment
ddir <- "../../data"

## Loading packages
library(lavaan) ## for SEM
library(lme4) ## for MLM
library(lmerTest) ## for MLM p values

## Reading in the hbsc example data set
hbsc <- readRDS(file.path(ddir, "hbsc.rds"))

## Calculating a mean for gotB ullied
hbsc$gotBu_ave <- rowMeans(hbsc[ , c("gotBu1_i", "gotBu2_i", "gotBu3_i", "gotBu4_i", "gotBu5_i", "gotBu6_i", "gotBu7_i", "gotBu8_i", "gotBu9_i")], na.rm = FALSE)

## A null model to test nesting structure
mlm.0 <- lmer(gotBu_ave ~ 1 + (1|schl_id), data = hbsc, REML = FALSE)

## Requesting predicted values
x <- data.frame(ranef(mlm.0))

## Selecting the lower and the upper data from hbsc
dat.1 <- data.frame(x[c(x$condval < -0.1 | x$condval > 0.15), ])

## Creating an index
index <- dat.1$grp

## Applying the index to subset hbsc
## hbsc.2 will be used for demonstration here
hbsc.2 <- hbsc[hbsc$schl_id %in% index, ]

## Summary for hbsc.2
table(hbsc.2$schl_id)


###################################################
### code chunk number 6: dat30
###################################################
mlm.01 <- lmer(gotBu_ave ~ 1 + Age + (1|schl_id), data = hbsc.2, REML = FALSE)
summary(mlm.01)


###################################################
### code chunk number 7: dat40
###################################################
## Specifying the model structure
sem.gotBully <- '
gotBully =~ NA*gotBu1_i + gotBu2_i + gotBu3_i + gotBu4_i + gotBu5_i + gotBu6_i + gotBu7_i + gotBu8_i + gotBu9_i
                
gotBully ~~ 1*gotBully
gotBully ~ Age '

## Fitting the model
## Listwise deletion is used to compare the results with MLM
sem.gotBully.fit <- sem(model = sem.gotBully, data = hbsc.2, mimic = "Mplus", missing = "listwise", meanstructure = TRUE)

## Requesting an estimation summary
summary(sem.gotBully.fit, fit.measures = TRUE, standardized = TRUE) 


###################################################
### code chunk number 8: dat50
###################################################
msem.gotBully.01 <- '
Level: 1
gotBully.w =~ gotBu1_i + gotBu2_i + gotBu3_i + gotBu4_i + gotBu5_i + gotBu6_i + gotBu7_i + gotBu8_i + gotBu9_i

Level: 2
gotBu1_i ~~ 0*gotBu1_i
gotBu2_i ~~ 0*gotBu2_i
gotBu3_i ~~ 0*gotBu3_i
gotBu4_i ~~ 0*gotBu4_i
gotBu5_i ~~ 0*gotBu5_i
gotBu6_i ~~ 0*gotBu6_i
gotBu7_i ~~ 0*gotBu7_i
gotBu8_i ~~ 0*gotBu8_i
gotBu9_i ~~ 0*gotBu9_i '

## Fitting the model
msem.gotBully.01.fit <- 
sem(model = msem.gotBully.01, data = hbsc.2, mimic = "Mplus", std.lv = TRUE, missing = "listwise", cluster = "schl_id")
## Requesting an estimation summary 
summary(msem.gotBully.01.fit, fit.measures = TRUE, standardized = TRUE)


###################################################
### code chunk number 9: dat60
###################################################
msem.gotBully.02 <- '

Level: 1
gotBully.w =~ gotBu1_i + gotBu2_i + gotBu3_i + gotBu4_i + gotBu5_i + gotBu6_i + gotBu7_i + gotBu8_i + gotBu9_i

Level: 2
gotBu1_i ~~ gotBu1_i
gotBu2_i ~~ gotBu2_i
gotBu3_i ~~ gotBu3_i
gotBu4_i ~~ gotBu4_i
gotBu5_i ~~ gotBu5_i
gotBu6_i ~~ gotBu6_i
gotBu7_i ~~ gotBu7_i
gotBu8_i ~~ gotBu8_i
gotBu9_i ~~ gotBu9_i '

## Fitting the model
msem.gotBully.02.fit <- 
sem(model = msem.gotBully.02, data = hbsc.2, mimic = "Mplus", std.lv = TRUE, missing = "listwise", cluster = "schl_id")
## Requesting an estimation summary 
summary(msem.gotBully.02.fit, fit.measures = TRUE, standardized = TRUE)


###################################################
### code chunk number 10: dat70
###################################################
msem.gotBully.03 <- '
Level: 1
gotBully.w =~ gotBu1_i + gotBu2_i + gotBu3_i + gotBu4_i + gotBu5_i + gotBu6_i + gotBu7_i + gotBu8_i + gotBu9_i

Level: 2
gotBu1_i ~~ gotBu1_i + gotBu2_i + gotBu3_i + gotBu4_i + gotBu5_i + gotBu6_i + gotBu7_i + gotBu8_i + gotBu9_i
gotBu2_i ~~ gotBu2_i + gotBu3_i + gotBu4_i + gotBu5_i + gotBu6_i + gotBu7_i + gotBu8_i + gotBu9_i
gotBu3_i ~~ gotBu3_i + gotBu4_i + gotBu5_i + gotBu6_i + gotBu7_i + gotBu8_i + gotBu9_i
gotBu4_i ~~ gotBu4_i + gotBu5_i + gotBu6_i + gotBu7_i + gotBu8_i + gotBu9_i
gotBu5_i ~~ gotBu5_i + gotBu6_i + gotBu7_i + gotBu8_i + gotBu9_i
gotBu6_i ~~ gotBu6_i + gotBu7_i + gotBu8_i + gotBu9_i
gotBu7_i ~~ gotBu7_i + gotBu8_i + gotBu9_i
gotBu8_i ~~ gotBu8_i + gotBu9_i
gotBu9_i ~~ gotBu9_i '

## Fitting the model
msem.gotBully.02.fit <- 
sem(model = msem.gotBully.02, data = hbsc.2, mimic = "Mplus", std.lv = TRUE, missing = "listwise", cluster = "schl_id")
## Requesting an estimation summary 
summary(msem.gotBully.02.fit, fit.measures = TRUE, standardized = TRUE)


###################################################
### code chunk number 11: dat80
###################################################
msem.gotBully.04 <- '
Level: 1
gotBully.w =~ gotBu1_i + gotBu2_i + gotBu3_i + gotBu4_i + gotBu5_i + gotBu7_i

Level: 2
gotBully.b =~ gotBu1_i + gotBu2_i + gotBu3_i + gotBu4_i + gotBu5_i + gotBu7_i '

## Fitting the model
msem.gotBully.04.fit <- 
sem(model = msem.gotBully.04, data = hbsc.2, mimic = "Mplus", std.lv = TRUE, missing = "listwise", cluster = "schl_id")
## Requesting an estimation summary 
summary(msem.gotBully.04.fit, fit.measures = TRUE, standardized = TRUE)


###################################################
### code chunk number 12: dat90
###################################################
msem.gotBully.05 <- '

Level: 1
gotBully.w =~ gotBu1_i + gotBu2_i + gotBu3_i + gotBu4_i + gotBu5_i + gotBu7_i
gotBully.w ~ Age

Level: 2
gotBully.b =~ gotBu1_i + gotBu2_i + gotBu3_i + gotBu4_i + gotBu5_i + gotBu7_i
gotBully.b ~ Age'

## Fitting the model
msem.gotBully.05.fit <- 
sem(model = msem.gotBully.05, data = hbsc.2, mimic = "Mplus", std.lv = TRUE, missing = "listwise", cluster = "schl_id")
## Requesting an estimation summary 
summary(msem.gotBully.05.fit, fit.measures = TRUE, standardized = TRUE)


###################################################
### code chunk number 13: dat100
###################################################
msem.gotBully.06 <- '

Level: 1
gotBully.w =~ gotBu1_i + gotBu2_i + gotBu3_i + gotBu4_i + gotBu5_i + gotBu7_i
gotBully.w ~ Age + Gender

Level: 2
gotBully.b =~ gotBu1_i + gotBu2_i + gotBu3_i + gotBu4_i + gotBu5_i + gotBu7_i
gotBully.b ~ Age + Gender '

## Fitting the model
msem.gotBully.06.fit <- 
sem(model = msem.gotBully.06, data = hbsc.2, mimic = "Mplus", std.lv = TRUE, missing = "listwise", cluster = "schl_id")
## Requesting an estimation summary 
summary(msem.gotBully.06.fit, fit.measures = TRUE, standardized = TRUE)


###################################################
### code chunk number 14: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 15: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


