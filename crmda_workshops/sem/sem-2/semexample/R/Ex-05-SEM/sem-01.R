## ----setup, include=FALSE------------------------------------------------
##This Invisible Chunk is required in all CRMDA documents
outdir <- paste0("tmpout")
if (!file.exists(outdir)) dir.create(outdir, recursive = TRUE)
knitr::opts_chunk$set(echo=TRUE, comment=NA, fig.path=paste0(outdir, "/p-"))
options(width = 70)

## ------------------------------------------------------------------------

library(lavaan)

## ------------------------------------------------------------------------
dat <- read.csv("../../data/job_placement.csv", header = FALSE)
colnames(dat) <- c("id", "wjcalc", "wjspl", "wratspl", "wratcalc", "waiscalc", "waisspl", "edlevel", "newschl", "suspend", "expelled", "haveld", "female", "age")
dat[dat == 99999] <- NA

## ------------------------------------------------------------------------
SEMModel <- "MATH =~ wratcalc + wjcalc + waiscalc
             SPELL =~ wratspl + wjspl + waisspl
             MATH ~ edlevel + newschl + suspend + expelled + haveld + female + age
             SPELL ~ edlevel + newschl + suspend + expelled + haveld + female + age
             MATH ~~ SPELL
             "

## ------------------------------------------------------------------------
output <- sem(model = SEMModel, data = dat, missing = "fiml", mimic = "mplus")
summary(output)

## ----sessionInfo, echo = FALSE-------------------------------------------
sessionInfo()

