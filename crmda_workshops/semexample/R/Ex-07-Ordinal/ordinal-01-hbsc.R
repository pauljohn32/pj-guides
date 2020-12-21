## ----excludemesetup, include=FALSE---------------------------------------
##This Invisible Chunk is required in all CRMDA documents
outdir <- paste0("tmpout")
if (!file.exists(outdir)) dir.create(outdir, recursive = TRUE)
knitr::opts_chunk$set(echo=TRUE, comment=NA, fig.path=paste0(outdir, "/p-"))
opts.orig <- options()
par.orig <- par(no.readonly=TRUE)
options(width = 80)

## ----datain10, include=F-------------------------------------------------
ddir <- "../../data/hbsc-subset2"
odir <- "output"

library(kutils)
library(lavaan)

## ----datain20------------------------------------------------------------
hbsc.colnames <- scan(file.path(ddir, "hbsc-subset2-colnames.txt"), what = "character")
hbsc.orig <- read.table(file.path(ddir, "hbsc-subset2.dat"),
                        header = FALSE, col.names = hbsc.colnames,
                        na.strings = c("-999", ".", "NA"))
key <- keyImport("hbsc-subset2-key2.csv")
hbsc <- keyApply(hbsc.orig, key, drop = FALSE, ignoreCase = FALSE, debug = FALSE,
                 diagnostic = FALSE)

## ----datain30------------------------------------------------------------
hbsc <- hbsc[!is.na(hbsc$Grade) & hbsc$Grade %in% c("6", "7"), ]

## ----namecheck, include=F, echo=F----------------------------------------
ords <- grep("_o$", colnames(hbsc), value = TRUE)
ints <- gsub("_o$", "", ords)
vnames <- data.frame("Ordinal Versions" = ords, "Integer Versions" = ints)

## ----namecheck2, results='asis', echo=F----------------------------------
library(xtable)
t1 <- xtable(vnames)
print(t1, type = "html", include.rownames = FALSE)

## ----import1-------------------------------------------------------------
vars <- c("Grade", "depress1", "depress2", "depress3", "depress1_o", "depress2_o", "depress3_o")
summary(hbsc[ , vars])

## ----import2, echo=F-----------------------------------------------------
table("depress1 as factor" = hbsc$depress1_o, "depress1 as integer"= hbsc$depress1)

## ----cfa.depress---------------------------------------------------------
cfa.depress <- '
depress =~ NA*depress1 + depress2 + depress3
            + depress4 + depress5 + depress6
depress ~~ 1*depress
'

## ----cfa.depress.MLR.listwise--------------------------------------------
cfa.depress.mlr.listwise <-
  cfa(model = cfa.depress, data = hbsc,
      mimic = "Mplus", estimator = "MLR", meanstructure = TRUE, 
      missing = "listwise")

## ----cfa.depress.MLR.listwise.summary------------------------------------
summary(cfa.depress.mlr.listwise, fit.measures = TRUE, standardized = TRUE)

