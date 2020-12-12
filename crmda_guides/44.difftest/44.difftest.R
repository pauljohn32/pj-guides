## ----setup, include=FALSE------------------------------------------------
##This Invisible Chunk is required in all CRMDA documents
outdir <- paste0("tmpout")
if (!file.exists(outdir)) dir.create(outdir, recursive = TRUE)
knitr::opts_chunk$set(echo=TRUE, comment=NA, fig.path=paste0(outdir, "/p-"))
options(width = 75)

## ----themecopy, include = FALSE------------------------------------------
library(kutils)
## If theme directory does not have required images or TeX files
## we need to retrieve them and put them in "theme" directory. 
logos <- c(logoleft = "jayhawk.png", 
           logoright = "CRMDAlogo-vert.png")
files <- c("kutils.css", 
           "guide-boilerplate.html")
getFiles(logos, pkg = "crmda")
getFiles(files, pkg = "crmda")

## ---- echo=T, include=FALSE----------------------------------------------
pdf.options(onefile=FALSE, family="Times", paper="special", height=4,
            width=6, pointsize=10)

## Reading in `crmda_difftest` and table making function
source("difftest_functions.R")
library(xtable)
library(MplusAutomation)

## ---- eval = FALSE-------------------------------------------------------
## crmda_difftest("parent.out", "nested.out")

## ----modeltable, include = FALSE, echo = FALSE, cache = TRUE-------------
mplusdir <- "Mplus"
outs <- list.files(mplusdir, pattern = "\\.out$", full.names = TRUE)
models <- lapply(outs, function(x) readModels(x)$summaries)
sums <- lapply(models, function(x) gsub(";", "", x[c("Title")]))
sums2 <- lapply(sums, function(x) t(cbind(unlist(strsplit(x, " - ")))))
titles <- do.call("rbind", sums2)
titles <- cbind(titles, basename(outs))
colnames(titles) <- c("Model Number", "Model Description", "Output File")
modelTable <- print(xtable(titles), type = "html",
                    include.rownames = FALSE, file = "tmpout/modeltable.html")

## ----printmods, results = "asis", echo = FALSE, dependson='modeltable'----
cat(modelTable)

## ---- include = FALSE----------------------------------------------------
## Creating a Data Frame Containing References for Mplus Out Files

## Labels for 25 Nested Model Comparisons
mplusOutRef <- data.frame("comparison" = c("Model.00vs01",
                                           "Model.02vs03",
                                           "Model.04vs05",
                                           "Model.06vs07",
                                           "Model.06vs08",
                                           "Model.09vs10",
                                           "Model.09vs11",
                                           "Model.10vs12",
                                           "Model.11vs13",
                                           "Model.14vs15",
                                           "Model.17vs18",
                                           "Model.18vs19",
                                           "Model.19vs20",
                                           "Model.21vs22",
                                           "Model.22vs23",
                                           "Model.23vs24",
                                           "Model.25vs26",
                                           "Model.26vs27",
                                           "Model.27vs28",
                                           "Model.29vs30",
                                           "Model.30vs31",
                                           "Model.31vs32",
                                           "Model.33vs34",
                                           "Model.34vs35",
                                           "Model.35vs36"), stringsAsFactors = FALSE)

## Labels for the Parent Models' Mplus Output Files
mplusOutRef[ , "parent"] <- c("m00-2_indicators.out",
                              "m02-3_indicators.out",
                              "m04-5_6_indicators.out",
                              "m06-3_factors.out",
                              "m06-3_factors.out",
                              "m09-structural.out",
                              "m09-structural.out",
                              "m10-structural.out",
                              "m11-structural.out",
                              "m14-indirect.out",
                              "m17-1_factor-2_groups-config.out",
                              "m18-1_factor-2_groups-weak.out",
                              "m19-1_factor-2_groups-strong.out",
                              "m21-1_factor-3_groups-config.out",
                              "m22-1_factor-3_groups-weak.out",
                              "m23-1_factor-3_groups-strong.out",
                              "m25-1_factor-4_groups-config.out",
                              "m26-1_factor-4_groups-weak.out",
                              "m27-1_factor-4_groups-strong.out",
                              "m29-1_factor-5_groups-config.out",
                              "m30-1_factor-5_groups-weak.out",
                              "m31-1_factor-5_groups-strong.out",
                              "m33-5_factors-5_groups-config.out",
                              "m34-5_factors-5_groups-weak.out",
                              "m35-5_factors-5_groups-strong.out")

