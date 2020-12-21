## Title: plot-plotmath-001
## Author: Paul Johnson <pauljohn at ku.edu>
## Date posted: 2013-02-05
## Description. Basic exploration of plotmath

## For basics, everybody should run:
## demo(plotmath)
##
## ?plotmath

## Want to use times-roman fonts in the next plot device?
par(family="Times")
## par sets the options used by plots.
## This non-default setting works, but it is only in effect
## for the next graphic device. When you close a graph, then
## type reverts to usual helvetica family.
## Run following plots without it, then with it.


example(plotmath)

x<- 0:20
y <- 0:20

plot(x,y, type="n")

text( 4, 4, expression(paste(alpha)))

## See difference below: quoting prevents math-ization

text( 6, 4, expression(paste("alpha")))

## * is joiner, not multiplication
text( 12, 5, expression(paste(alpha*beta*gamma," alpha beta gamma")))


text( 4, 6, expression(paste(alpha, beta, gamma, sep="")))


text ( 2, 8, expression(frac(1, sigma)))


text ( 9, 2, expression(frac(1, sqrt(pi * sigma^2))*e^{ - frac(1,2) * (x-mu)^2}))


text ( 9, 10, expression(frac(1, sqrt(pi * sigma^2)) * e^{ - phantom(0) *frac(1,2) * phantom(0) * (x-mu)^2}))


text ( 9, 8, expression(italic(frac(1, sqrt(pi * sigma^2)) * e^{ - phantom(0) *frac(1,2) * phantom(0) * (x-mu)^2})))


text (5, 15, paste(expression( alpha * beta), x[1]))

### mtext is for margin text
mtext(expression(hat(alpha)), side=1, at=3, line = 2 )
mtext(expression(widehat(alpha*gamma)), side=1, at=5.5, line = 2)


example(mtext)

mtext( "crap crap", side=1, line=2)

mtext( "TRUTH", side=1, line=1)
mtext( expression(paste(f(x) == g(h(x)))), side=1, line=2)



##################
