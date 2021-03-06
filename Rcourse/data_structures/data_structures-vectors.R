## ----setup, include=FALSE------------------------------------------------
##This Invisible Chunk is required in all CRMDA documents
outdir <- paste0("figures-", "template")
if (!file.exists(outdir)) dir.create(outdir, recursive = TRUE)
knitr::opts_chunk$set(echo=TRUE, comment=NA, fig.path=paste0(outdir, "/p-"))
options(width = 70)

## ------------------------------------------------------------------------
x <- c(13, 2, 33, 4, 35)

## ------------------------------------------------------------------------
x

## ------------------------------------------------------------------------
y <- 5
is.vector(y)

## ------------------------------------------------------------------------
identical(y[1], y)

## ------------------------------------------------------------------------
x[1]
x[5]

## ------------------------------------------------------------------------
x[c(3, 4, 5)]

## ------------------------------------------------------------------------
indx <- c(2, 4)
x[indx]

## ------------------------------------------------------------------------
x[-4]
x[c(-3,-4)]

## ------------------------------------------------------------------------
indx <- c(TRUE, FALSE, FALSE, TRUE, FALSE)
x[indx]

## ------------------------------------------------------------------------
xgt0 <- x > 0
x2 <- x[xgt0]
x2

## ------------------------------------------------------------------------
x2 <- x[x>0]
x2

## ------------------------------------------------------------------------
xwh <- which(x > 0)
x[xwh]
                                        #or
x[which(x > 0)]

## ------------------------------------------------------------------------
x1 <- c(33, 22)
x2 <- c(55.1, 55, 58, 11, 12)
x3 <- c(x1, x2)
x3

## ------------------------------------------------------------------------
z <- c("beta0" = 0.1, "beta1" = 1.1, "beta2" = 0.04)

## ------------------------------------------------------------------------
z2 <- c(0.1, 1.1, 0.04)
names(z2) <- c("beta0", "beta1", "beta2")
z2

## ------------------------------------------------------------------------
z2 <- c(0.1, 1.1, 0.04)
names(z2) <- paste0("beta", 0:2)
z2

## ------------------------------------------------------------------------
z["beta0"]

## ------------------------------------------------------------------------
unname(z)

## ------------------------------------------------------------------------
x <- c(5L, 10L, 15L, 20L, 25L, 30L)
y <- seq(5L, 30L, 5L)
x == y

## ------------------------------------------------------------------------
identical(x, y)

## ------------------------------------------------------------------------
x <- integer(5)
## same as
## x <- vector(mode = "integer", length = 5)

## ------------------------------------------------------------------------
x[1] <- 13L
x[2] <- 2L
x[3] <- 33L
x[4] <- 4L
x[5] <- 35L

## ------------------------------------------------------------------------
is.integer(x)

## ------------------------------------------------------------------------
x <- integer(5)
x[1] <- 13
x[2] <- 2
x[3] <- 33
x[4] <- 4
x[5] <- 35
is.integer(x)

## ------------------------------------------------------------------------
x <- c(13, 2, 33, 4, 35)
x <- as.integer(x)

## ------------------------------------------------------------------------
x <- c(13, 2, 33, 4, 35.0001)
x <- as.integer(x)
x

## ------------------------------------------------------------------------
x <- 5
y <- c(4L, 5L, 6L)
x == y

## ------------------------------------------------------------------------
z <- c(4, 5, 6)
y == z

## ------------------------------------------------------------------------
identical(y, z)

## ------------------------------------------------------------------------
x <- pi*(1/4 + 1:10)
xtan <- tan(x)
## Looks like integers
xtan
is.integer(xtan)
xtan == 1L

## ------------------------------------------------------------------------
zapsmall(xtan) == 1L

## ------------------------------------------------------------------------
x3 <- c(1, 2, 3, "NA", 5)

## ------------------------------------------------------------------------
is.integer(x3)
is.double(x3)
is.character(x3)
x3

## ------------------------------------------------------------------------
x4 <- c(1, 2, 3, NA, 5)
is.character(x4)
x4
is.na(x4)

## ------------------------------------------------------------------------
x4missing <- is.na(x4)
x4missing == 1

## ------------------------------------------------------------------------
x1 <- 1:10
3 * x1
log(x1)
sqrt(x1)
exp(x1)

## ------------------------------------------------------------------------
x2 <- 55:64
x1 + x2
x2 - x1
0.1 * x2 - x1

## ------------------------------------------------------------------------
set.seed(234234)
x <- rnorm(10)
head(x)
is.vector(x)
is.double(x)

## ------------------------------------------------------------------------
xgt0 <- x > 0
head(xgt0)
is.logical(xgt0)

## ------------------------------------------------------------------------
x1 <- 1:5
x2 <- seq(100, 180, by = 20)
X <- cbind(x1, x2)
X

## ------------------------------------------------------------------------
class(X)

## ------------------------------------------------------------------------
x1 <- c(1, 2, 3, "NA", 5)
x2 <- seq(100, 180, by = 20)
X <- cbind(x1, x2)
X
mode(X)

## ------------------------------------------------------------------------
x1 <- c(1, 2, NA)
x2 <- seq(100, 180, by = 20)
X <- cbind(x1, x2)
X

## ------------------------------------------------------------------------
x <- c(1, 2, 3)
y <- c(4, 5, 6)

## ------------------------------------------------------------------------
rbind(x, y)

## ------------------------------------------------------------------------
c(x, y)

## ------------------------------------------------------------------------
x <- c(10, 11, 12, 13, 14, 15, 16)
x
xt <- t(x)
xt
class(xt)

## ------------------------------------------------------------------------
x <- c(TRUE, FALSE, FALSE, TRUE)
is.logical(x)
as.character(x)
as.integer(x)

## ------------------------------------------------------------------------
x <- c(TRUE, FALSE, FALSE, TRUE)
z <- as.numeric(x)
z
is.integer(z)
is.double(z)

## ------------------------------------------------------------------------
x <- c(TRUE, FALSE, FALSE, TRUE)
z <- as.integer(x)
z
is.numeric(z)
is.double(z)

## ------------------------------------------------------------------------
x1 <- 1:10
is.integer(x1)
x2 <- seq(1L, 10L, 1L)
identical(x1, x2)

## ----sessionInfo, echo = FALSE-------------------------------------------
sessionInfo()

