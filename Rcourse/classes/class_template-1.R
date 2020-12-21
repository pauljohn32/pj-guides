## Paul E. Johnson
## 2015-10-07


##' fit a linear model and return results in list with histogram of dependent variable
##'
##' This is an example to help students understand classes and the way R programs
##' pass information around
##' @param formula Any formula that would work with the lm() function is OK
##' @param data A data frame
##' @param missValue Some data sets might have missings that are not yet set to NA
##' @return A list with 2 pieces, the lm() output along with the output of a
##' hist() call with plot = FALSE
##' @author Paul Johnson <pauljohn@@ku.edu>
fitter <- function(formula = NULL, data = NULL, missValue = -999)
{
    ## Do anything you want to estimate the formula, I'll throw in an lm fit
    m1 <- lm(formula = formula, data = data)
    res <- list(m1, dvhist = hist(model.frame(m1)[ , 1] , plot = FALSE))
    class(res) <- "fitter"
    attr(res, "missValue") <- missValue
    invisible(res)
}

##' A summary method
##'
##' Does not display output
##' 
##' @param object A fitter class object 
##' @param ... Additional arguments which are not currently used
##' @param standardize TRUE or FALSE. Are you an SPSS user?
##' @return An object with some new information
##' @author Paul Johnson
summary.fitter <- function(object = NULL, ..., standardize = FALSE)
{
    modl <- object[[1]]
    if (standardize) {
        res <- summary(rockchalk::standardize(modl))
    } else {
        res <- summary(modl)
    }
    res$N <- stats:::nobs.lm(modl)
    class(res) <- "summary.fitter"
    attr(res, "standardize") <- standardize
    res
}
    

## Lets test this before we go further
example(lm, ask = FALSE)
dat <- data.frame(weight, group)
rm(weight, group)
fit1 <- fitter(weight ~ group, dat)
summary(fit1)
summary(fit1, standardize = TRUE)

beta0 <- 0.3; beta1 <- 0.1; STDE <- 20
dat2 <- data.frame(bar = rnorm(150, m = 30, sd = 100))
dat2$fu = beta0 + beta1 * dat2$bar + rnorm(150, m = 0, sd = STDE)
fit2 <- fitter(fu ~ bar, data = dat2)
summary(fit2)
summary(fit2, standardize = TRUE)

## Exercises

## 1. Write code to check the input in the fitter function to make sure the
## user has given the correct information

## 2. Can you see the new attributes on these objects?

## 3. Can you add more attributes, and check on them?

## 4. Suppose you want the fitter function to send this message to the screen when it
## runs:

## "Hi, I'm fitter, and the formula you gave me was:"

## and then display the formula. Try to do that. 


## 5. The output of summary(fit1) looks horrible. Why do you think it
## looks so bad? I've got a hint for you in the next code segment.

## 6. Consider the print method in the next code segment. Can you
## explain why it makes the output look better?

## A. Find out what stats::: means

## B. Find out where print.summary.lm() is defined.

## 7. Can you guess some ideas to change the class() function in
## "fitter" to avoid this problem?  Hint: Think of "inheriting" methods
## from lm.

## 8. I want the summary output to have the sample size, N.  See if you
## can make that happen.

                                     
print.summary.fitter <- function(x, digits = max(3L, getOption("digits") - 3L),
                         signif.stars = getOption("show.signif.stars"), ....)
{
    cat("Here's that regression\n")
   
    stats:::print.summary.lm(x)

    ## oops, following does not work because there's no his object
    ## cat("And the Histogram on the DV was\n")
    
    ## print(x[[2]])
    
}

summary(fit2)
summary(fit2, standardize = TRUE)



## More Exercises

## 9. I forgot to summarize the hist object in my summary function. Can
## you fix that?

## 10. Following is a skeleton of a print method to beautify summaries
## of my fitter objects.  Care to test your skills by beautifying the
## output to make it look more like Stata, SAS, or SPSS?

## Some would say I've cheated here by reading the R source code
## to see how they do things.


print.summary.fitter <- function(x, digits = max(3L, getOption("digits") - 3L),
                         signif.stars = getOption("show.signif.stars"), ....)
{
    coefs <- x$coefficients

    if (attr(x, "standardize")) cat(paste("Note: This is standardized\n"))
    
    printCoefmat(coefs, digits = digits, signif.stars = signif.stars,
                 na.print = "NA")
    
    cat(paste("N:" , formatC(sum(x$df[1:2]), digits = digits), "\n"))
    
    invisible(coefs)
}

## More Exercises

## 11. You could also say I've cheated by manufacturing the sample
## size in my summary method. Please implement the nobs method
## below so it works correctly.

nobs.fitter <- function(object, ...){
    33
}


## There are a number of other methods that would be needed
## if this was to serve as a real regression object in the R style.
##
## We need methods
## 1 anova
## 2 print

## I'll throw in a couple of other functions I have sitting about.

coef.summary.fitter <- function(object, ...){ 
    object$coefficients
}

coef.fitter <- function(object, ...){
    objsum <- summary(object)$coefficients
}

