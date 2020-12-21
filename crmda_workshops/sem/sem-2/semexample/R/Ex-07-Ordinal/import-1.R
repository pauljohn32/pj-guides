library(kutils)
library(foreign)

ddir <- "../../data"
wdir <- "workingdata"
if(!file.exists(wdir)) dir.create(wdir)

fn <- "hbsc-subset2.zip"
hbsc.files <- unzip(file.path(ddir, fn), exdir = wdir)

wdir <- file.path(wdir, "hbsc-subset2")

hbsc.colnames <- scan(file.path(wdir, "hbsc-subset2-colnames.txt"), what = "character")

hbsc.orig <- read.table(file.path(wdir, "hbsc-subset2.dat"),
                        header = FALSE, col.names = hbsc.colnames,
                        na.strings = c("-999", ".", "NA"))

## keyTemplate <- keyTemplate(hbsc.orig, file = "hbsc-subset-keyTemplate.csv")
library(kutils)
key <- keyImport("hbsc-subset2-key2.csv")

dat <- keyApply(hbsc.orig, key, drop = FALSE, ignoreCase = FALSE, debug = TRUE)

saveRDS(dat, file = file.path(ddir, "hbsc.rds"))
