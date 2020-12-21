## Title: plot-plotmath-02
## Author: Paul Johnson <pauljohn at ku.edu>
## Date posted: 2013-02-05
## Description. Basic plotmath

plot(NA, xlim=c(0,100), ylim=c(0,100))

#show plot math works
text(16, 22, expression(slope == frac(partialdiff * f(hat(theta)),
     partialdiff * hat(theta))))


## plotmath requires an R expression as the text to be plotted.
## expressions come from several R expressions, not just expression.

## I often want to put values of variables into the middle of expressions
## This is more difficult than you expect

avar1 <- 10

# It is easy to paste words with variables calculated by R
text(40, 40, paste("a word", avar1, "other words"))


## However, it is much tougher to integrate values
## calculated inside R with plotmath. I want something like

## beta = 10

## except beta is replaced by the symbol beta and the value of 10
## is retrieved from the variable "avar1".

## There are 2 ways I know of. 1) bquote and 2) substitute

## The bquote method works in an understandable way. It retrieves
## the value of a variable when it is given an argument .(avar1).
## The bquote function creates an expression.
text( 60, 20, bquote(beta == .(avar1)))

## bquote is easier for me to understand than substitute.

## But many examples we come across use substitute, it has a
## deep logic to it. I'm going to try to make this plain by
## putting the word "whatever" in the place where it needs to
## be substituted.

text( 60, 60, substitute( beta == whatever, list(whatever = avar1)))
## The last bit, list(whatever = avar1), tells substitute to
## scan the first argument, and replace whatever with the value of avar1.

## Make a tougher example of substitute.

avar2 <- 33.3

text(40, 80, substitute( paste( beta == thing1, ",", gamma == thing2), list(thing1 = avar1, thing2 = avar2)))


## It is possible to "pre-calculate" the plotmath expressions, and
## then use them. I think this makes for cleaner code

myExp1 <- expression(frac(alpha, beta))
text(20, 20, myExp1)


myExp2 <- expression(frac(partialdiff * g(x), partialdiff * f(x)))
text(50, 20, myExp2)

## I want to combine those expressions into a larger thing, that
## I could build up in a modular way. I searched for help with
## RSiteSearch and was disgusted to find I asked the same question
## in 2009. How time flies.

## And still I can't get it to work dependably. So I'm erasing the
## rest in disgust

