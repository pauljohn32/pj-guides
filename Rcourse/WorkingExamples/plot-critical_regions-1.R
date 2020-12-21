## Paul Johnson
## 2014-02-15
## Notes on plotting things in R, starting from Joshua Wiley's example.

## Posted in r-sig-teaching 2011-04-04
## Joshua Wiley
## Ph.D. Student, Health Psychology


## Load in this function's code, then test out with example usages below

PlotDist <- function (alpha, from = -5, to = 5, n = 1000, filename = NULL,
                      alternative = c("two.tailed", "greater", "lesser"), distribution =
                      c("normal","t", "F", "chisq", "binomial"), colour = "black", fill = "skyblue2",
                      ...)
{
  alternative <- match.arg(alternative)
  alt.alpha <- switch(alternative, two.tailed = alpha/2, greater = alpha,
                      lesser = alpha)
  MyDen <- switch(distribution, normal = dnorm, t = dt, F = df,
                  chisq = dchisq, binomial = dbinom)
  MyDist <- switch(distribution, normal = qnorm, t = qt, F = qf,
                   chisq = qchisq, binomial = qbinom)
  crit.lower <- MyDist(p = alt.alpha, lower.tail = TRUE, ...)
  crit.upper <- MyDist(p = alt.alpha, lower.tail = FALSE, ...)
  cord.x1 <- c(from, seq(from = from, to = crit.lower, length.out = 100),
               crit.lower)
  cord.y1 <- c(0, MyDen(x = seq(from = from, to = crit.lower,
                          length.out = 100), ...), 0)
  cord.x2 <- c(crit.upper, seq(from = crit.upper, to = to,
                               length.out = 100), to)
  cord.y2 <- c(0, MyDen(x = seq(from = crit.upper, to = to,
                          length.out = 100), ...), 0)
  if (!is.null(filename)) pdf(file = filename)
  curve(MyDen(x, ...), from = from, to = to, n = n, col = colour,
        lty = 1, lwd = 2, ylab = "Density", xlab = "Values")
  if (!identical(alternative, "greater")) {
    polygon(x = cord.x1, y = cord.y1, col = fill)
  }
  if (!identical(alternative, "lesser")) {
    polygon(x = cord.x2, y = cord.y2, col = fill)
  }
  if (!is.null(filename)) dev.off()
}


### TEST that. Example usage. It is a little bit fun.



PlotDist(alpha = 0.05, alternative = c("two.tailed"), distribution = "normal", colour = "red", fill = "green")
PlotDist(alpha = 0.05, alternative = c("greater"), distribution = "normal")


PlotDist(alpha = 0.05, alternative = c("greater"), distribution = "F", df1 = 10, df2 = 20)

## left edge looks wrong.
PlotDist(alpha = 0.05, alternative = c("greater"), distribution = "F", from = 0, to = 10, df1 = 10, df2 = 20)

##double check the old fashioned way re-consider

x <- seq(0, 2, by = 0.0005)
denx <-df(x, df1 = 10, df2 = 20)
plot(x, denx, type = "l")


##Chi-square interesting
PlotDist(alpha = 0.05, alternative = c("greater"), distribution = "chisq", df = 5, from = 0, to = 50)
PlotDist(alpha = 0.05, alternative = c("greater"), distribution = "chisq", df = 10, from = 0, to = 50)
PlotDist(alpha = 0.05, alternative = c("greater"), distribution = "chisq", df = 20, from = 0, to = 50)




## doesn't work, did not check why. Suspect that a discrete distribution just won't work here.
##
PlotDist(alpha = 0.05, alternative = c("greater"), distribution = "binomial", size = 20, prob = 0.2, from=0, to = 5)


## Paul Johnson 2013-02-20
## 2013-03-14: fixed typo in T distribution




## You can play around with that. I have explored some ways to make it more
## abstract. Nothing below is too awesome, but I work on it from time to time.


## I'd like to re-work that, to make more easily customizable output.

