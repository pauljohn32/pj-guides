#!/usr/bin/Rscript

# Paul Johnson <pauljohn@ku.edu> 2017-06-25

  
CRAN <- "http://rweb.crmda.ku.edu/cran"
KRAN <- "http://rweb.crmda.ku.edu/kran"
BIOC <- "http://www.bioconductor.org/packages/3.3/bioc"


options(repos = c(KRAN, CRAN, BIOC))


#update everything, important to checkBuilt
update.packages(ask = FALSE, checkBuilt = TRUE)

## List other things we may not have yet

A <- c("BH", "Rcpp", "RcppArmadillo", "RcppEigen", "Rcmdr", "car",
       "rgl", "gdata", "gmodels", "TeachingDemos", "plotrix",
       "ggplot2", "plotmo")

## Structural Equations
B <- c("sem", "lavaan", "lavaan.survey", "lava", "MplusAutomation")

## General purpose, widely used

C <- c("car", "memisc","rms","Hmisc", "survey", "psych", "openxlsx")

## Regression

D <- c("betareg", "segmented", "lme4", "MEMSS", "languageR", "gamm4",
       "glmmBUGS", "influence.ME", "ineq", "lmec","lmm",
       "lmerTest", "longitudinal", "plm", 
       "longitudinalData", "MCMCglmm","MCPAN", "MEMSS", "flexmix",
       "quantreg", "glmmML", "eha", "systemfit", "VGAM", "rockchalk",
       "sandwich", "scatterplot3d", "mediation", "glmnet", "gam",
       "acepack", "rstan", "BMA", "colorspace", "curl", "DBI",
       "DCluster", "distr", "emplik", "emdbook")

## Flexible Curves

E <- c("tree","mda","earth", "lars", "locfit", "pspline", "np", "dse",
       "akima", "aod", "gee", "geepack", "cslogistic")

## Missing Data

F <- c("norm", "Amelia", "mix", "pan", "mice", "mitools", "VIM", "mi")

## Variable selection

G <- c("stepwise","subselect", "leaps", "caret", "bestglm", "relimp",
       "party", "multcomp", "strucchange", "SoDA", "sna", "roxygen2" )


## Specialized Regression

H <- c("Zelig","pscl","wnominate", "dlm")

## Etc

I <- c("rlecuyer", "biglm", "roxygen2", "plyr", "reshape2", "zoo",
       "texreg", "tables", "maps", "maptools", "markdown",
       "microbenchmark", "RCurl", "Matching", "MatchIt", "knitr",
       "formatR", "coda", "data.table", "copula", "xtable", "igraph",
       "statnet", "network", "kutils", "tidyverse", "RPostgreSQL")

