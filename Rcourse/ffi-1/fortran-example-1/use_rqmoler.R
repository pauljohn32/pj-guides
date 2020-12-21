## Paul Johnson <pauljohn@ku.edu>
## 2015-11-30

## Fortran code usage example
## John Nash, Nonlinear Parameter Optimization in R, p. 245-247

## Problem: find the largest eigenvalue of a symmetric matrix.

## Should we use R's own eigen function, which finds all eigen values?
## or
## Can we find just the largest one, doing less calculation, more
## quickly?

## Nash shows pp 243-245 various R codings of this calculation. Eigen
## solutions of the Moler matrix.

## Typed by Paul Johnson, who is responsile for errors
library(optimx)


dyn.load("rqmoler.so")
## InWindows dyn.load("rqmoler.dll")
cat("Is the Fortran RQ function loaded?", is.loaded('rqmoler'), "\n")

frqmoler <- function(x) {
    n <- length(x)
    rq <- 0
    res <- .Fortran ("rqmoler" , n = as.integer(n) , x = as.double(x),
                      rq = as.double(rq))
    res$rq
}

nfrqmoler <- function(x) {
    (-1) * frqmoler( x)
}

n <- 200
x <- rep(1, n)


tcgrf <- system.time(amaxi <- optimx(x, fn = nfrqmoler, method = "Rcgmin",
                                     control = list (usenumDeriv = TRUE,
                                                     kkt = FALSE, trace = 1 )))
tcgrf
amaxi



## What are the alternatives?

## p. 243
molermat <- function(n) {
    A <- matrix (NA , nrow = n, ncol = n)
    for (i in 1:n) {
        for (j in 1:n) {
            if (i == j) A[i, i] <- i else A[i, j] <- min(i, j) - 2
        }
    }
    A
}

## Raleigh quotient
rayq <- function(x, A) {
    rayquo <- as.numeric(crossprod(x, crossprod (A, x))/ crossprod (x))
}


system.time((evs  <- eigen(molermat(n))))
## First eigenvector
eigvec <- evs$vectors[ , 1]
## Normalize
eigvec <- sign(eigvec[[1]]) * eigvec/sqrt(as.numeric(crossprod(eigvec)))



A <- molermat(n)
system.time(tr  <- rayq(x = x, A = molermat(n)))

require(microbenchmark)

microbenchmark(evs  <- eigen(molermat(n)))
microbenchmark(tr  <-  rayq(x = x, A = molermat(n)))

## > microbenchmark((evs  <- eigen(molermat(n))))
## Unit: milliseconds
##                         expr     min       lq     mean   median       uq
##  (evs <- eigen(molermat(n))) 80.2936 80.88627 83.46158 81.58662 81.96928
##       max neval
##  133.1473   100
## > microbenchmark(tr  <-  rayq(x = x, A = molermat(n)))
## Unit: milliseconds
##                                expr      min       lq     mean   median
##  tr <- rayq(x = x, A = molermat(n)) 61.72763 64.40108 67.40983 65.20615
##        uq      max neval
##  65.97582 127.6471   100

## > sessionInfo()
## R version 3.2.2 (2015-08-14)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 15.10

## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       

## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     

## other attached packages:
## [1] microbenchmark_1.4-2.1 optimx_2013.8.7       

## loaded via a namespace (and not attached):
##  [1] Rcpp_0.12.2          magrittr_1.5         BB_2014.10-1        
##  [4] splines_3.2.2        MASS_7.3-44          munsell_0.4.2       
##  [7] svUnit_0.7-12        lattice_0.20-33      colorspace_1.2-6    
## [10] quadprog_1.5-5       multcomp_1.4-1       minqa_1.2.4         
## [13] stringr_1.0.0        plyr_1.8.3           tools_3.2.2         
## [16] optextras_2013-10.28 grid_3.2.2           dfoptim_2011.8-1    
## [19] gtable_0.1.2         TH.data_1.0-6        survival_2.38-3     
## [22] digest_0.6.8         numDeriv_2014.2-1    ucminf_1.1-3        
## [25] setRNG_2013.9-1      reshape2_1.4.1       ggplot2_1.0.1       
## [28] codetools_0.2-14     sandwich_2.3-4       stringi_1.0-1       
## [31] compiler_3.2.2       scales_0.3.0         mvtnorm_1.0-3       
## [34] Rcgmin_2013-2.21     Rvmmin_2013-11.12    zoo_1.7-12          
## [37] proto_0.3-10        
## > 