## Model Specifications for the Parent Models
mplusOutRef[ , "parentSpec"] <- c("2 Factors_2 Indicators_Factor Correlation Free",
                                  "2 Factors_3 Indicators_Factor Correlation Free",
                                  "2 Factors_5/6 Indicators_Factor Correlation Free",
                                  "3 Factors_5/6/9 Indicators_Factor Correlations Free",
                                  "3 Factors_5/6/9 Indicators_Factor Correlations Free",
                                  "3 Factors_2 IVs 1 DV_IVs Correlation Free_Regressive Paths Free",
                                  "3 Factors_2 IVs 1 DV_IVs Correlation Free_Regressive Paths Free",
                                  "3 Factors_2 IVs 1 DV_IVs Correlation Fixed 0_Regressive Paths Free",
                                  "3 Factors_2 IVs 1 DV_IVs Correlation Fixed 0_Regressive Paths Equated",
                                  "3 Factors_1 IV 1 DV 1 ME_Regressive Paths Free",
                                  "1 Factor_2 Groups_config",
                                  "1 Factor_2 Groups_weak",
                                  "1 Factor_2 Groups_strong",
                                  "1 Factor_3 Groups_config",
                                  "1 Factor_3 Groups_weak",
                                  "1 Factor_3 Groups_strong",
                                  "1 Factor_4 Groups_config",
                                  "1 Factor_4 Groups_weak",
                                  "1 Factor_4 Groups_strong",
                                  "1 Factor-5 Groups_config",
                                  "1 Factor-5 Groups_weak",
                                  "1 Factor-5 Groups_strong",
                                  "5 Factors-5 Groups_config",
                                  "5 Factors-5 Groups_weak",
                                  "5 Factors-5 Groups_strong")

## Labels for the Child Models' Mplus Output Files
mplusOutRef[ , "child"] <- c("m01-2_indicators.out",
                             "m03-3_indicators.out",
                             "m05-5_6_indicators.out",
                             "m07-3_factors.out",
                             "m08-3_factors.out",
                             "m10-structural.out",
                             "m11-structural.out",
                             "m12-structural.out",
                             "m13-structural.out",
                             "m15-indirect.out",
                             "m18-1_factor-2_groups-weak.out",
                             "m19-1_factor-2_groups-strong.out",
                             "m20-1_factor-2_groups-strict.out",
                             "m22-1_factor-3_groups-weak.out",
                             "m23-1_factor-3_groups-strong.out",
                             "m24-1_factor-3_groups-strict.out",
                             "m26-1_factor-4_groups-weak.out",
                             "m27-1_factor-4_groups-strong.out",
                             "m28-1_factor-4_groups-strict.out",
                             "m30-1_factor-5_groups-weak.out",
                             "m31-1_factor-5_groups-strong.out",
                             "m32-1_factor-5_groups-strict.out",
                             "m34-5_factors-5_groups-weak.out",
                             "m35-5_factors-5_groups-strong.out",
                             "m36-5_factors-5_groups-strict.out")

## Model Specifications for the Child Models
mplusOutRef[ , "ChildSpec"] <- c("2 Factors_2 Indicators_Factor Correlation Fixed 0",
                                 "2 Factors_3 Indicators_Factor Correlation Fixed 0",
                                 "2 Factors_5/6 Indicators_Factor Correlation Fixed 0",
                                 "3 Factors_5/6/9 Indicators_ 1 Factor Correlation Fixed 0",
                                 "3 Factors_5/6/9 Indicators_2 Factor Correlations Equated",
                                 "3 Factors_2 IVs 1 DV_IVs Correlation Fixed 0_Regressive Paths Free",
                                 "3 Factors_2 IVs 1 DV_IVs Correlation Free_Regressive Paths Equated",
                                 "3 Factors_2 IVs 1 DV_IVs Correlation Fixed 0_Regressive Paths Equated",
                                 "3 Factors_2 IVs 1 DV_IVs Correlation and _Regressive Paths Equated",
                                 "3 Factors_1 IV 1 DV 1 ME_Direct Path Fixed Zero",
                                 "1 Factor_2 Groups_weak",
                                 "1 Factor_2 Groups_strong",
                                 "1 Factor_2 Groups_strict",
                                 "1 Factor_3 Groups_weak",
                                 "1 Factor_3 Groups_strong",
                                 "1 Factor_3 Groups_strict",
                                 "1 Factor_4 Groups_weak",
                                 "1 Factor_4 Groups_strong",
                                 "1 Factor_4 Groups_strict",
                                 "1 Factor-5 Groups_weak",
                                 "1 Factor-5 Groups_strong",
                                 "1 Factor-5 Groups_strict",
                                 "5 Factors-5 Groups_weak",
                                 "5 Factors-5 Groups_strong",
                                 "5 Factors-5 Groups_strict")

