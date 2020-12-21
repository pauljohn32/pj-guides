ddir <- "../../../../data"
odir <- "output"

dat <- readRDS(file.path(ddir, "hbsc.rds"))
hbsc <- dat[dat$Grade %in% c("6", "7"), ]
summary(hbsc$Grade)


library(lavaan)
library(Amelia)

## Drop the redundant integer versions of the variables
dato <- hbsc[ , grep("^.*_i$", colnames(hbsc), invert = TRUE)]

## Running without specifying emburn returned almost immediately.
## Suspected it did not do the required work. So I 
## decided to force the burn-in, just to see what would happen.

datoamelia <- amelia(dato, m = 5L, p2s=0,  idvars = "stud_id",
                     ords = grep("^.*_o$", colnames(hbsc), value = TRUE),
                     noms = c("Gender", "Grade"),
                     emburn = c(100L, 10L))

## Extract the imputed complete data sets
imps <- datoamelia$imputations
## Now re-create the integer coded variables
ordvars <- grep("^.*_o$", colnames(imps[[1]]), value = TRUE)
for(i in seq_along(imps)){
    oneds <- imps[[i]]
    for(j in ordvars){
        newvar <- as.integer(oneds[ , j])
        newname <- gsub("_o$", "_i", j)
        oneds[ , newname] <- as.integer(oneds[ , j])
    }
    imps[[i]] <- oneds
}

summary(imps[[1]])




sem.01.v.01 <- '
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


sem.01.v.01.fiml <-  sem(model = sem.01.v.01, data = hbsc,
                 mimic = "Mplus", estimator = "ML")
summary(sem.01.v.01.fiml)

ggg <- model.frame(sem.01.v.01.fiml)

sem.01.v.01.ld <-  sem(model = sem.01.v.01, data = hbsc,
                       estimator = "ML", estimator = "ML",
                       missing = "listwise")
summary(sem.01.v.01.ld)

## ## I distrusted the totals there, so I manually created
## ## listwise-deleted data frame.
## hbsc2 <- na.omit(hbsc[ , c("gotBu1_i", "gotBu2_i", "gotBu3_i", "gotBu4_i",
##                    "gotBu5_i", "gotBu6_i", "gotBu7_i", "gotBu8_i",
##                    "gotBu9_i", "alc1_i", "alc2_i", "alc3_i", "alc4_i",
##                    "alc5_i")])
## sem.01.v.01.reallyld <-  sem(model = sem.01.v.01, data = hbsc2,
##                        estimator = "ML", estimator = "ML",
##                        missing = "listwise")
## summary(sem.01.v.01.reallyld)

## xxx <- semTable(list(sem.01.v.01.ld, sem.01.v.01.reallyld), file = "xxx", type = "tex")
## testtable("xxx", dir = ".")


## Run same model for each imputed data set
fits <- list()
for (i in seq_along(imps)){
    fits[[i]] <- sem(model = sem.01.v.01, data = imps[[i]],
            mimic = "Mplus", estimator = "ML")
}

lapply(fits, coef)

library(mitools)
betas <- MIextract(fits, fun = coef)
vars <- MIextract(fits, fun = vcov)
fits.pooled <- summary(MIcombine(betas, vars))





##fits.pooled$lhs <-  gsub("(\\w*)[=~].*", "\\1",   rownames(fits.pooled), perl = TRUE)
##fits.pooled$rhs <-  gsub("\\w*[=~]*(.*)", "\\1",   rownames(fits.pooled), perl = TRUE)

## Alternative way to grab summary table
library(mix)
se.glm <- MIextract(fits, fun = function(x){sqrt(diag(vcov(x)))}) 
fits.pooled2 <- as.data.frame(mi.inference(betas, se.glm))
options(width=120)
fits.pooled2




sem.02.v.01 <- '
## the measurement model
gotBully =~ NA*gotBu1_i + gotBu2_i + gotBu3_i
             + gotBu4_i + gotBu5_i + gotBu6_i 
             + gotBu7_i + gotBu8_i + gotBu9_i
gotBully ~~ 1*gotBully

depress =~ NA*depre1_i + depre2_i + depre3_i
            + depre4_i + depre5_i + depre6_i
depress ~~ 1*depress

alcohol =~ NA*alc1_i + alc2_i + alc3_i
            + alc4_i + alc5_i
alcohol ~~ 1*alcohol

## the structural model

## direct effect (the c path)
alcohol ~ c*gotBully

## mediator paths (the a and b path)
depress ~ a*gotBully # the a path - IV predicting ME
alcohol ~ b*depress  # the b path - ME predicting DV

## indirect effect (a*b)
## := operator defines new parameters
ab := a*b

## total effect
total := c + (a*b)
'


sem.02.v.02 <- '
## the measurement model

gotBully =~ NA*gotBu1_o + gotBu2_o + gotBu3_o
             + gotBu4_o + gotBu5_o + gotBu6_o 
             + gotBu7_o + gotBu8_o + gotBu9_o
gotBully ~~ 1*gotBully

depress =~ NA*depre1_o + depre2_o + depre3_o
            + depre4_o + depre5_o + depre6_o
depress ~~ 1*depress

alcohol =~ NA*alc1_o + alc2_o + alc3_o
            + alc4_o + alc5_o
alcohol ~~ 1*alcohol

## the structural model

## direct effect (the c path)
alcohol ~ c*gotBully

## mediator paths (the a and b path)
depress ~ a*gotBully # the a path - IV predicting ME
alcohol ~ b*depress  # the b path - ME predicting DV

## indirect effect (a*b)
## := operator defines new parameters
ab := a*b

## total effect
total := c + (a*b)
'


sem.02.ord.fit <-
  sem(model = sem.02.v.02, data = dato, mimic = "Mplus",
      estimator = "DWLS", verbose = TRUE, missing = "listwise", verbose = TRUE)
summary(sem.02.ord.fit)

sem.02.ord.test <-
  sem(model = sem.02.v.02, data = dato, mimic = "Mplus")
summary(sem.02.ord.test)



datoamelia <- amelia(dato, m = 20L, p2s=0,  idvars = "stud_id",
                     ords = grep("^.*_o$", colnames(dat), value = TRUE),
                     noms = c("Gender", "Grade"),
                     emburn = c(50L, 0))
imps <- datoamelia$imputations


fits <- list()
for (i in seq_along(imps)){
    fits[[i]] <- sem(model = sem.02.v.02, data = hbsc, mimic = "Mplus",
      estimator = "DWLS", verbose = TRUE)
}

## Shows trouble in the alcohol data
lavInspect(fits[[3]], "zero.cell.tables")

library(mitools)
betas <- MIextract(fits, fun = coef)
vars <- MIextract(fits, fun = vcov)
fits.pooled <- summary(MIcombine(betas, vars))





fits.pooled$lhs <-  gsub("(\\w*)[=~].*", "\\1",   rownames(fits.pooled), perl = TRUE)
fits.pooled$rhs <-  gsub("\\w*[=~]*(.*)", "\\1",   rownames(fits.pooled), perl = TRUE)

## Alternative way to grab summary table
library(mix)
se.glm <- MIextract(fits, fun = function(x){sqrt(diag(vcov(x)))}) 
fits.pooled2 <- as.data.frame(mi.inference(betas, se.glm))
options(width=120)
fits.pooled2



