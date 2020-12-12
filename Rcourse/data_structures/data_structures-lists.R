## ----setup, include=FALSE------------------------------------------------
##This Invisible Chunk is required in all CRMDA documents
outdir <- paste0("tmpout")
if (!file.exists(outdir)) dir.create(outdir, recursive = TRUE)
knitr::opts_chunk$set(echo=TRUE, comment=NA, fig.path=paste0(outdir, "/p-"))
options(width = 70)

## ------------------------------------------------------------------------
mylist <- list("x" = c(1, 2, 3), "y" = matrix(rnorm(16), 4), "z" = "Paul")
names(mylist)
length(mylist)

## ------------------------------------------------------------------------
nonamelist <- list(c(1, 2, 3),  matrix(rnorm(16), 4), "Paul")
length(nonamelist)
nonamelist

## ------------------------------------------------------------------------
names(nonamelist)

## ------------------------------------------------------------------------
unname(mylist)

## ------------------------------------------------------------------------
names(mylist) <- NULL
mylist

## ------------------------------------------------------------------------
names(mylist) <- c("x", "y", "z")

## ------------------------------------------------------------------------
mylist2 <- mylist[c(1,3)]
mylist2
class(mylist2)
length(mylist2)

## ------------------------------------------------------------------------
mymat1 <- mylist[["y"]]
mymat1
class(mymat1)

## ------------------------------------------------------------------------
mymat2 <- mylist[[2]]
mymat2
class(mymat2)
identical(mymat1, mymat2)

## ------------------------------------------------------------------------
mylist1 <- list()

## ------------------------------------------------------------------------
mylist2 <- vector(mode = "list", length = 6)

## ------------------------------------------------------------------------
x1 <- c(1, 2, 3)
x2 <- matrix(rnorm(9), ncol = 3)
mylist1[[1]] <- x1
mylist1[["x1"]] <- x1
mylist1[[3]] <- x1

## ------------------------------------------------------------------------
mylist1
mylist1[["x1"]]
mylist1[[2]]

## ------------------------------------------------------------------------
mylist1[[6]] <- x2
mylist1

## ------------------------------------------------------------------------
mylist2[[1]] <- x1
mylist2[["x1"]] <- x1
mylist2[[3]] <- x1
mylist2

## ------------------------------------------------------------------------
mylist2[[6]] <- x2
mylist2

## ------------------------------------------------------------------------
# only insert names for 6th and 7th items:
names(mylist2)[6:7] <- c("x1", "x2")
mylist2
names(mylist2)

## ------------------------------------------------------------------------
alist <- list()
system.time(
for(i in 1:10000){
    alist[[i]] <- matrix(rnorm(9), ncol = 3)
})

alist2 <- vector("list", 10000)
system.time(
for(i in 1:10000){
    alist2[[i]] <- matrix(rnorm(9), ncol = 3)
})

## ------------------------------------------------------------------------
mylist3 <- vector(mode = "list", length = 10)
names(mylist3) <- paste0("mod", 1:10)
mylist3

## ------------------------------------------------------------------------
set.seed(234234)
mdg <- function(N = 100, beta = c(0.1, 0.3, 0.1), stde = 7)
{
    e <- rnorm(N, m = 0, sd = stde)
    ## oops, don't know parm for predictors
    x1 <- rnorm(N, m = 40, sd = 10)
    x2 <- rnorm(N, m = 20, sd = 40)
    y <- beta[1] + beta[2] * x1 + beta[3] * x2 + e
    invisible(data.frame(x1, x2, y))
}

for (i in 1:10){
    adf <- mdg()
    amodel <- lm(y ~ x1 + x2, data = adf)
    mylist3[[paste0("mod", i)]] <- summary(amodel)
}

## ------------------------------------------------------------------------
mylist3[[7]]
class(mylist3[[7]])

## ------------------------------------------------------------------------
lapply(mylist3, class)

## ------------------------------------------------------------------------
for(i in seq_along(mylist3)){
    print(class(mylist3[[i]]))
}

## ------------------------------------------------------------------------
lapply(mylist3, print, digits = 10)

## ------------------------------------------------------------------------
coeflist <- lapply(mylist3, coef)
coeflist[1:3]

## ------------------------------------------------------------------------
pvallist <- lapply(mylist3, function(x){
    mycoefs <- coef(x)
    pvals <- mycoefs[ , "Pr(>|t|)"]
    pvals
})
pvallist

## ------------------------------------------------------------------------
sapply(mylist3, function(x){
    mycoefs <- coef(x)
    pvals <- mycoefs[ , "Pr(>|t|)"]
    pvals
    })

## ------------------------------------------------------------------------
vapply(mylist3, function(x){
    mycoefs <- coef(x)
    pvals <- mycoefs[ , "Pr(>|t|)"]
    pvals
    }, FUN.VALUE = numeric(3))

## ------------------------------------------------------------------------
rsq <- vapply(mylist3, function(x){
    x$r.square
}, FUN.VALUE = numeric(1))
rsq

## ----fig=TRUE------------------------------------------------------------
hist(rsq, main = "R Square is the only thing I care about",
     xlab = expression(R^2), prob = TRUE)

## ------------------------------------------------------------------------
alist <- list(1:4, 32:44, rnorm(10))
avec <- unlist(alist)
avec
class(avec)

## ------------------------------------------------------------------------
alist <- list(1:4, 32:44, c("Paul", "Joe"))
avec <- unlist(alist)
avec
class(avec)

## ------------------------------------------------------------------------
nonamelist[[3]] <- NULL
nonamelist

## ----sessionInfo, echo = FALSE-------------------------------------------
sessionInfo()

