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
lmout <- lm(wjspl ~ edlevel + newschl + suspend +
                    expelled + haveld + gender +
                    age, data = dat)
summary(lmout)

## ------------------------------------------------------------------------
MLRModel <- 'wjspl ~ edlevel + newschl + suspend +
                     expelled + haveld + gender +
                     age

             wjspl ~ 1'

## ------------------------------------------------------------------------
output <- sem(model = MLRModel, data = dat)
summary(output, standardized = TRUE)

## ------------------------------------------------------------------------
MLRModel.2 <- 'wjspl ~ edlevel + newschl + suspend +
                       expelled + haveld + gender +
                       age

               wjspl ~ 1

               wjcalc ~ edlevel + newschl + suspend +
                        expelled + haveld + gender +
                        age

               wjcalc ~ 1'

## ------------------------------------------------------------------------
output.2 <- sem(model = MLRModel.2, data = dat)
summary(output.2, standardized = TRUE)

## ----sessionInfo, echo = FALSE-------------------------------------------
sessionInfo()

