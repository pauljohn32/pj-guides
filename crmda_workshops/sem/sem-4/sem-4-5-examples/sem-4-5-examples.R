### R code from vignette source 'sem-4-5-examples-uniquebackupstring.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: sem-4-5-examples-uniquebackupstring.Rnw:27-28
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: createdirs
###################################################
tdir <- "tmpout"
if(!dir.exists(tdir)) dir.create(tdir, showWarnings=FALSE)
wdir <- "workingdata"
if(!dir.exists(wdir)) dir.create(wdir, showWarnings=FALSE)
odir <- "output"
if(!dir.exists(odir)) dir.create(odir, showWarnings=FALSE)


###################################################
### code chunk number 4: dat10
###################################################
## Loading pakcages
library(lavaan)


###################################################
### code chunk number 5: dat20
###################################################
## The "data" folder contains the hbsc data
ddir <- "data"
hbsc.complete <- readRDS(file.path(ddir, "hbsc.rds"))
## hbsc contains grades 6 and 7 responses
hbsc <- hbsc.complete[hbsc.complete$Grade %in% c("6", "7"), ]


###################################################
### code chunk number 6: dat30
###################################################
## The dimension of the data set "hbsc"
dim(hbsc)
## Varibles in our demonstration data "hbsc"
names(hbsc)


###################################################
### code chunk number 7: dat40
###################################################
## Creating a name vector for the depre items 
varName_depre_i <- c("depre1_i","depre2_i", "depre3_i", "depre4_i", "depre5_i", "depre6_i")
## Requesting summary information for the Depression items
summary(hbsc[ , varName_depre_i])
## Creating a demonstration data set (depre_i_miss) with increased missings
depre_i <- (hbsc[ , varName_depre_i])
depre_i_miss <- as.data.frame(lapply(depre_i, function(cc) cc[ sample(c(TRUE, NA), prob = c(0.90, 0.10), size = length(cc), replace = TRUE) ]))
summary(depre_i_miss)


###################################################
### code chunk number 8: dat50
###################################################
## Specifying the model-structure object
## One latent factor with six indicators
cfa.01.v.01 <- '
depress =~ NA*depre1_i + depre2_i + depre3_i +
              depre4_i + depre5_i + depre6_i
depress ~~ 1*depress '


###################################################
### code chunk number 9: dat60
###################################################
## Estimating cfa.01.v01 
## with listwise deletion
cfa.01.v.01.fit.listwise <- 
cfa(model = cfa.01.v.01, data = depre_i_miss,
    mimic = "Mplus", estimator = "ML",
    missing = "listwise", meanstructure = TRUE)


###################################################
### code chunk number 10: dat70
###################################################
## Requesting an estimation summary
## Please pay attention to
## The used and the total observations and
## The Minimum Function Test Statistics
summary(cfa.01.v.01.fit.listwise, fit.measures = TRUE,
        standardized = TRUE)


###################################################
### code chunk number 11: dat80
###################################################
## Estimating cfa.01.v01 
## with pairwise deletion
cfa.01.v.01.fit.pairwise <- 
cfa(model = cfa.01.v.01, data = depre_i_miss,
    mimic = "Mplus", estimator = "ML",
    missing = "pairwise", meanstructure = TRUE)


###################################################
### code chunk number 12: dat90
###################################################
## Requesting an estimation summary
## Please pay attention to
## The used and the total observations and
## The Minimum Function Test Statistics
summary(cfa.01.v.01.fit.pairwise, fit.measures = TRUE,
        standardized = TRUE)


###################################################
### code chunk number 13: cfa400tab (eval = FALSE)
###################################################
## library(semTable)
## labs <- c("depress" = "Depression")
## cfa.ld.pw <- 
## semTable(list("listwise" = cfa.01.v.01.fit.listwise, "pairwise" = cfa.01.v.01.fit.pairwise), paramSets = c("loadings", "intercepts", "residualvariances", "fits"), columns = c("estsestars"), file = file.path(tdir, "cfa.ld.pw"), type = "tex", longtable = TRUE, varLabels = labs)


