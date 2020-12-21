### R code from vignette source 'sem-formative.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: sem-formative.Rnw:26-27
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Roptions
###################################################
tdir <- "tmpout"
if(!dir.exists(tdir)) dir.create(tdir, showWarnings=FALSE)
library(stationery)
opts.orig <- options()
options(width=75, prompt = " ", continue = "  ")
options(useFancyQuotes = FALSE)
set.seed(12345)
par.orig <- par(no.readonly=TRUE) 
pjmar <- c(4.1, 4.1, 1.5, 2.1)
par(mar=pjmar, ps=11)
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12, xpd=F)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 3: texcopy
###################################################
logos <- c("logo.pdf", "logomini.pdf")
## This will retrieve logo files from a designated package:
getFiles(logos, pkg = "crmda", overwrite = TRUE)
## If you do not have a file after that, 
## the following will manufacture a blank images for placeholders
if(!file.exists("theme/logo.pdf")){
  blankPDF(file = "theme/logo.pdf", height=1, width=2, messg = "")
}
if(!file.exists("theme/logomini.pdf")){
  blankPDF(file = "theme/logomini.pdf", height=1, width=11, messg = "")
}


###################################################
### code chunk number 4: formative1.0
###################################################
## Setting working environment
ddir <- "../data"
odir <- "output"
list.files(ddir)

## Loading the lavaan pakcage for sem analysis
library(lavaan)


###################################################
### code chunk number 5: formative2.0
###################################################
## Reading in the HBSC data subset
hbsc.complete <- readRDS(file.path(ddir, "hbsc.rds"))
hbsc <- hbsc.complete[hbsc.complete$Grade %in% c("6", "7"), ]
names(hbsc)


###################################################
### code chunk number 6: formative3.0
###################################################
## A structural model with a formative composite in lavaan
## Create the model object
m1 <- ' 
  alcohol <~ 1*alc1_i + alc2_i + alc3_i +
               alc4_i + alc5_i

  alcohol ~~ 0*alcohol
  
  alc1_i ~~ alc2_i + alc3_i + alc4_i + alc5_i
  alc2_i ~~ alc3_i + alc4_i + alc5_i
  alc3_i ~~ alc4_i + alc5_i
  alc4_i ~~ alc5_i

  buOth1_i ~ alcohol '

## Use the sem() function to estimate the model
fit1 <- sem(model = m1, data = hbsc, meanstructure = TRUE)

## Request a summary of the results
summary(fit1, fit.measures = TRUE, standardized = TRUE)


###################################################
### code chunk number 7: formative60
###################################################
head(PoliticalDemocracy, 10)


###################################################
### code chunk number 8: formative70
###################################################
model.reflective <- '    
 ## latent variables
    ind60 =~ x1 + x2 + x3
    dem60 =~ y1 + y2 + y3 + y4
    dem65 =~ y5 + y6 + y7 + y8
 ## regressions
    dem60 ~ ind60
    dem65 ~ ind60 + dem60
 ## residual covariances
    y1 ~~ y5
    y2 ~~ y4 + y6
    y3 ~~ y7
    y4 ~~ y8
    y6 ~~ y8 ' 

fit.reflective <- sem(model.reflective, data=PoliticalDemocracy, meanstructure = TRUE)

summary(fit.reflective, fit.measures = TRUE, standardized = TRUE)


###################################################
### code chunk number 9: formative80
###################################################
model.formative <- '
## The formative indicators surveyed in 1960
## x1 The gross national product (GNP) per capita
## x2 The inanimate energy consumption per capita
## x3 The percentage of the labor force in industry 
    ind60 <~ 1*x1 + x2 + x3
    ind60 ~~ 0*ind60

    x1 ~~ x2 + x3
    x2 ~~ x3
  
## latent variables
    dem60 =~ y1 + y2 + y3 + y4
    dem65 =~ y5 + y6 + y7 + y8
## regressions
    dem60 ~ ind60
    dem65 ~ ind60 + dem60
## residual covariances
    y1 ~~ y5
    y2 ~~ y4 + y6
    y3 ~~ y7
    y4 ~~ y8
    y6 ~~ y8 '

fit.formative <- sem(model.formative, data=PoliticalDemocracy, meanstructure = TRUE)

summary(fit.formative, fit.measures = TRUE, standardized = TRUE)


