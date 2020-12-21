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

dat[dat == 99999] <- NA ## convert the original missing data value "99999" to NA

dat$gender <- as.factor(dat$gender) ## change "gender" to a factor variable
levels(dat$gender) ## check the levels of the factor variable               
table(dat$gender) ## request a frequency summary
levels(dat$gender) <- c("Male", "Female") ## assign level labels
table(dat$gender) ## request a frequency summary to verify assigned labels 

## ------------------------------------------------------------------------
ConfigModel <- 'MATH =~ wratcalc + wjcalc + waiscalc
                SPELL =~ wratspl + wjspl + waisspl'

## ------------------------------------------------------------------------
ConfigOutput <- cfa(model = ConfigModel, data = dat, std.lv = TRUE,
                    missing = "fiml", mimic = "Mplus", group = "gender")
summary(ConfigOutput, standardized = TRUE, fit.measures = TRUE)

## ------------------------------------------------------------------------
metricModel <-
    ' MATH =~ c(NA, NA)*wratcalc + wjcalc + waiscalc
      ## freely estimate the first factor loading in both groups

      MATH ~~ c(NA, 1)*MATH
      ## fix the factor variance of MATH to 1 in male group, and freely estimate in female group

      MATH ~ c(0, 0)*1

      SPELL =~ c(NA, NA)*wratspl + wjspl + waisspl
      ## freely estimate the first factor loading in both groups

      SPELL ~~ c(NA, 1)*SPELL
      ## fix the factor variance of SPELL to 1 in male group, and freely estimate in female group

      SPELL ~ c(0, 0)*1
    '


## ------------------------------------------------------------------------
metricOutput <- cfa(model = metricModel, data = dat,
                    missing = "fiml", mimic = "Mplus",
                    group = "gender", group.equal = "loadings")
summary(metricOutput, standardized = TRUE, fit.measures = TRUE)

## ------------------------------------------------------------------------
scalarModel <- 'MATH =~ c(NA, NA)*wratcalc + wjcalc + waiscalc
                MATH ~~ c(NA, 1)*MATH
                MATH ~ c(NA, 0)*1

                SPELL =~ c(NA, NA)*wratspl + wjspl + waisspl
                SPELL ~~ c(NA, 1)*SPELL
                SPELL ~ c(NA, 0)*1'


## ------------------------------------------------------------------------
scalarOutput <- cfa(model = scalarModel, data = dat,
                    missing = "fiml", mimic = "Mplus",
                    group = "gender",
                    group.equal = c("loadings", "intercepts"))
summary(scalarOutput, standardized = TRUE, fit.measures = TRUE)

## ------------------------------------------------------------------------
anova(ConfigOutput, metricOutput)

## ------------------------------------------------------------------------
anova(metricOutput, scalarOutput)

## ------------------------------------------------------------------------
strictModel <- 'MATH =~ c(NA, NA)*wratcalc + wjcalc + waiscalc
                MATH ~~ c(NA, 1)*MATH
                MATH ~ c(NA, 0)*1

                SPELL =~ c(NA, NA)*wratspl + wjspl + waisspl
                SPELL ~~ c(NA, 1)*SPELL
                SPELL ~ c(NA, 0)*1'


## ------------------------------------------------------------------------
strictOutput <- cfa(model = strictModel, data = dat,
                    missing = "fiml", mimic = "Mplus",
                    group = "gender",
                    group.equal = c("loadings", "intercepts", "residuals"))
summary(strictOutput, standardized = TRUE, fit.measures = TRUE)

anova(scalarOutput, strictOutput)

## ----sessionInfo, echo = FALSE-------------------------------------------
sessionInfo()

