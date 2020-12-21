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

sem.01.v.01.fit <-
  sem(model = sem.01.v.01, data = hbsc,
      mimic = "Mplus", estimator = "ML")


sem.01.v.01.fit <-
  sem(model = sem.01.v.01, data = hbsc,
      mimic = "Mplus", estimator = "ML", missing = "listwise")


ddir <- "../../data"
odir <- "output"
dat <- readRDS(file.path(ddir, "hbsc.rds"))
hbsc <- dat[dat$Grade %in% c("6", "7"), ]

library(mice)

par(ask = TRUE)
mice(hbsc, m = 5) -> gg
saveRDS(gg, "m5.rds")


hh <- mice.mids(gg, maxit = 10)
saveRDS(hh, "m5plus10.rds")

ii <- mice.mids(hh, maxit = 10)
saveRDS(ii, "m15plus10.rds")

jj <- mice.mids(ii, maxit = 5)
saveRDS(jj, "m25plus5.rds")

plot(jj)

kk <- mice.mids(jj, maxit = 15)
saveRDS(kk, "m30plus15.rds")
plot(kk)




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


fits.mice <- with(data = kk, exp = 
  sem(model = sem.02.v.02, data = hbsc, mimic = "Mplus",
      estimator = "DWLS", se = "bootstrap", verbose = TRUE,
      bootstrap = 5))

## estimated models are in a list, fits[[4]]
fits <- fits.mice[[4]]

library(mitools)
betas <- MIextract(fits, fun = coef)
vars <- MIextract(fits, fun = vcov)
fits.pooled <- summary(MIcombine(betas, vars))

imps <- list()
for(i in 1:5){
    imps[[i]] <- complete(kk, action = i)
}
lapply(imps, summary)



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



wdir <- "workingdata"
list.files(wdir)

library(mice)
library(lavaan)
miceimputed <- readRDS(file.path(wdir, "mice-45.rds"))

fits.mice <- with(data = miceimputed, exp = 
  sem(model = sem.01.v.01, mimic = "Mplus",
      estimator = "ML")
)
summary(fits.mice)


summary(miceimputed)
imps <- list()
for(i in 1:5){
    imps[[i]] <- complete(miceimputed, action = i)
}
lapply(imps, summary)


reslt <- list()
for(i in seq_along(imps)){
    reslt[[i]] <- sem(model = sem.01.v.01, mimic = "Mplus",
                      estimator = "ML", data = imps[[i]])
}

summary(reslt[[1]])

library(mitools)
betas <- MIextract(fits, fun = coef)
vars <- MIextract(fits, fun = vcov)
fits.pooled <- summary(MIcombine(betas, vars))


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


summary(sem.01.ord.fits[[1]])


ord.betas <- MIextract(sem.01.ord.fits, fun = coef)
ord.vars <- MIextract(sem.01.ord.fits, fun = vcov)
ord.fits.pooled <- summary(MIcombine(ord.betas, ord.vars))