## I'd like to simplify user input. Choosing functions, adding new ones.
##
## I'd like it to guess "to" and "from" for plotting.
##
## Make the distribution chooser ignore capitalization. Users should not get
## rejected if they enter "Chisq" rather than "chisq". And I'd like it to
## work if they enter "chi"
##
## Couldn't users supply legal R name of the q function and we could
## parse the rest of the information from that?  They say distribution
## = qnorm, so we don't need all those switches and other excitements.
## Along the way, I'm using it as an example to debate the use of the
## "..." argument with myself. Oh, and can't I make this less tedious
## to code in additional distributions?  I think most programmers
## would not handle the function call that way. The'd use
##
## do.call(myPDF, list( more-arguments-here ))
##
## I'm a little surprised that the method in PlotDist() works,
## actually.  But it is a reminder that a function is just an object,
## it can be passed about. 
##
## Lets improve the labeling of the output. I'd like the distribution
## types and parameters to be featured in the output.  I also want
## users to be able to pass through more arguments.

## I'm looking at 2 ways to do that. Method 1: The "Brute Force"
## method.  Create a named argument "parms" and scan that. That's my
## first idea, but I don't think it is as good as the dot-dot-dot
## method that Joshua used. So I'll come back to that later. Method 2:
## ballet of the dot-dot-dot argument.

## 1. Revise, calculate "from" and "to" internally if not specified.
## 2. Add Title and xlab
## 3. Create parms argument, a list of values for the distribution
plotDist <-
    function (alpha, to, from,  n = 1000, filename = NULL,
              alternative = c("two.tailed", "greater", "lesser"),
              distribution =  c("normal","t", "F", "chisq", "binomial"),
              parms = list(),
              colour = "black", fill = "skyblue2",
              ...)
{
  alternative <- match.arg(alternative)

  alt.alpha <- switch(alternative, two.tailed = alpha/2, greater = alpha,
                      lesser = alpha)

  myPDF <- switch(distribution, normal = "dnorm", t = "dt", F = "df",
                  chisq = "dchisq", binomial = "dbinom")

  myQ <- switch(distribution, normal = "qnorm", t = "qt", F = "qf",
                   chisq = "qchisq", binomial = "qbinom")
  ## meld together the default parameters I choose with the
  ## list of parms from command line.
  myParms <- switch(distribution,
                    normal = modifyList(list(m = 0, sd = 1), parms),
                    t = modifyList(list(df = 100), parms),
                    F = modifyList(list(df1 = 100, df2 = 100), parms),
                    chisq = modifyList(list(df = 100), parms),
                    binomial = modifyList(list(size = 1, prob = 0.5), parms))

  myName <- switch(distribution,
                   normal = "Normal",
                    t = "T",
                    F = "F",
                    chisq = "chi",
                    binomial = "Binomial")

  myTitle <- switch(distribution,
                    normal = substitute(myName(mu == parm1, sigma^2 == parm2^2), list(myName = myName, parm1 = myParms$m, parm2 = myParms$sd)),
                    t = substitute(myName(nu == parm1), list(myName = as.name(myName), parm1 = myParms$df)),
                    F = substitute(myName(nu[1] == parm1, nu[2] == parm2), list(myName = as.name(myName), parm1 = myParms$df1, parm2 = myParms$df2)),
                    chisq = substitute(myName^2 * (nu == parm1), list(myName = as.name(myName), parm1 = myParms$df)),
                    binomial = substitute(myName(parm1, parm2), list(myName = myName, parm1 = myParms$size, parm2 = myParms$prob)))

  crit.lower <- do.call(myQ, modifyList( list(p = alt.alpha, lower.tail = TRUE, ...), myParms ))
  crit.upper <- do.call(myQ, modifyList( list(p = alt.alpha, lower.tail = FALSE, ...), myParms ))
  ## if (missing(from)) from <- crit.lower - 0.10 *(crit.upper - crit.lower)
  ## if (missing(to)) to <- crit.upper + 0.10 * (crit.upper - crit.lower)

  if (missing(from)) from <- do.call(myQ, modifyList(list(p = 0.001), myParms))
  if (missing(to)) to <- do.call(myQ, modifyList(list(p = 0.999), myParms))
  cord.x1 <- c(from, seq(from = from, to = crit.lower, length.out = 100), crit.lower)
  ##cord.y1 <- c(0, do.call(myPDF,
  ##                        modifyList(list(x = seq(from = from, to = crit.lower,
  ##                                       length.out = 100), ...), myParms)), 0)
  cord.y1 <- c(0, do.call(myPDF, c(list(x = seq(from = from, to = crit.lower,
                                          length.out = 100)), myParms)), 0)

  cord.x2 <- c(crit.upper, seq(from = crit.upper, to = to,
                               length.out = 100), to)

  cord.y2 <- c(0, do.call(myPDF, modifyList(list(x = seq(from = crit.upper, to = to,
                                                 length.out = 100), ...), myParms)), 0)

  if (!is.null(filename)) pdf(file = filename)

  xseq <- seq(from, to, length.out = n)

  probseq <- do.call(myPDF,  modifyList(list(x = xseq, ...), myParms))

  plot(probseq ~ xseq, col = colour, type = "n" ,
       ylab = "Density", xlab = "Values",
       main = myTitle)
  lines(probseq ~ xseq,  lty = 1, lwd = 1)
  lines(x = c(to, from), y = c(0, 0), lty = 3, col = gray(0.80))
  if (!identical(alternative, "greater")) {
      polygon(x = cord.x1, y = cord.y1, col = fill)
  }
  if (!identical(alternative, "lesser")) {
    polygon(x = cord.x2, y = cord.y2, col = fill)
  }
  if (!is.null(filename)) dev.off()
}




