## Paul Johnson
## 20170531

## The affect.rds to begin is the one saved in
## summeR-3-2. It is overwritten here.

## This only chops out the "constructed sum" variables

dat <- readRDS("../data/affect.orig.rds")
colnames(dat)

dat2 <- dat[ , c(1:16, 25:27)]


saveRDS(dat2, "../data/affect.rds")

write.csv(dat2, file = "../data/affect.csv", row.names = FALSE)


library(lavaan)
moderate.mod1 <- '
Agency =~ Agency1 + Agency2 + Agency3
Positive =~ PosAFF1 + PosAFF2 + PosAFF3
Positive ~ c(a, b)*Agency
'
out.mod1 <- sem(moderate.mod1, data = dat, group = "Sex", group.equal = c("loadings", "intercepts"))
summary(out.mod1)

moderate.mod2 <- '
Agency =~ Agency1 + Agency2 + Agency3
Positive =~ PosAFF1 + PosAFF2 + PosAFF3
Positive ~ c(a, a)*Agency
'
out.mod2 <- sem(moderate.mod2, data = dat, group = "Sex", group.equal = c("loadings", "intercepts"))
summary(out.mod2)

anova(out.mod1, out.mod2)
