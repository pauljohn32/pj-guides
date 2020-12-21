## Chong Xing
## 2017-10-19
## SEM in R - CRMDA Saturday Workshop
## HBSC Demonstration Data Restructure


library(kutils)
list.files(".")

## Reading in the variable names from "hbsc-subset2-colnames.txt"
hbsc.colnames <- scan("./hbsc-subset2-colnames.txt", what = "character")

## Reading in the data file "hbsc-subset2.dat" and adding the variable names
hbsc.orig <- read.table("./hbsc-subset2.dat", header = FALSE, col.names = hbsc.colnames, na.strings = c("-999", ".", "NA"))

## Importing the variable key "hbsc-subset2-key2.csv"
key <- keyImport("./hbsc-subset2-key2.csv")

## Applying the variable key
hbsc <- keyApply(hbsc.orig, key, drop = FALSE, ignoreCase = FALSE)

## Inspecting "hbsc"
names(hbsc)
dim(hbsc)
table(hbsc$Gender)

## Exporting "hbsc" to an .RDS file
saveRDS(hbsc, "hbsc.RDS", ascii = FALSE,
        version = NULL, compress = TRUE,
        refhook = NULL)

## Reading "hbsc.DRS" Back in
dat <- readRDS("hbsc.RDS")
names(dat)
dim(dat)
table(hbsc$Gender)