plotDist(alpha=0.05, alternative=c("two.tailed"), distribution="normal")

plotDist(alpha=0.05, alternative=c("greater"), distribution="normal")
plotDist(alpha=0.05, alternative=c("greater"), distribution="normal", parms = list(m=-44, sd=19))

plotDist(alpha=0.05, alternative=c("two.tailed"), distribution="t")


plotDist(alpha=0.05, alternative=c("greater"), distribution="chisq")
plotDist(alpha=0.05, alternative=c("greater"), distribution="chisq", parms=list(df = 100))




plotDist(alpha=0.05, alternative=c("two.tailed"), distribution="normal", colour="red", fill="green")

plotDist(alpha=0.05, alternative=c("greater"), distribution="F", parms = list(df1=10, df2=20))

plotDist(alpha=0.05, alternative=c("greater"), distribution="F", parms = list(df1 = 2, df2 = 100))

## left edge looks wrong. But probably right.
plotDist(alpha=0.05, alternative=c("greater"), distribution="F", from=0, to=10, parms = list(df1=10, df2=20))

##double check the old fashioned way re-consider. looks OK
x <- seq(0, 5, by=0.0005)
denx <-df(x, df1=10, df2=20)
plot(x, denx, type = "l", main = "Plotting the F distribution the Old Fashioned Way")


##Chi-square interesting
plotDist(alpha=0.05, alternative=c("greater"), distribution="chisq", parms = list(df = 1), from = 0, to= 10)
plotDist(alpha=0.05, alternative=c("greater"), distribution="chisq", parms = list(df = 10), from = 0, to = 30)
plotDist(alpha=0.05, alternative=c("greater"), distribution="chisq", parms = list(df = 20), from = 0, to = 50)


#doesn't work
plotDist(alpha=0.05, alternative=c("greater"), distribution="binomial", parms = list(size=20, prob=0.2), from = 0, to = 40)






## Method 2. Look at the ... argument, remove the parameters
## that are intended for the distribution object.

## Find out what arguments are accepted by a function and extract
## them from a list (usually, a "dots" list).
## Big Problem: It only finds fully matching argument names, no partials
getDotsFor <- function(fn = NULL, dots = NULL, remove = FALSE){
    matches <- names(dots) %in%  names(formals(fn))
    parms <-  dots[matches]
    if(remove) dots[matches] <<- NULL
    parms
}

dots <- list(a = 6, mean = 13, sd = 44, f = TRUE)

getDotsFor(fn = "rnorm", dots = dots)
getDotsFor(fn = "rnorm", dots = dots, remove = TRUE)



## previous "parms" now in ...

