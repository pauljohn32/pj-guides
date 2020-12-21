## Paul Johnson <pauljohn@ku.edu>
## March 9, 2011

## An R speed question arose recently in R-devel email list.
## Does the explicit use of name spaces, as in
##  base::print
## make programs run slower than just
##  print
##? 

## And, if it is slow for R to look up functions in their furthermore, if it is true it is slow to use
## base::print, could we cache the "function lookup"

## Dominick Sampieri said yes, "::" is slower:
## "
##  Since the resolution of myPkg::foo() occurs at runtime (via a function
##  call) instead
##  of at compile time (as it would in C++), this practice can introduce a
##  significant
##  performance hit. This can be avoided by doing something like:
##  mylocalfunc <- myPkg::foo
##  [tight loop that uses mylocalfunc repeatedly]
## "

## Several people wondered "can that possibly be right?"
## and evidence that it might be was offered by
## Hadley Wickham, Feb 16, 2011 r-devel
## "
## > system.time(replicate(1e4, base::print))
##   user  system elapsed
##  0.539   0.001   0.541
## > system.time(replicate(1e4, print))
##   user  system elapsed
##  0.013   0.000   0.012

## So it is (relatively) significant, although it's not going to make an
## impact unless you're doing thousands of function calls.
## "

## There's a methodology problem here, since Hadley was using
## "replicate", and that imposes some overhead by itself (the time to
## find replicate is counted as well.

## Olaf Mersmann (Feb 16, 2011 r-devel) pointed that out, and that
## difference caused by "::" is actually more dramatic.
## Olaf described his package "microbenchmark" 
## "
## Using this package I get:

## > library("microbenchmark")
## > res <- microbenchmark(print, base::print, times=10000)
## > res
## Unit: nanoeconds  ## I've fixed the typo, but not pushed to CRAN
##              min    lq  median    uq     max
## print          57    65    68.0    69   48389
## base::print 41763 43357 44278.5 48403 4749851

## A better way to look at this is by converting to evaluations per second:

## > print(res, unit="eps")
## Unit: evaluations per second
##                    min          lq      median          uq        max
## print       17543859.65 15384615.38 14705882.35 14492753.62 20665.8538
## base::print    23944.64    23064.33    22584.32    20659.88   210.5329

## Resolving 23000 names per second or ~15M ist quite a dramatic
## difference in my world.

## So, it appears there is a HUGE HUGE difference beween calling
## "print" and "base::print".

## What does that mean for me, and my students who want to run simulations?

## The only thing I'm sure of is that chasing speedups is a very
## frustrating exercise. 


## Lets repeat this exercise, but actually make some calculations,
## instead of calling a function that does nothing.

x <- rnorm(20)
y <- rnorm(20)

system.time(replicate(1e4, stats::lm(y~x)))

system.time(replicate(1e4, lm(y~x)))

###. Hmm. Not so much difference.

library(microbenchmark)

mb1 <- microbenchmark( lm(y~x), stats::lm(y~x), times=1e4)

mb1

print(mb1, unit="eps")

mylm1 <- function(x,y) mod1 <- stats::lm(y~x)
mylm2 <- function(x,y) mod2 <- lm(y~x)

mb2 <- microbenchmark( mylm1(x,y), mylm2(x,y), stats::lm(y~x), lm(y~x), times=1e4)

print(mb2, unit="eps")
##Hmm. hardly any difference

localLm <- stats::lm

localLm(y~x)


mb3 <- microbenchmark(stats::lm(y~x), localLm(y~x) , times=1e4)
print(mb3, unit="eps")

localLm.fit <- stats::lm
xmat <- cbind(1,x)

mb4 <- microbenchmark(stats::lm.fit(xmat,y), lm.fit(xmat,y) , times=1e4)
print(mb4, unit="eps")




t1_start <- Sys.time()
lst1 <- vector("list", 1e4)
for( i in 1:1e4) {
     mod1 <- stats::lm(y~x)
     lst1[i] <- mod1
   }
t1_stop <- Sys.time()   
print(sprintf("for loop, Lots of lookups took %6.2f seconds", t1_stop - t1_start))


t1_start <- Sys.time()
lst1 <- vector("list", 1e4)
for( i in 1:1e4) {
     mod1 <- stats::lm(y~x)
     lst1[i] <- mod1
   }
t1_stop <- Sys.time()   
print(sprintf("for loop, Lots of lookups took %6.2f seconds", t1_stop - t1_start))



t2_start <- Sys.time()
lst2 <- list()
myLm <- stats::lm
 for( i in 1:1e4){
  mod2 <- myLm(y ~ x) 
}
t2_stop <- Sys.time()           
print(sprintf("Cached lookup took %6.2f seconds", t2_stop - t2_start))






t0_start <- Sys.time()   
for( i in 1:10000) {
     x <- rnorm(100)
     y <- rnorm(100)
     mod1 <- lm(y~x)
   }
t0_stop <- Sys.time()   
print(sprintf("lm took %6.2f seconds", t0_stop - t0_start))




t1_start <- Sys.time()   
for( i in 1:10000) {
     x <- rnorm(100)
     y <- rnorm(100)
     mod1 <- stats::lm(y~x)
   }
t1_stop <- Sys.time()   
print(sprintf("Lots of lookups took %6.2f seconds", t1_stop - t1_start))



t2_start <- Sys.time()           
myLm <- stats::lm
 for( i in 1:10000){
  x <- rnorm(100)
  y <- rnorm(100)
  mod2 <- myLm(y ~ x) 
}
t2_stop <- Sys.time()           

print(sprintf("Cached lookup took %6.2f seconds", t2_stop - t2_start))



The timings obtained by

## >  system.time(replicate(1e4, base::print))
##       User      System verstrichen
##      0.475       0.006       0.483
## >  system.time(replicate(1e4, print))
##       User      System verstrichen
##      0.011       0.001       0.014

## are skewed by the overhead of replicate() in this case because the
## execution time of the expression under test is so short.
## 