## Number of Groups for each Nested Model Comparison
mplusOutRef[ , "groupSize"] <- c(1, 1, 1, 1, 1,
                                 1, 1, 1, 1, 1,
                                 2, 2, 2, 3, 3,
                                 3, 4, 4, 4, 5,
                                 5, 5, 5, 5, 5)

## Total Sample Size for each Nested Model Comparison
## Has to Be Supplied to crmda_difftest When the Number of Groups Greater than 1
mplusOutRef[ , "totalSampleSize"] <- c(9135, 9136, 9137, 9139, 9139,
                                       9139, 9139, 9139, 9139, 9139,
                                       4221, 4221, 4221, 6019, 6019,
                                       6019, 7485, 7485, 7485, 9087,
                                       9087, 9087, 9151, 9151, 9151)

## Inspecting the Mplus Out Reference
mplusOutRef
str(mplusOutRef)

res <- vector("list", length = 25)

for (i in seq_along(rownames(mplusOutRef))) {
    x <- mplusOutRef[i, ]
    if(x["groupSize"] != 1) {
        res[[i]] <- crmda_difftest(file.path(mplusdir, x["parent"]),
                                   file.path(mplusdir, x["child"]),
                                   samplesize = x["totalSampleSize"])    
    } else {
        res[[i]] <- crmda_difftest(file.path(mplusdir, x["parent"]),
                                   file.path(mplusdir, x["child"]))
    }
    res[[i]][["comparison"]] <- mplusOutRef$comparison[[i]]}

names(res) <- mplusOutRef$comparison


## ----comparisons, results = "asis", echo = FALSE, include = FALSE, cache=TRUE, eval = TRUE----
 
tests <- lapply(res, function(x){
    c(x[["comparison"]],
      unlist(x[["R computations"]]),
      x[["Mplus computations"]][[1]])
    })

tests <- do.call("rbind", tests)
tests <- as.data.frame(tests, stringsAsFactors = FALSE)

colnames(tests) <- c("Comparison", "crmda_difftest_T3", "df", "p", "Mplus_DIFFTEST_T3")
tests <- tests[ , c("Comparison", "crmda_difftest_T3", "Mplus_DIFFTEST_T3", "df", "p")]
rownames(tests) <- NULL
tests <- data.frame(tests, stringsAsFactors = FALSE)

tests[ , "Comparison"] <- gsub("\\.", " ", tests[,"Comparison"])
tests[ , "Comparison"] <- gsub("vs", " vs. ", tests[,"Comparison"])

tests[ , "p"] <- as.numeric(tests[,"p"])
tests[ , "p"] <- sprintf("%.3f", tests[,"p"])

tests[ , "crmda_difftest_T3"] <-
    sprintf("%.3f", as.numeric(tests[ , "crmda_difftest_T3"]))

tests[ , "df"] <- sprintf("%.3f", as.numeric(tests[ , "df"]))

comparisonTable <- print(xtable(tests), type = "html", include.rownames = FALSE,
                         file = "tmpout/comparisonTable.html")

## ----printcomp, results = "asis", echo = FALSE, eval=TRUE, dependson='comparisons'----
cat(comparisonTable)

## ----sessionInfo, echo = FALSE-------------------------------------------
sessionInfo()

## ----warnings, echo = FALSE----------------------------------------------
if(!is.null(warnings())){
    print("Warnings:")
    warnings()
}