###################################################
### code chunk number 14: sem-4-5-examples-uniquebackupstring.Rnw:369-370
###################################################
library(semTable)
labs <- c("depress" = "Depression")
cfa.ld.pw <- 
semTable(list("listwise" = cfa.01.v.01.fit.listwise, "pairwise" = cfa.01.v.01.fit.pairwise), paramSets = c("loadings", "intercepts", "residualvariances", "fits"), columns = c("estsestars"), file = file.path(tdir, "cfa.ld.pw"), type = "tex", longtable = TRUE, varLabels = labs)


###################################################
### code chunk number 15: dat100
###################################################
## Estimating cfa.01.v01 
## with full information maximum likelihood
cfa.01.v.01.fit.fiml <- 
cfa(model = cfa.01.v.01, data = depre_i_miss,
    mimic = "Mplus", estimator = "ML",
    missing = "ml", meanstructure = TRUE)


###################################################
### code chunk number 16: dat110
###################################################
## Requesting an estimation summary
## Please pay attention to
## The used and the total observations and
## The Minimum Function Test Statistics
summary(cfa.01.v.01.fit.fiml, fit.measures = TRUE,
        standardized = TRUE)


###################################################
### code chunk number 17: cfa500tab (eval = FALSE)
###################################################
## library(semTable)
## labs <- c("depress" = "Depression")
## cfa0101tab <- 
## semTable(list("listwise" = cfa.01.v.01.fit.listwise, "pairwise" = cfa.01.v.01.fit.pairwise, "fiml" = cfa.01.v.01.fit.fiml), paramSets = c("loadings", "intercepts", "residualvariances", "fits"), columns = c("estsestars"), file = file.path(tdir, "cfa0101a"), type = "tex", longtable = TRUE, varLabels = labs)


###################################################
### code chunk number 18: sem-4-5-examples-uniquebackupstring.Rnw:414-415
###################################################
library(semTable)
labs <- c("depress" = "Depression")
cfa0101tab <- 
semTable(list("listwise" = cfa.01.v.01.fit.listwise, "pairwise" = cfa.01.v.01.fit.pairwise, "fiml" = cfa.01.v.01.fit.fiml), paramSets = c("loadings", "intercepts", "residualvariances", "fits"), columns = c("estsestars"), file = file.path(tdir, "cfa0101a"), type = "tex", longtable = TRUE, varLabels = labs)


###################################################
### code chunk number 19: dat120
###################################################
### Specifying the model-structure object 
cfa.01.v.02 <- '
depress =~ NA*depre1_i + depre2_i + depre3_i +
              depre4_i + depre5_i + depre6_i
depress ~~ 1*depress '


###################################################
### code chunk number 20: dat130
###################################################
## Estimating cfa.01.v.02
## cfa.01.v.02.fit.fiml <- 
## cfa(model = cfa.01.v.02, data = depre_i_miss,
##     mimic = "Mplus", estimator = "WLSMV",
##     missing = "ml", meanstructure = TRUE,
##     ordered = c("depre1_i", "depre2_i",
##                 "depre3_i", "depre4_i",
##                 "depre5_i", "depre6_i"))


###################################################
### code chunk number 21: dat140
###################################################
## Estimating cfa.01.v.02
## With pairwise deletion
cfa.01.v.02.fit.pairwise <- 
cfa(model = cfa.01.v.02, data = depre_i_miss,
    mimic = "Mplus", estimator = "WLSMV",
    missing = "pairwise", meanstructure = TRUE,
    ordered = c("depre1_i", "depre2_i",
                "depre3_i", "depre4_i",                 
                "depre5_i", "depre6_i"))
summary(cfa.01.v.02.fit.pairwise, fit.measures = TRUE,
        standardized = TRUE)


###################################################
### code chunk number 22: cfa600tab (eval = FALSE)
###################################################
## ## 20190602: bug appears in output below, don't know why!
## ## 20190606: bug solved
## labs <- c("depress" = "Depression")
## cfapairwise <- 
## semTable(list("Pairwise CFA ml" = cfa.01.v.01.fit.pairwise, "Pairwise CFA wlsmv" = cfa.01.v.02.fit.pairwise), paramSets = c("loadings", "thresholds", "intercepts", "residualvariances", "fits"), columns = c("estsestars"), file = file.path(tdir, "cfa0101b"), type = "tex", longtable = TRUE, varLabels = labs)


