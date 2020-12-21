library(kutils)

wdir <- "../workingdata"
ddir <- "../data"

hbsc <- read.table(file.path(ddir, "hbsc-subset2.dat"),
                   header = FALSE, na.strings = c("-999", " "),
                   stringsAsFactors = FALSE) 
cnames <- scan(file.path(ddir, "hbsc-subset2-colnames.txt"))

hbsc.colnames <- scan(file.path(ddir, "hbsc-subset2-colnames.txt"), what = "character")
hbsc.orig <- read.table(file.path(ddir, "hbsc-subset2.dat"),
                        header = FALSE, col.names =  hbsc.colnames,
                        na.strings = c("-999", ".", "NA"))

key <- keyTemplate(hbsc.orig)

keySave(key, file = "hbsc-subset2-pj20171011.xlsx")
