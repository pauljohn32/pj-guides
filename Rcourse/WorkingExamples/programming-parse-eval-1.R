## Paul Johnson <pauljohn@ku.edu>
## 2012-01-30

## Special thanks to r-help email list contributors,
## especially Henrik Bengtsson.  Observe meaning of "parse"
## and eval.  parse creates an expression, from the "text"
## we type in. eval convertst that to results.

x1 <- "rgamma(10, shape = 3, scale = 2)"
class(x1)

eval(x1)

x1.parsed <- parse(text = x1)
class(x1.parsed)
eval(x1.parsed)

## Get it? x1 is a character string we type in.
## parse converts that to a format that R understands.

## Now, embed a text character variable inside a matrix
## that is filled with character strings..

BM <- matrix("0.1", 5, 5)

BM[2,1] <- "a"
BM[3,2] <- "b"

BM

parseAndEval <- function(x, ...) eval(parse(text=x))

a <- 0.5
b <- 0.4

realBM <- apply(BM, MARGIN=c(1,2), FUN=parseAndEval)

BM[4,5] <- "rnorm(1, m=7, sd=1)"

BM

realBM <- apply(BM, MARGIN=c(1,2), FUN=parseAndEval)

realBM

## Now, what about gui interaction with that table?
## The best "nice looking" options are not practical at the moment.

## Try this instead

data.entry(BM)

## That will work on all platforms, so far as I know, without
## any special effort from us.     Run that, make some changes, then
## make sure you insert new R variables to match in your environment.

## Suppose you inserted the letter z in there somewhere. Go do that.

BM[1,1] <- "z"

BM
## z's just a letter in the character matrix. It is not defined yet.

## set z out here

z <- rpois(1, lambda=10)


realBM <- apply(BM, MARGIN=c(1,2), FUN=parseAndEval)
realBM
