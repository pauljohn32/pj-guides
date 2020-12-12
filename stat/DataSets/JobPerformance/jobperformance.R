## jobperformance.R
## Paul Johnson <pauljohn@ku.edu>
## 2011-08-23
## 2012-01-09 changed variable names to small case, eliminated extraneous
## calculated variables

dat <- read.table("jobperformance.txt", header=T, sep="\t")



## Create gender factor, rather than female numeric
dat$gender <- factor(dat$female, labels=c("Male","Female"))
table(dat$female, dat$gender)


## Note turnover is not a factor, so convert it into one
dat$turnoverf <- factor(dat$turnover, labels=c("No","Yes"))
## Make sure that's not wrong
table(dat$turnover, dat$turnoverf)