###################################################
### code chunk number 23: cfa600q
###################################################
## 20190602: bug appears in output below, don't know why!
## 20190606: bug solved
labs <- c("depress" = "Depression")
cfapairwise <- 
semTable(list("Pairwise CFA ml" = cfa.01.v.01.fit.pairwise, "Pairwise CFA wlsmv" = cfa.01.v.02.fit.pairwise), paramSets = c("loadings", "thresholds", "intercepts", "residualvariances", "fits"), columns = c("estsestars"), file = file.path(tdir, "cfa0101b"), type = "tex", longtable = TRUE, varLabels = labs)


###################################################
### code chunk number 24: mice10 (eval = FALSE)
###################################################
## library(mice)
## ## I was careless, did not look at hbsc carefully first
## set5 <- mice(hbsc, m = 5)
## ## To see what you get, do this
## par(ask = TRUE)
## plot(set5)


###################################################
### code chunk number 25: mice20 (eval = FALSE)
###################################################
## set15 <- mice.mids(set5, maxit = 10)
## ## That was not adequate keep going
## set25 <- mice.mids(set15, maxit = 10)
## ## Inadequate, keep going
## set30 <- mice.mids(set25, maxit = 5)
## ## Expectations crashed that was not good
## set45 <- mice.mids(set45, maxit = 25)
## ## Stop there, I had enough
## saveRDS(set45, file.path(wdir, "mice-45.rds"))


###################################################
### code chunk number 26: mice100
###################################################
wdir <- "workingdata"
list.files(wdir)

library(mice)
miceimputed <- readRDS(file.path(wdir, "mice-45.rds"))
if(interactive()){
   par(ask=TRUE)
   plot(miceimputed)
}


###################################################
### code chunk number 27: sem-4-5-examples-uniquebackupstring.Rnw:613-627
###################################################
sem.01.int <- '
## the measurement model
gotBully =~ NA*gotBu1_i + gotBu2_i + gotBu3_i
             + gotBu4_i + gotBu5_i + gotBu6_i
             + gotBu7_i + gotBu8_i + gotBu9_i
gotBully ~~ 1*gotBully

alcohol =~ NA*alc1_i + alc2_i + alc3_i
            + alc4_i + alc5_i
alcohol ~~ 1*alcohol

# regress 
alcohol ~ gotBully
'


###################################################
### code chunk number 28: mice110 (eval = FALSE)
###################################################
## fits.mice <- with(data = miceimputed, exp = 
##   sem(model = sem.01.int, mimic = "Mplus",
##       estimator = "ML"))


###################################################
### code chunk number 29: mice150
###################################################
imps <- list()
for(i in 1:5){
    imps[[i]] <- complete(miceimputed, action = i)
}


###################################################
### code chunk number 30: mice160
###################################################
summary(imps[[1]])


###################################################
### code chunk number 31: mice200
###################################################
ordvars <- grep("^.*_o$", colnames(imps[[1]]), value = TRUE)
## Re-create the integer coded variables
for(i in seq_along(imps)){
    oneds <- imps[[i]]
    for(j in ordvars){
        newvar <- as.integer(oneds[ , j])
        newname <- gsub("_o$", "_i", j)
        oneds[ , newname] <- as.integer(oneds[ , j])
    }
    imps[[i]] <- oneds
}


###################################################
### code chunk number 32: mice300
###################################################
sem.01.int.fits <- list()
for(i in seq_along(imps)){
    sem.01.int.fits[[i]] <- sem(model = sem.01.int, mimic = "Mplus",
                      estimator = "ML", data = imps[[i]])
}


###################################################
### code chunk number 33: mice310
###################################################
library(mitools)
int.betas <- MIextract(sem.01.int.fits, fun = coef)
int.vars <- MIextract(sem.01.int.fits, fun = vcov)
int.fits.pooled <- summary(MIcombine(int.betas, int.vars))


###################################################
### code chunk number 34: mice320
###################################################
int.fits.pooled


###################################################
### code chunk number 35: mice360
###################################################
sem.01.ord <- '
## the measurement model
gotBully =~ NA*gotBu1_o + gotBu2_o + gotBu3_o
             + gotBu4_o + gotBu5_o + gotBu6_o
             + gotBu7_o + gotBu8_o + gotBu9_o
gotBully ~~ 1*gotBully
alcohol =~ NA*alc1_o + alc2_o + alc3_o
            + alc4_o + alc5_o