## A bunch of others that will probably be required by previous:
J <- c("abind", "actuar", "ade4", "ade4TkGUI", "adegraphics",
       "adehabitat", "ADGofTest", "AER", "AGD", "alr3", "amap", "ape",
       "aplpack", "arm", "assertthat", "backports", "base64",
       "base64enc", "bayesm", "bayesmix", "BB", "bbmle", "bcp",
       "bdsmatrix", "BH", "bit", "bit64", "bitops", "BMA", "bnlearn",
       "BradleyTerry2", "brew", "brglm", "Cairo", "cairoDevice",
       "caTools", "cellranger", "censReg", "checkmate", "chron",
       "clue", "clv", "cocorresp", "coin", "colorspace", "combinat",
       "commonmark", "corpcor", "coxme", "crayon", "cubature",
       "Cubist", "curl", "d3Network", "DBI", "DCluster", "deldir",
       "denstrip", "DEoptimR", "desc", "descr", "DescTools",
       "Devore7", "dfoptim", "dichromat", "digest", "diptest",
       "distr", "doBy", "doParallel", "dplyr", "e1071", "Ecdat",
       "Ecfun", "ecodist", "effects", "eiPack", "ellipse", "emdbook",
       "emplik", "ENmisc", "evaluate", "expint", "expm", "faraway",
       "fastmatch", "fda", "fdrtool", "ffmanova", "fftw", "fields",
       "fImport", "foreach", "Formula", "forward", "gamlss",
       "gamlss.data", "gamlss.dist", "gbm", "gclus", "geoR",
       "geoRglm", "ggm", "glasso", "glmc", "goftest", "GPArotation",
       "gpclib", "gplots", "gridBase", "gridExtra", "grpreg", "gsl",
       "gsubfn", "gtable", "gtools", "hexbin", "highr", "HistData",
       "htmlTable", "htmltools", "htmlwidgets", "httpuv", "huge",
       "HyperbolicDist", "imputeR", "influenceR", "inline", "iplots",
       "irlba", "Iso", "ISwR", "iterators", "its", "JavaGD", "JGR",
       "jpeg", "jsonlite", "Kendall", "kinship2", "labeling",
       "laeken", "latticeExtra", "lazyeval", "LearnBayes",
       "lisrelToR", "lmeSplines", "lmtest", "logspline", "lpSolve",
       "ltm", "magic", "magrittr", "manipulate", "matrixcalc",
       "MatrixModels", "maxLik", "maxlike", "MBESS", "mboost",
       "mcgibbsit", "mclust", "mcmc", "MCMCpack", "memoise",
       "micEcon", "mime", "minqa", "misc3d", "miscTools", "mlbench",
       "mlmRev", "mlogit", "mnormt", "MNP", "ModelMetrics",
       "modeltools", "MPV", "msm", "mstate", "MuMIn", "munsell",
       "mvbutils", "mvnormtest", "mvProbit", "mvtnorm", "nloptr",
       "NMF", "nnls", "nor1mix", "numDeriv", "nws", "OpenMx",
       "openssl", "optextras", "optimx", "ordinal", "orthopolynom",
       "pander", "partDSA", "PASWR", "pbivnorm", "pbkrtest",
       "PBSmapping", "pcaPP", "PerformanceAnalytics", "permute",
       "pixmap", "pkgmaker", "PKPDmodels", "plogr", "pls", "png",
       "polspline", "polyclip", "polycor", "polynom", "PolynomF",
       "ppcor", "praise", "profileModel", "proto", "proxy", "pryr",
       "qgraph", "quadprog", "quantmod", "R2HTML", "R2jags",
       "R2OpenBUGS", "R2WinBUGS", "R6", "RandomFields",
       "RandomFieldsUtils", "randomForest", "RANN", "raster",
       "rasterVis", "rattle", "rbugs", "Rcgmin", "RcmdrMisc",
       "RColorBrewer", "Rcpp", "RcppArmadillo", "RcppEigen",
       "Rd2roxygen", "rda", "readxl", "registry", "rematch",
       "reshape", "rgenoud", "RGtk2", "ridge", "rJava", "rjson",
       "rmarkdown", "rngtools", "robustbase", "RODBC", "rpanel",
       "rpart.plot", "rpf", "rprojroot", "rrcov", "RSQLite",
       "rstudioapi", "RSvgDevice", "rtiff", "RUnit", "Rvmmin",
       "SASmixed", "scales", "SemiPar", "semPlot", "semTools",
       "sendplot", "setRNG", "sets", "sfsmisc", "shapefiles", "shiny",
       "simsem", "sm", "smoothSurv", "snow", "sourcetools", "sp",
       "spam", "SparseM", "spatialCovariance", "spatialkernel",
       "spatstat", "spatstat.utils", "spdep", "splancs", "stabledist",
       "stabs", "StanHeaders", "startupmsg", "StatDataML", "statmod",
       "statnet.common", "stringi", "stringr", "SuppDists", "svUnit",
       "SweaveListingUtils", "tcltk2", "tensor", "tensorA",
       "testthat", "tfplot", "tframe", "TH.data", "tibble",
       "timeDate", "timeSeries", "tis", "tkrplot", "trimcluster",
       "trust", "tseries", "TTR", "ucminf", "urca", "UsingR", "vcd",
       "vegan", "vioplot", "viridis", "viridisLite", "visNetwork",
       "waveslim", "whisker", "XLConnect", "XLConnectJars", "XML",
       "xml2", "xts", "yaml", "zipfR")




desiredPackages <- unique(c(A, B, C, D, E, F, G, H, I, J))

## list of all currently installed packages

installedPackages <- rownames (installed.packages() )

# TRUE/FALE indicator for each desiredPackage
alreadyHave <- desiredPackages %in% installedPackages

## Alert
##
## This will install packages into the "default" place. Depending
## on your OS and if you are an administrator, they may end up someplace
## you don't exect. If you run this, and your are admin on Windows,
## it will install packages under the R folder in 'C:\Program Files',
## which is generally what I want. However, if you want to control
## where they go, then don't run next line, and edit the LIB statement
## and run stanza after this

if (sum(!alreadyHave) > 0) install.packages(desiredPackages[!alreadyHave],
                                            dependencies=c("Imports","LinkingTo","Depends"))

## If previous not match your system need, run this:
## LIB <- "/usr/share/R/library"
## if (sum(!alreadyHave) > 0) install.packages(desiredPackages[!alreadyHave],
##                                            dependencies=c("Imports","LinkingTo","Depends"),
##	 lib = LIB)

