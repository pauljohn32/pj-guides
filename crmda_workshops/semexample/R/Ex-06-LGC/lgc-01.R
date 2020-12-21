## ----setup, include=FALSE------------------------------------------------
##This Invisible Chunk is required in all CRMDA documents
outdir <- paste0("tmpout")
if (!file.exists(outdir)) dir.create(outdir, recursive = TRUE)
knitr::opts_chunk$set(echo=TRUE, comment=NA, fig.path=paste0(outdir, "/p-"))
options(width = 75)

## ------------------------------------------------------------------------
library(lavaan)

## ------------------------------------------------------------------------
dat <- read.table("../../data/anxiety.dat", header = F)
names(dat) <- c("a1", "a2", "a3", "a4")

## ------------------------------------------------------------------------
model <-
' intercept =~ 1*a1 + 1*a2 + 1*a3 + 1*a4
  slope =~ 0*a1 + 1*a2 + 2*a3 + 3*a4

  a1 ~ 0*1
  a2 ~ 0*1
  a3 ~ 0*1
  a4 ~ 0*1

  intercept ~ 1
  slope ~ 1
'

## ------------------------------------------------------------------------
output <- sem(model, data = dat)
summary(output, standardized = TRUE, fit.measures = TRUE)

## ----sessionInfo, echo = FALSE-------------------------------------------
sessionInfo()

