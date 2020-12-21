
## Paul Johnson
## 2013-02-20
## Description: Can we make a symbol into a variable?
## We know how to replace a calculated value into a
## plotmath text marker, but I had a devil of a time
## figuring how to put a symbol as a variable. 
##
## I believe the steps here are self-evident in their
## success and failure, but I don't understand 100%
## the implications and complete HOWTO advice to flow
## fromit.



### Here's a plotmath problem that makes me really mad!

plot(1:10, 1:10, type = "n")

mean <- 3.3
sd <- 4.1

text( 2, 3, label = expression(mu == gamma)) ## OK

text( 2, 4, label = substitute(mu == M, list(M = mean)))## OK

text (2, 5, label = substitute(list(mu == M, sd == SD), list(M = mean, SD = sd))) ## OK

distName <- expression(chi^2)

text(2, 6, distName) ## OK

text (5, 1, label = substitute(D == S, list( D = distName , S = sd)))
## Failed. chi^2 distName does not show.

text (5, 2, label = substitute(D == S, list( D = expression(chi), S = sd)))
## Epic fail. chi does not show.


distName <- "chi"
text(5, 5, as.name(distName))
## OK

text(5, 8, label = substitute(D, list(D = distName)))
## Fail. shows "chi" literally


text(7, 1, label = substitute(D, list(D = as.name(distName))))
## success


distName <- "chi^2"
text(7, 2, as.name(distName))
## Fail. Adding ^2 breaks it

distName <- "chi"

text(7, 4, label = substitute(D^2, list(D = as.name(distName))))
## success. So var that's substituted must be "atomic"?


text(8, 2, label = substitute(delta(d)==M, list(d = as.name(distName), M = mean)))
## success!


