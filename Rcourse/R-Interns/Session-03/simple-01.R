
library(gdata)

read.xls("simple-01.xlsx", header = TRUE)
dat <- read.xls("simple-01.xlsx", header = TRUE)
str(dat)
dat <- read.xls("simple-01.xlsx", header = TRUE, sheet = 1)