plotDist2  <- function (alpha, to, from,  n = 1000, filename = NULL,
                      alternative = c("two.tailed", "greater", "lesser"),
                      distribution =  c("normal","t", "F", "chisq", "binomial"),
                      colour = "black", fill = "skyblue2",
                      ...)
{
  alternative <- match.arg(alternative)
  alt.alpha <- switch(alternative, two.tailed = alpha/2, greater = alpha,
                      lesser = alpha)
  myPDF <- switch(distribution, normal = "dnorm", t = "dt", F = "df",
                  chisq = "dchisq", binomial = "dbinom")
  myQ <- switch(distribution, normal = "qnorm", t = "qt", F = "qf",
                   chisq = "qchisq", binomial = "qbinom")

  dots <- list(...)

  distParms <- getDotsFor(myQ, dots =  dots, remove = TRUE)
  ## Note: dots now PURGED of arguments for the distribution

  ## For each, set defaults, then replace if alternatives were in ...
  myParms <- switch(distribution,
                    normal = modifyList(list(mean = 0, sd = 1), distParms),
                    t = modifyList(list(df = 100), distParms),
                    F = modifyList(list(df1 = 100, df2 = 100), distParms),
                    chisq = modifyList(list(df = 100), distParms),
                    binomial = modifyList(list(size = 1, prob = 0.5), distParms))

  myName <- switch(distribution,
                   normal = "Normal",
                    t = "T",
                    F = "F",
                    chisq = expression(chi),
                    binomial = "Binomial")

  myTitle <- switch(distribution,
                    normal = substitute(myName(mu == parm1, sigma^2 == parm2^2), list(myName = myName, parm1 = myParms$m, parm2 = myParms$sd)),
                    t = substitute(T(nu == parm1), list(myName = myName, parm1 == myParms$df)),
                    F = substitute(F(nu[1] == parm1, nu[2] == parm2), list(parm1 = myParms$df1, parm2 = myParms$df2)),
                    chisq = substitute(chi[parm1], list(myName = myName, parm1 = myParms$df)),
                    binomial = substitute(Binomial(parm1, parm2), list(myName = myName, parm1 = myParms$size, parm2 = myParms$prob)))

  crit.lower <- do.call(myQ, modifyList( list(p = alt.alpha, lower.tail = TRUE, ...), myParms ))
  crit.upper <- do.call(myQ, modifyList( list(p = alt.alpha, lower.tail = FALSE, ...), myParms ))
  ## if (missing(from)) from <- crit.lower - 0.10 *(crit.upper - crit.lower)
  ## if (missing(to)) to <- crit.upper + 0.10 * (crit.upper - crit.lower)

  if (missing(from)) from <- do.call(myQ, modifyList(list(p = 0.001), myParms))
  if (missing(to)) to <- do.call(myQ, modifyList(list(p = 0.999), myParms))
  cord.x1 <- c(from, seq(from = from, to = crit.lower, length.out = 100), crit.lower)
  cord.y1 <- c(0, do.call(myPDF, modifyList(list(x = seq(from = from, to = crit.lower,
                          length.out = 100), ...), myParms)), 0)
  cord.x2 <- c(crit.upper, seq(from = crit.upper, to = to,
                               length.out = 100), to)
  cord.y2 <- c(0, do.call(myPDF, modifyList(list(x = seq(from = crit.upper, to = to,
                          length.out = 100), ...), myParms)), 0)
  if (!is.null(filename)) pdf(file = filename)

  xseq <- seq(from, to, length.out = n)
  probseq <- do.call(myPDF,  modifyList(list(x = xseq, ...), myParms))
  plot(probseq ~ xseq, col = colour, type = "l" , lty = 1, lwd = 1,
       ylab = "Density", xlab = paste("Values from the", myName),
        main = myTitle)
   if (!identical(alternative, "greater")) {
    polygon(x = cord.x1, y = cord.y1, col = fill)
  }
  if (!identical(alternative, "lesser")) {
    polygon(x = cord.x2, y = cord.y2, col = fill)
  }
  if (!is.null(filename)) dev.off()
}




plotDist2(alpha = 0.05, alternative=c("two.tailed"), distribution="normal")
##looked encouraging

plotDist2(alpha = 0.05, alternative=c("two.tailed"), distribution="normal", mean = 17, sd = 3)
## works, as long as I fully spell out "mean" and "sd". I need to work on partial argument
## matching, maybe.

plotDist2(alpha = 0.05, alternative=c("greater"), distribution="normal")


plotDist2(alpha=0.05, alternative=c("greater"), distribution="normal", mean = -44, sd = 19)

plotDist(alpha=0.05, alternative=c("two.tailed"), distribution="t")


plotDist(alpha=0.05, alternative=c("two.tailed"), distribution="chisq")
##Usually people don't want that one

plotDist(alpha=0.05, alternative=c("greater"), distribution="chisq")