alcohol ~~ 1*alcohol
# regress 
alcohol ~ gotBully
'
## Run on each imputed data set
sem.01.ord.fits <- list()
for(i in seq_along(imps)){
    sem.01.ord.fits[[i]] <- sem(model = sem.01.ord, mimic = "Mplus",
                      estimator = "DWLS", data = imps[[i]])
}



###################################################
### code chunk number 36: mice410
###################################################
ord.betas <- MIextract(sem.01.ord.fits, fun = coef)
ord.vars <- MIextract(sem.01.ord.fits, fun = vcov)
ord.fits.pooled <- summary(MIcombine(ord.betas, ord.vars))


###################################################
### code chunk number 37: mice420
###################################################
ord.fits.pooled


###################################################
### code chunk number 38: mice500
###################################################
sem.01.ord.ld <- sem(model = sem.01.ord, mimic = "Mplus",
                      estimator = "DWLS", data = hbsc, missing = "listwise")
sem.01.ord.pair <- sem(model = sem.01.ord, mimic = "Mplus",
                      estimator = "DWLS", data = hbsc, missing = "pairwise")


###################################################
### code chunk number 39: mice509
###################################################
table509 <- semTable(list("listwise" = sem.01.ord.ld, "pairwise" = sem.01.ord.pair),
             columns = c("estsestars","rsquare"), type = "tex", longtable=TRUE,
             file = file.path(odir, "semtable509"), print.results=FALSE)


###################################################
### code chunk number 40: mice510
###################################################
##cat(table509)


###################################################
### code chunk number 41: mice450
###################################################
summary(sem.01.ord.fits[[1]])
summary(sem.01.ord.fits[[4]])


###################################################
### code chunk number 42: amel100 (eval = FALSE)
###################################################
## library(Amelia)
## ## Drop the redundant integer versions of the variables
## dato <- hbsc[ , grep("^.*_i$", colnames(hbsc), invert = TRUE)]
## 
## ## Don't have good reason for emburn setting, but
## ## run was quitting so quickly I was not comfortable
## datoamelia <- amelia(dato, m = 5L, p2s=0,  idvars = "stud_id",
##                      ords = grep("^.*_o$", colnames(hbsc), value = TRUE),
##                      noms = c("Gender", "Grade"),
##                      emburn = c(100L, 10L))
## ## Extract the imputed complete data sets
## imps <- datoamelia$imputations
## ## Now re-create the integer coded variables
## ordvars <- grep("^.*_o$", colnames(imps[[1]]), value = TRUE)
## for(i in seq_along(imps)){
##     oneds <- imps[[i]]
##     for(j in ordvars){
##         newvar <- as.integer(oneds[ , j])
##         newname <- gsub("_o$", "_i", j)
##         oneds[ , newname] <- as.integer(oneds[ , j])
##     }
##     imps[[i]] <- oneds
## }
## saveRDS(imps, file.path(wdir, "amelia-imps.rds"))


###################################################
### code chunk number 43: amel110
###################################################
imps <- readRDS(file.path(wdir, "amelia-imps.rds"))


###################################################
### code chunk number 44: amel120
###################################################
## Run same model for each imputed data set
ord.amelia.fits <- list()
for (i in seq_along(imps)){
    ord.amelia.fits[[i]] <- sem(model = sem.01.ord, data = imps[[i]],
            mimic = "Mplus", estimator = "DWLS")
}


###################################################
### code chunk number 45: amel130
###################################################
ord.amelia.betas <- MIextract(ord.amelia.fits, fun = coef)
ord.amelia.vars <- MIextract(ord.amelia.fits, fun = vcov)
ord.amelia.fits.pooled <- summary(MIcombine(ord.amelia.betas, ord.amelia.vars))


###################################################
### code chunk number 46: amel510
###################################################
ord.amelia.betas <- MIextract(ord.amelia.fits, fun = coef)
ord.amelia.vars <- MIextract(ord.amelia.fits, fun = vcov)
ord.amelia.fits.pooled <- summary(MIcombine(ord.amelia.betas, ord.amelia.vars))


###################################################
### code chunk number 47: amel600
###################################################
summary(ord.amelia.fits[[1]])
summary(ord.amelia.fits[[4]])


###################################################
### code chunk number 48: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 49: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