## ----cfa.depress.mlr.listwise.save, include=F, message=F, warning=F------
myexp <- "
fn <- \"cfa.depress.mlr.listwise.Rout\"
sink(file = file.path(odir, fn), type = \"output\")
print(\"The cfa function formulates the lavaan function call:\")
show(cfa.depress.mlr.listwise@call)
summary(cfa.depress.mlr.listwise, fit.measures = TRUE, standardized = TRUE)
print(warnings(last.warning))
sink()
"
eval(parse(text = myexp))

## ----cfa.depress.mlr.fiml------------------------------------------------
cfa.depress.mlr.fiml <- cfa(model = cfa.depress, data = hbsc,
                            mimic = "Mplus", estimator = "MLR",
                            meanstructure = TRUE)

## ----cfa.depress.mlr.fiml.summary, eval=F--------------------------------
## summary(cfa.depress.mlr.fiml, fit.measures = TRUE, standardized = TRUE)

## ----cfa.depress.mlr.fiml.save, include=F, message=F, warning=F----------
myexp <- "
fn <- \"cfa.depress.mlr.fiml.Rout\"
sink(file = file.path(odir, fn), type = \"output\")
print(\"The cfa function formulates the lavaan function call:\")
show(cfa.depress.mlr.fiml@call)
summary(cfa.depress.mlr.fiml, fit.measures = TRUE, standardized = TRUE)
print(warnings(last.warning))
sink()
"
eval(parse(text = myexp))

## ---- echo = F, include = T, warning = F, message = F, results = 'hide'----
hist(hbsc$depress1, main = "Histogram of Depression Item 1", xlab = "Response Option", 
           ylim = c(0, 3000), breaks = c(1,2,3,4,5))

## ----cfa.depress.ord-----------------------------------------------------
cfa.depress.ord <- '
depress =~ NA*depress1_o + depress2_o + depress3_o
            + depress4_o + depress5_o + depress6_o
depress ~~ 1*depress
'

## ----cfa.depress.ord.wlsmv-----------------------------------------------
cfa.depress.ord.wlsmv <-
    cfa(model = cfa.depress.ord, data = hbsc, mimic = "Mplus",
        estimator = "WLSMV", missing = "listwise")

## ----cfa.depress.ord.fit.wlsmv.summary, eval=F---------------------------
## summary(cfa.depress.ord.wlsmv, fit.measures = TRUE, standardized = TRUE)

## ----cfa.depress.ord.save, include=F-------------------------------------
myexp <- "
fn <- \"cfa.depress.ord.wlsmv.listwise.Rout\"
sink(file = file.path(odir, fn), type = \"output\")
print(\"The cfa function formulates the lavaan function call:\")
show(cfa.depress.ord.wlsmv@call)
summary(cfa.depress.ord.wlsmv, fit.measures = TRUE, standardized = TRUE)
sink()
"
eval(parse(text = myexp))

## ----cfa.depress.ord.wlsmv2----------------------------------------------
cfa.depress.wlsmv2 <-
  cfa(model = cfa.depress, data = hbsc,
    mimic = "Mplus", estimator = "WLSMV",
    ordered = c("depress1", "depress2", "depress3",
                "depress4", "depress5", "depress6"))

## ---- echo=F, results='asis'---------------------------------------------
library(kutils)
semtab10 <- semTable(list("ML (FIML)" = cfa.depress.mlr.fiml ,
                          "ML (listwise)" = cfa.depress.mlr.listwise,
                          "WLSMV" = cfa.depress.wlsmv2), columns = "estsestars",
                     type = "html")

## ----cfa.bullied---------------------------------------------------------
cfa.bullied <- '
bullied =~ NA*bullied1 + bullied2 + bullied3
            + bullied4 + bullied5 + bullied6 
            + bullied7 + bullied8 + bullied9
bullied ~~ 1*bullied
'

## ----cfa.bullied.mlr.listwise--------------------------------------------
cfa.bullied.mlr.listwise <-
    cfa(model = cfa.bullied, data = hbsc, mimic = "Mplus",
        estimator = "MLR", missing = "listwise", meanstructure = TRUE)

## ----cfa.bullied.mlr.listwise.summary, eval=F----------------------------
## summary(cfa.bullied.mlr.listwise, fit.measures = TRUE, standardized = TRUE)

## ----cfa.bullied.mlr.listwise.save, include=F----------------------------
myexp <- "
fn <- \"cfa.bullied.mlr.listwise.Rout\"
sink(file = file.path(odir, fn), type = \"output\")
print(\"The cfa function formulates the lavaan function call:\")
show(cfa.bullied.mlr.listwise@call)
summary(cfa.bullied.mlr.listwise, fit.measures = TRUE, standardized = TRUE)
sink()
"
eval(parse(text = myexp))

## ----cfa.bullied.ord-----------------------------------------------------
cfa.bullied.ord <- '
bullied =~ NA*bullied1_o + bullied2_o + bullied3_o
            + bullied4_o + bullied5_o + bullied6_o 
            + bullied7_o + bullied8_o + bullied9_o
bullied ~~ 1*bullied
'

## ----cfa.bullied.ord.wlsmv-----------------------------------------------
cfa.bullied.ord.wlsmv <-
    cfa(model = cfa.bullied.ord, data = hbsc,  mimic = "Mplus",
        estimator = "WLSMV", meanstructure = TRUE)

## ----cfa.bullied.ord.wlsmv.summary, eval=F-------------------------------
## summary(cfa.bullied.ord.wlsmv, fit.measures = TRUE, standardized = TRUE)

## ----cfa.bullied.ord.save, include=F-------------------------------------
myexp <- "
fn <- \"cfa.bullied.ord.wlsmv.listwise.Rout\"
sink(file = file.path(odir, fn), type = \"output\")
print(\"The cfa function formulates the lavaan function call:\")
show(cfa.bullied.ord.wlsmv@call)
summary(cfa.bullied.ord.wlsmv, fit.measures = TRUE, standardized = TRUE)
sink()
"
eval(parse(text = myexp))

## ----cfa.bullied.ord.wlsvm2, include=F-----------------------------------
cfa.bullied.wlsmv2 <-
    cfa(model = cfa.bullied, data = hbsc,  mimic = "Mplus",
        estimator = "WLSMV",
		ordered = paste0("bullied", 1:9))

## ----bullytable, echo=F, results='asis'----------------------------------
semtab20 <- semTable(list("ML (listwise)" = cfa.bullied.mlr.listwise,
                          "WLSMV" = cfa.bullied.wlsmv2), columns = "estsestars",
                     type = "html")

## ----cfa.alc-------------------------------------------------------------
cfa.alc <- '
alcohol =~ NA*alc1 + alc2 + alc3
            + alc4 + alc5
alcohol ~~ 1*alcohol
'

## ----cfa.alc.mlr---------------------------------------------------------
cfa.alc.mlr.listwise <-
    cfa(model = cfa.alc, data = hbsc, mimic = "Mplus",
        estimator = "MLR", missing = "listwise", meanstructure = TRUE)

## ----cfa.alc.mlr.summary, eval=F-----------------------------------------
## summary(cfa.alc.mlr.listwise, fit.measures = TRUE)

## ----cfa.alc.mlr.listwise.save, include=F--------------------------------
myexp <- "
fn <- \"cfa.alc.mlr.listwise.Rout\"
sink(file = file.path(odir, fn), type = \"output\")
print(\"The cfa function formulates the lavaan function call:\")
show(cfa.alc.mlr.listwise@call)
summary(cfa.alc.mlr.listwise, fit.measures = TRUE, standardized = TRUE)
sink()
"
eval(parse(text = myexp))

## ----cfa.alc.ord.wlsmv---------------------------------------------------
cfa.alc.ord <- '
alcohol =~ NA*alc1_o + alc2_o + alc3_o
            + alc4_o + alc5_o
alcohol ~~ 1*alcohol
'

cfa.alc.ord.wlsmv <-
    cfa(model = cfa.alc.ord, data = hbsc, mimic = "Mplus",
        estimator = "WLSMV", missing = "listwise")

## ----cfa.alc.ord.wlsmv.summary, eval=F-----------------------------------
## summary(cfa.alc.ord.wlsmv, fit.measures = TRUE, standardized = TRUE)

## ----cfa.alc.ord.save, include=F-----------------------------------------
myexp <- "
fn <- \"cfa.alc.ord.wlsmv.listwise.Rout\"
sink(file = file.path(odir, fn), type = \"output\")
print(\"The cfa function formulates the lavaan function call:\")
show(cfa.alc.ord.wlsmv@call)
summary(cfa.alc.ord.wlsmv, fit.measures = TRUE, standardized = TRUE)
sink()
"
eval(parse(text = myexp))

## ----cfa.alc.ord.wlsmv2, include=F---------------------------------------
cfa.alc.wlsmv2 <-
    cfa(model = cfa.alc, data = hbsc,  mimic = "Mplus",
        estimator = "WLSMV",
		ordered = paste0("alc", 1:5))

## ----alctable, echo=F, results='asis'------------------------------------
semtab30 <- semTable(list("ML (listwise)" = cfa.alc.mlr.listwise,
                          "WLSMV" = cfa.alc.wlsmv2), columns = "estsestars",
                     type = "html")

## ----cfa.3factor---------------------------------------------------------
cfa.3factor <- '
bullied =~ NA*bullied1 + bullied2 + bullied3
            + bullied4 + bullied5 + bullied6
            + bullied7 + bullied8 + bullied9
bullied ~~ 1*bullied
depress =~ NA*depress1 + depress2 + depress3
            + depress4 + depress5 + depress6
depress ~~ 1*depress
alcohol =~ NA*alc1 + alc2 + alc3
            + alc4 + alc5
alcohol ~~ 1*alcohol
'

## ----cfa.3factor.mlr-----------------------------------------------------
cfa.3factor.mlr.listwise <-
    cfa(model = cfa.3factor, data = hbsc,  mimic = "Mplus",
        estimator = "MLR", missing = "listwise", meanstructure = TRUE)

## ----cfa.3factor.mlr.listwise.summary------------------------------------
summary(cfa.3factor.mlr.listwise, fit.measures = TRUE, standardized = TRUE)

## ----cfa.3factor.ord-----------------------------------------------------
cfa.3factor.ord <- '
bullied =~ NA*bullied1_o + bullied2_o + bullied3_o
            + bullied4_o + bullied5_o + bullied6_o
            + bullied7_o + bullied8_o + bullied9_o
bullied ~~ 1*bullied
depress =~ NA*depress1_o + depress2_o + depress3_o
            + depress4_o + depress5_o + depress6_o
depress ~~ 1*depress
alcohol =~ NA*alc1_o + alc2_o + alc3_o
            + alc4_o + alc5_o
alcohol ~~ 1*alcohol
'

## ----cfa.3factor.wlsmv.listwise------------------------------------------
cfa.3factor.wlsmv.listwise <-
  cfa(model = cfa.3factor.ord, data = hbsc,
      mimic = "Mplus", estimator = "WLSMV")

## ----cfa.3factor.wlsmv.listwise.summary, eval=F--------------------------
## summary(cfa.3factor.wlsmv.listwise, fit.measures = TRUE, standardized = TRUE)

## ----cfa.3factor.ord.wlsmv2, include=F-----------------------------------
cfa.3factor.wlsmv2 <-
    cfa(model = cfa.3factor, data = hbsc,  mimic = "Mplus",
        estimator = "WLSMV",
		ordered = c(paste("depress", 1:6), paste0("alc", 1:5), paste0("bullied", 1:9)))

## ----factor3table, echo=F, results='asis'--------------------------------
semtab40 <- semTable(list("ML (listwise)" = cfa.3factor.mlr.listwise,
                          "WLSMV" = cfa.3factor.wlsmv2), columns = "estsestars",
                     type = "html")

## ----factor3table2, echo=F, results='asis'-------------------------------
semtab50 <- semTable(list("Alcohol" = cfa.alc.wlsmv2, "Bullied" = cfa.bullied.wlsmv2,
                          "Depression" = cfa.depress.wlsmv2,
                          "3 factor" = cfa.3factor.wlsmv2), columns = "estsestars",
                     type = "html")

## ----sem.01.mlr----------------------------------------------------------
sem.01 <- '
## the measurement model
bullied =~ NA*bullied1 + bullied2 + bullied3
             + bullied4 + bullied5 + bullied6
             + bullied7 + bullied8 + bullied9
bullied ~~ 1*bullied
alcohol =~ NA*alc1 + alc2 + alc3
            + alc4 + alc5
alcohol ~~ 1*alcohol
# regress 
alcohol ~ bullied
'

sem.01.mlr.listwise <-
    sem(model = sem.01, data = hbsc,  mimic = "Mplus",
        estimator = "MLR", missing = "listwise")

## ----sem.01.mlr.summary, eval=F------------------------------------------
## summary(sem.01.mlr.listwise, fit.measures = TRUE,
##         standardized = TRUE)

## ----sem.01.mlr.listwise.save, include=F---------------------------------
myexp <- "
fn <- \"sem.01.mlr.listwise.Rout\"
sink(file = file.path(odir, fn), type = \"output\")
print(\"The sem function formulates the lavaan function call:\")
show(sem.01.mlr.listwise@call)
summary(sem.01.mlr.listwise, fit.measures = TRUE, standardized = TRUE)
sink()
"
eval(parse(text = myexp))

## ----sem.01--------------------------------------------------------------
sem.01.ord <- '
## the measurement model
bullied =~ NA*bullied1_o + bullied2_o + bullied3_o
             + bullied4_o + bullied5_o + bullied6_o
             + bullied7_o + bullied8_o + bullied9_o
bullied ~~ 1*bullied
alcohol =~ NA*alc1_o + alc2_o + alc3_o
            + alc4_o + alc5_o
alcohol ~~ 1*alcohol
## the structural model
alcohol ~ bullied
'

## ----sem.01.ord.wlsmv.listwise-------------------------------------------
sem.01.ord.wlsmv.listwise <-
    sem(model = sem.01.ord, data = hbsc, mimic = "Mplus",
        estimator = "WLSMV", missing = "listwise")

## ----sem.01.ord.wlsmv.listwise.summary, eval=F---------------------------
## summary(sem.01.ord.wlsmv, fit.measures = TRUE, standardized = TRUE)

## ----sem.01.ord.wlsmv.listwise.save, include=F---------------------------
myexp <- "
fn <- \"sem.01.ord.wlsmv.listwise.Rout\"
sink(file = file.path(odir, fn), type = \"output\")
print(\"The cfa function formulates the lavaan function call:\")
show(sem.01.ord.wlsmv.listwise@call)
summary(sem.01.ord.wlsmv.listwise, fit.measures = TRUE, standardized = TRUE)
sink()
"
eval(parse(text = myexp))

## ----sem.01.ord.wlsmv2.listwise, include=F-------------------------------
sem.01.ord.wlsmv2.listwise <-
    sem(model = sem.01, data = hbsc, mimic = "Mplus",
        estimator = "WLSMV", missing = "listwise",
        ordered = c(paste("depress", 1:6), paste0("alc", 1:5), paste0("bullied", 1:9)))

## ----sem01table, echo=F, results='asis'----------------------------------
semtab50 <- semTable(list("ML (listwise)" = sem.01.mlr.listwise,
                          "WLSMV" = sem.01.ord.wlsmv2.listwise), columns = "estsestars",
                     type = "html", caption = "Structural Equation Model")

## ------------------------------------------------------------------------
sem.02 <- '
## the measurement model
bullied =~ NA*bullied1 + bullied2 + bullied3
             + bullied4 + bullied5 + bullied6 
             + bullied7 + bullied8 + bullied9
bullied ~~ 1*bullied
depress =~ NA*depress1 + depress2 + depress3
            + depress4 + depress5 + depress6
depress ~~ 1*depress
alcohol =~ NA*alc1 + alc2 + alc3
            + alc4 + alc5
alcohol ~~ 1*alcohol
## the structural model
## direct effect (the c path)
alcohol ~ c*bullied
## mediator paths (the a and b path)
depress ~ a*bullied # the a path - IV predicting ME
alcohol ~ b*depress  # the b path - ME predicting DV
## indirect effect (a*b)
## := operator defines new parameters
ab := a*b
## total effect
total := c + (a*b)
'

## ----sem.02.mlboot.listwise----------------------------------------------
NBOOT <- 10
sem.02.mlboot.listwise <- sem(model = sem.02, data = hbsc,
                           mimic = "Mplus", estimator = "ML",
                           missing = "listwise", se = "bootstrap",
                           verbose = TRUE, bootstrap = NBOOT)

## ----sem.02.mlboot.summary, eval=F---------------------------------------
## summary(sem.02.mlboot.listwise, fit.measures = TRUE, standardized = TRUE)

## ----sem.02.mlboot.listwise.save, include=F------------------------------
myexp <- "
fn <- \"sem.02.mlboot.listwise.Rout\"
sink(file = file.path(odir, fn), type = \"output\")
print(\"The cfa function formulates the lavaan function call:\")
show(sem.02.mlboot.listwise@call)
summary(sem.02.mlboot.listwise, fit.measures = TRUE, standardized = TRUE)
sink()
"
eval(parse(text = myexp))

## ----sem.02.ord----------------------------------------------------------
sem.02.ord <- '
## the measurement model
bullied =~ NA*bullied1_o + bullied2_o + bullied3_o
             + bullied4_o + bullied5_o + bullied6_o 
             + bullied7_o + bullied8_o + bullied9_o
bullied ~~ 1*bullied
depress =~ NA*depress1_o + depress2_o + depress3_o
            + depress4_o + depress5_o + depress6_o
depress ~~ 1*depress
alcohol =~ NA*alc1_o + alc2_o + alc3_o
            + alc4_o + alc5_o
alcohol ~~ 1*alcohol
## the structural model
## direct effect (the c path)
alcohol ~ c*bullied
## mediator paths (the a and b path)
depress ~ a*bullied # the a path - IV predicting ME
alcohol ~ b*depress  # the b path - ME predicting DV
## indirect effect (a*b)
## := operator defines new parameters
ab := a*b
## total effect
total := c + (a*b)
'

## ----sem.02.ord.wlsmv.listwise-------------------------------------------
sem.02.ord.wlsmv.listwise <-
  sem(model = sem.02.ord, data = hbsc, mimic = "Mplus",
      estimator = "DWLS", missing = "listwise",
      se = "bootstrap", verbose = TRUE,
      bootstrap = NBOOT)

## ----sem.02.ord.wlsmv.listwise.summary, eval = F-------------------------
## summary(sem.02.ord.wlsmv.listwise, fit.measures = TRUE, standardized = TRUE)

## ----sem.02.ord.wlsmv.listwise.save, include=F---------------------------
myexp <- "
fn <- \"sem.02.ord.wlsmv.listwise.Rout\"
sink(file = file.path(odir, fn), type = \"output\")
print(\"The cfa function formulates the lavaan function call:\")
show(sem.02.ord.wlsmv.listwise@call)
summary(sem.02.ord.wlsmv.listwise, fit.measures = TRUE, standardized = TRUE)
sink()
"
eval(parse(text = myexp))

## ----sem.02.ord.wlsmv2, include=F----------------------------------------
sem.02.ord.wlsmv2 <-
  sem(model = sem.02, data = hbsc,
      mimic = "Mplus", estimator = "DWLS", se = "bootstrap", bootstrap = NBOOT, 
      ordered = c(paste("depress", 1:6), paste0("alc", 1:5), paste0("bullied", 1:9)))

## ----sem02table, echo=F, results='asis'----------------------------------
semtab70 <- semTable(list("ML (listwise)" = sem.02.mlboot.listwise,
                          "DWLS" = sem.02.ord.wlsmv2), columns = "estsestars",
                     type = "html", caption = "Structural Equation Model (Bootstrap)")

## ----warns1, echo = FALSE------------------------------------------------
sessionInfo()

## ----warns2, echo = FALSE------------------------------------------------
if(!is.null(warnings())){
    print("Warnings:")
    warnings()
}

## ----RoptionsRestore, echo=FALSE, include=FALSE--------------------------
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
par(par.orig)

