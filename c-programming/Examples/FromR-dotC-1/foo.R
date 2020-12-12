## Paul E. Johnson <pauljohn@ku.edu>
## 2012-11-17
## Extensions from C Geyer's fine writeup http://users.stat.umn.edu/~geyer/rc/
## 2015-11-30
## Error corrected in foo2.

##
## Command line: run
## R CMD SHLIB foo.c

dyn.load("foo.so")
.C("foo", n = as.integer(5), x = as.double(rnorm(5)))

## What? Huh? What is that?
huh <- .C("foo", n = as.integer(5), x=as.double(rnorm(5)))

str(huh)

n1 <- as.integer(5)
set.seed(12345)
noise1 <- rnorm(5)
x1 <- as.double(noise1)

huh2 <- .C("foo", n = n1, x = x1)

huh2

## I'm starting to get it. The "return" thing from
## .C is just the collection the argument variables,
## which were passed to the C function and some were
## changed.

cbind(n1, huh2$n, x1, huh2$x, x1^2)

## That works, but its somewhat rude to leave it out
## like that. So most experts would say we need to
## wrap it in a function.

foo <- function(n) {
    if (!is.numeric(n))
        stop("argument x must be numeric")
    n1 <- as.integer(n)
    x1 <- as.double(rnorm(n))
    print(x1)
    out <- .C("foo",
              n = n1,
              x = x1)
    return(cbind("x" = x1, "xsq" = out$x))
}

set.seed(12345)
foo(6)

## By default, .C will duplicate the input vectors
## and work on them before returning. So it cannot
## damage the data that did exist in the calling R code.
## Warnings in ?.C are strong, but in this simple
## example, I've not re-produced any dangerous side-effects.
## But this example is so simple, maybe it is impossible here.

foo2 <- function(n) {
    if (!is.numeric(n))
        stop("argument x must be numeric")
    n1 <- as.integer(n)
    x <- as.double(rnorm(n))
    print(x)
    out <- .C("foo",
              n = n1,
              x = x, dup = FALSE)
    cbind("x" = x, "xsq" = out$x)
}

set.seed(12345)
foo2(6)
