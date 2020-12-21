## ----setup, include=FALSE------------------------------------------------
##This Invisible Chunk is required in all CRMDA documents
outdir <- paste0("tmpout")
if (!file.exists(outdir)) dir.create(outdir, recursive = TRUE)
knitr::opts_chunk$set(echo=TRUE, comment=NA, fig.path=paste0(outdir, "/p-"))
options(width = 75)

## ------------------------------------------------------------------------

library(lavaan)

## ------------------------------------------------------------------------
dat <- read.csv("../../data/job_placement.csv", header = FALSE)
colnames(dat) <- c("id", "wjcalc", "wjspl", "wratspl", "wratcalc",
                   "waiscalc", "waisspl", "edlevel", "newschl",
                   "suspend", "expelled", "haveld", "gender", "age")
dat[dat == 99999] <- NA
dat$gender <- as.factor(dat$gender)
levels(dat$gender) <- c("Male", "Female")

## ------------------------------------------------------------------------
model.path <-
    ' wjspl ~ c*age     ## the c path - the direct path from IV to DV
      wjspl ~ b*edlevel ## the b path - the direct path from mediator to DV
      edlevel ~ a*age   ## the a path - the direct path from IV to mediator
      ab := a*b         ## using := operator to create ab (the indirect effect)
      total := c + a*b  ## using := operator to create total effect
    '

## ------------------------------------------------------------------------
output.path <- sem(model = model.path, data = dat, se = "bootstrap",
                   bootstrap = 1000)
summary(output.path)

## ------------------------------------------------------------------------
model.path.2 <-
    ' wjspl ~ c(b1, b2)*edlevel + c(c1, c2)*age ## separate b and c paths for two groups
      edlevel ~ c(a1, a2)*age                   ## separate a paths for two groups

      a1b1 := a1*b1 ## the indirect effect for group 1
      a2b2 := a2*b2 ## the indirect effect for group 2

      total1 := c1 + a1*b1 ## the total effect for group 1
      total2 := c2 + a2*b2 ## the total effect for group 2
    '

## ------------------------------------------------------------------------
output.path.2 <- sem(model = model.path.2, data = dat, se = "bootstrap",
                     bootstrap = 1000, group = "gender")
summary(output.path.2)

## ----sessionInfo, echo=FALSE---------------------------------------------
sessionInfo()

