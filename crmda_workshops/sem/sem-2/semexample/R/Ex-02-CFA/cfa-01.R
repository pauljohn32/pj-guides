## ----setup, include=FALSE------------------------------------------------
##This Invisible Chunk is required in all CRMDA documents
outdir <- paste0("tmpout")
if (!file.exists(outdir)) dir.create(outdir, recursive = TRUE)
knitr::opts_chunk$set(echo=TRUE, comment=NA, fig.path=paste0(outdir, "/p-"))
options(width = 75)

## ------------------------------------------------------------------------
##install.packages("lavaan")
library(lavaan)
##install.packages("kutils")
library(kutils)
##install.packages("semPlot")
library(semPlot)

## ------------------------------------------------------------------------
dat <- read.csv("../../data/job_placement.csv", header = FALSE)

## ------------------------------------------------------------------------
colnames(dat) <- c("id", "wjcalc", "wjspl", "wratspl", "wratcalc", "waiscalc", "waisspl",
                   "edlevel", "newschl", "suspend", "expelled", "haveld", "female", "age")

## ------------------------------------------------------------------------
dat[dat == 99999] <- NA

## ------------------------------------------------------------------------
CFAmodel <- 'MATH =~ wratcalc + wjcalc + waiscalc
             SPELL =~ wratspl + wjspl + waisspl'

## ------------------------------------------------------------------------
CFAmodel.fitted <- cfa(model = CFAmodel, data = dat, std.lv = TRUE,
                       missing = "fiml", mimic = "Mplus")
summary(CFAmodel.fitted)

## ------------------------------------------------------------------------
summary(CFAmodel.fitted, standardized = TRUE)

## ------------------------------------------------------------------------
summary(CFAmodel.fitted, standardized = TRUE, fit = TRUE)

## ------------------------------------------------------------------------
fitStats <- fitMeasures(CFAmodel.fitted, c("cfi", "rmsea"))
fitStats

## ------------------------------------------------------------------------
paramEsts <- parameterEstimates(CFAmodel.fitted)
paramEsts

## ------------------------------------------------------------------------
fscores <- lavPredict(CFAmodel.fitted)
head(fscores)

## ---- warning = FALSE----------------------------------------------------
library(semPlot)
semPaths(CFAmodel.fitted)

## ---- warning = FALSE----------------------------------------------------
semPaths(CFAmodel.fitted, what = "paths", intercepts = FALSE, sizeMan = 12, sizeMan2 = 8,
         layout = "tree2", sizeLat = 20, sizeLat2 = 10, width = 5, height = 1,
         label.cex = 1, nCharNodes = 0, curve = 2.5, label.scale = FALSE)

## ---- warning = FALSE----------------------------------------------------
semPaths(CFAmodel.fitted, what = "paths", whatLabels = "est", intercepts = FALSE,
         sizeMan = 12, sizeMan2 = 8,layout = "tree2", sizeLat = 20, sizeLat2 = 10,
         width = 5, height = 3, label.cex = 1, nCharNodes = 0, curve = 2.5,
         label.scale = FALSE, edge.label.cex = 1.2)

## ---- eval = FALSE-------------------------------------------------------
## semTable(CFAmodel.fitted, type = "html")

## ---- echo = FALSE-------------------------------------------------------
semTable(CFAmodel.fitted, type = "html")

## ---- eval = FALSE-------------------------------------------------------
## semTable(CFAmodel.fitted, type = "html", file = "CFAmodel.fitted.html")

## ---- echo = FALSE, results='asis'---------------------------------------
semTable(CFAmodel.fitted, type = "html")

## ----sessionInfo, echo = FALSE-------------------------------------------
sessionInfo()

