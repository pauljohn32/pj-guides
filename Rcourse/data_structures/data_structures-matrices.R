## ----setup, include=FALSE------------------------------------------------
##This Invisible Chunk is required in all CRMDA documents
outdir <- paste0("figures-", "template")
if (!file.exists(outdir)) dir.create(outdir, recursive = TRUE)
knitr::opts_chunk$set(echo=TRUE, comment=NA, fig.path=paste0(outdir, "/p-"))
options(width = 70)

## ------------------------------------------------------------------------
x <- seq(1L, 27L, 1L)
dim(x) <- c(9, 3)
x

## ------------------------------------------------------------------------
rownames(x) <- letters[1:9]
colnames(x) <- paste0("col", 1:3)
x

## ------------------------------------------------------------------------
x <- seq(1L, 27L, 1L)
dim(x) <- c(9, 3)
dimnames(x) <- list(letters[1:9], paste0("col", 1:3))
x

## ------------------------------------------------------------------------
y <- seq(1L, 27L, 1L)
matrix(y, ncol = 3)
y

## ------------------------------------------------------------------------
y <- seq(1L, 27L, 1L)
matrix(y, ncol = 3, dimnames = list(letters[1:9], paste0("col", 1:3)))
y

## ------------------------------------------------------------------------
y <- seq(1L, 27L, 1L)
matrix(y, nrow = 3, byrow = TRUE,
       dimnames = list(paste0("row", 1:3), letters[1:9]))
y

## ------------------------------------------------------------------------
t(x)

## ------------------------------------------------------------------------
x[2 , 3]

## ------------------------------------------------------------------------
x[2, ]

## ------------------------------------------------------------------------
x[ , 3]

## ------------------------------------------------------------------------
x[4, 2:3]

## ------------------------------------------------------------------------
x["b", "col3"]
x["b", ]
x[   , "col3"]

## ------------------------------------------------------------------------
y <- matrix(2, nrow = 9, ncol = 3)
x + y
x -y

## ------------------------------------------------------------------------
y * x
y / x

## ------------------------------------------------------------------------
t(x)

## ----eval=FALSE----------------------------------------------------------
## X %*% Y

## ------------------------------------------------------------------------
set.seed(234234)
Z <- matrix(rnorm(9), ncol = 3)
Z
Zdiag <- diag(Z)
Zdiag

## ------------------------------------------------------------------------
diag(Zdiag)

## ------------------------------------------------------------------------
lower.tri(Z)
lower.tri(Z, diag = TRUE)

## ------------------------------------------------------------------------
Z[lower.tri(Z, diag = TRUE)]

## ------------------------------------------------------------------------
t(x) %*% x

## ------------------------------------------------------------------------
crossprod(x)

## ----eval=FALSE----------------------------------------------------------
## crossprod(X, Z)

## ----eval=FALSE----------------------------------------------------------
## tcrossprod(X)
## ## or
## tcrossprod(X, T)

## ------------------------------------------------------------------------
x2 <- x[ , 2:3]
is.matrix(x2)

## ------------------------------------------------------------------------
x2 <- x[ , 2]
is.matrix(x2)
is.vector(x2)

## ------------------------------------------------------------------------
x3 <- x[ , 2, drop = FALSE]
x3
dim(x3)
is.matrix(x3)

## ------------------------------------------------------------------------
xb <- x["b", ]

## ------------------------------------------------------------------------
dim(x)
dim(xb)

## ------------------------------------------------------------------------
c(1, 2, 3) %*% xb

## ------------------------------------------------------------------------
xb %*% c(1, 2, 3)

## ------------------------------------------------------------------------
outer(c(1,2,3), xb)
## same as
c(1,2,3) %o% xb

## ------------------------------------------------------------------------
c(1,2,3) %*% t(xb)

## ------------------------------------------------------------------------
x23 <- x[ , c(2, 3)]
x23
diag(x23)

## ------------------------------------------------------------------------
x3 <- x[ , 3]
x3
diag(x3)

## ------------------------------------------------------------------------
library(rockchalk)
rho <- lazyCor(c(0.1, 0.2, 0.3, 0.4, 0.5, 0.6))
rho

## ------------------------------------------------------------------------
mysd <- c(10, 20, 30, 100)
Sigma <- lazyCov(Rho = rho, Sd = mysd)
Sigma

## ------------------------------------------------------------------------
mymu <- c(0, 0, 5, 20)
mvrnorm(n = 10, mu = mymu, Sigma = Sigma)

## ----sessionInfo, echo = FALSE-------------------------------------------
sessionInfo()

