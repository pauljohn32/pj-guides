## ----setup, include=FALSE------------------------------------------------
##This Invisible Chunk is required in all CRMDA documents
outdir <- paste0("tmpout")
if (!file.exists(outdir)) dir.create(outdir, recursive = TRUE)
knitr::opts_chunk$set(echo=TRUE, comment=NA, fig.path=paste0(outdir, "/p-"))
options(width = 75)

## ------------------------------------------------------------------------
library(lavaan)

## ------------------------------------------------------------------------
dat <- read.csv("../../data/insomnia.dat", header = FALSE, sep = "\t")

colnames(dat) <- c("insom1", "insom2", "insom3",
                   "insom4", "insom5", "insom6",
                   "insom7",
                   "cesd1", "cesd2", "cesd3",
                   "cesd4", "cesd5", "cesd6",
                   "cesd7", "cesd8", "cesd9",
                   "cesd10", "cesd11", "cesd12",
                   "cesd13", "cesd14", "cesd15",
                   "cesd16", "cesd17", "cesd18",
                   "cesd19", "cesd20",
                   "phy", "psy", "soc", "env")

dat[dat == 999] <- NA

## ------------------------------------------------------------------------
SEMModel <- ' ## the measurement model for exogenous factor Impact
              Impact =~ insom5 + insom6 + insom7

              ## the measurement model for exogenous factor Severity
              Severity =~ insom1 + insom2 + insom3

              ## the measurement model for exogenous factor Satisf
              Satisf =~ insom1 + insom4 + insom7

              ## the measurement model for endogenous factor Qol
              Qol =~ phy + psy + soc + env

              ## the structural model for regressing the
              ## endogenous onto the exogenous factors 
              Qol ~ Impact + Severity + Satisf '

## ------------------------------------------------------------------------
output <- sem(model = SEMModel, data = dat, std.lv = TRUE,
              missing = "fiml", mimic = "Mplus")
summary(output, standardized = TRUE, fit.measures = TRUE)

## ----sessionInfo, echo = FALSE-------------------------------------------
sessionInfo()