###################################################
### code chunk number 10: formative90
###################################################
m3 <- ' 
## Being bullied at school
  bullied <~ 1*gotBu1_i + gotBu2_i + gotBu3_i + 
               gotBu4_i + gotBu5_i + gotBu6_i +
               gotBu7_i + gotBu8_i + gotBu9_i
  
  bullied ~~ 0*bullied

  gotBu1_i ~~ gotBu2_i + gotBu3_i + gotBu4_i + 
              gotBu5_i + gotBu6_i + gotBu7_i + 
              gotBu8_i + gotBu9_i

  gotBu2_i ~~ gotBu3_i + gotBu4_i + gotBu5_i + 
              gotBu6_i + gotBu7_i + gotBu8_i + 
              gotBu9_i

  gotBu3_i ~~ gotBu4_i + gotBu5_i + gotBu6_i + 
              gotBu7_i + gotBu8_i + gotBu9_i
  
  gotBu4_i ~~ gotBu5_i + gotBu6_i + gotBu7_i + 
              gotBu8_i + gotBu9_i

  gotBu5_i ~~ gotBu6_i + gotBu7_i + gotBu8_i + 
              gotBu9_i

  gotBu6_i ~~ gotBu7_i + gotBu8_i + gotBu9_i

  gotBu7_i ~~ gotBu8_i + gotBu9_i

  gotBu8_i ~~ gotBu9_i

## Depression latent factor
  depression =~ NA*depre1_o + depre2_o + depre3_o + 
                   depre4_o + depre5_o + depre6_o
  depression ~~ 1*depression

## Regression
  depression ~ bullied '

## Use the sem() function to estimate the model
fit3 <- sem(model = m3, data = hbsc, meanstructure = TRUE)

## Request a summary of the results
summary(fit3, fit.measures = TRUE, standardized = TRUE)


###################################################
### code chunk number 11: formative40
###################################################
## Loading the CCA package for conanical correlation analysis
library(CCA)

## Subset complete cases
dat.cc.1 <- 
hbsc[complete.cases(hbsc[c("alc1_i", "alc2_i", "alc3_i", "alc4_i", "alc5_i", "buOth1_i")]), ]

## Create x and y objects for cc()
x.1 <- 
dat.cc.1[c("alc1_i", "alc2_i", "alc3_i", "alc4_i", "alc5_i")]
y.1 <- 
dat.cc.1["buOth1_i"]

## Supply x and y to the cc() function
## and save the canonical correlation estimates 
## to an output object
out.cc.1 <- cc(x.1, y.1)
## Request the loading estimates
## of the alchohol variables
## These estimates are comparable to lavaan (Std.lv) 
## and Mplus (STD Standardization) estimates
abs(round(out.cc.1$xcoef[ , 1], 3))

## Request the canonical correlation estimate
## This estimate is comparable to lavaan (Std.all)
## and Mplus (STDYX and STDY) estimates
abs(round(out.cc.1$scores$corr.Y.xscores[ , 1], 3))


###################################################
### code chunk number 12: formative51
###################################################
## Subset complete cases
dat.cc.2 <- 
hbsc[complete.cases(hbsc[c("alc1_i", "alc2_i", "alc3_i", "alc4_i", "alc5_i", "buOth1_i", "buOth2_i", "buOth3_i", "buOth4_i", "buOth5_i", "buOth6_i", "buOth7_i", "buOth8_i", "buOth9_i")]), ]

## Create x and y objects for cc()
x.2 <- 
dat.cc.2[c("alc1_i", "alc2_i", "alc3_i", "alc4_i", "alc5_i")]
y.2 <- 
dat.cc.2[c("buOth1_i", "buOth2_i", "buOth3_i", "buOth4_i", "buOth5_i", "buOth6_i", "buOth7_i", "buOth8_i", "buOth9_i")]

## Supply x and y to the cc() function
out.cc.2 <- cc(x.2, y.2)
abs(round(out.cc.2$xcoef[ , 1], 3))
abs(round(out.cc.2$scores$corr.Y.xscores[ , 1], 3))


###################################################
### code chunk number 13: formative52
###################################################
m3 <- 
' alcohol <~ 1*alc1_i + alc2_i + alc3_i +
               alc4_i + alc5_i

  alcohol ~~ 0*alcohol
  
  alc1_i ~~ alc2_i + alc3_i + alc4_i + alc5_i
  alc2_i ~~ alc3_i + alc4_i + alc5_i
  alc3_i ~~ alc4_i + alc5_i
  alc4_i ~~ alc5_i

  buOth1_i ~ alcohol
  buOth2_i ~ alcohol
  buOth3_i ~ alcohol
  buOth4_i ~ alcohol
  buOth5_i ~ alcohol
  buOth6_i ~ alcohol
  buOth7_i ~ alcohol
  buOth8_i ~ alcohol
  buOth9_i ~ alcohol
'

## Use the sem() function to estimate the model
fit3 <- sem(model = m3, data = hbsc, meanstructure = TRUE)

## Request a summary of the results
summary(fit3, fit.measures = TRUE, standardized = TRUE)


###################################################
### code chunk number 14: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 15: RoptionsRestore
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
par(par.orig)


