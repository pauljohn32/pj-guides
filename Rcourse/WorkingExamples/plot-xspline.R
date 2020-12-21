## Paul Johnson
## 2012-08-04


## Objective: Make it easier to draw smooth curves from one point to
## another, allowing for a "bend" that is defined as an "offset" of a
## point away from the line.

## Think of it like this, a line between "from" and "to"
##
## O------------------------------------O
## "from"                             "to"
##
## Mark a point somewhere in the middle. It is r2/r1 proportion
## of the distance from "from" to "to". r2/r1 = 1 would
## mean half way.
##
##         r1                  r2
## O---------------------|--------------O
## "from"               mid           "to"
##
## From "mid", move distance "offset" in a direction
## perpendicular to the line.
##
##
##                       z
##                       ^
##                       | offset
##                       |
##         r1            |     r2
## O---------------------|--------------O
## "from"               mid           "to"

## Then feed the points "from", "to" and z to a drawing function.

## The ratio of the line segments r1 & r2 is the "asymmetry".
## If asym = 0, this returns a true perpendicular bisector.

## I got this wrong several times before I got it right. I had
## considered teaching the mistakes as an educational exercise. But
## some mistakes are too tragic :)

## On http://descarta2d.com, a book is offered that REALLY helps.
## Donald L. Vossler, Exploring Analytic Geometry with Mathematica.
## 1999.

## Here I offer 2 functions that work together, along with example
## usages. "bend" is intended for "users" to use (like "lines" or
## "points" in R). That uses R's xspline function to do the actual
## drawing.  A function called "perpBisector" is used to calculate the
## coordinates of the point in the middle that causes the line to bend.


## bend puts the perpBisector function to use. It draws from "from"
## to "to" and the amount of offset is specified.
bend <- function(from, to, push = 0, asym = 0, label = "b", ...){
    if (identical(from, to)) { stop("The points from and to are the same")}

    z <- perpBisector(from, to, push, asym = asym)

    text(z[1], z[2], label = label, adj= (-1.8)*sign(push)*(push), ..., )

    points( rbind(from, to), ...)
    xspline( c(from[1], z[1], to[1]), c(from[2], z[2], to[2]), c(0, -1, 0))
    z
}


## This returns a point and a perpendicular line formula.
## If you are really picky, it is not a bisector when asym != 0
perpBisector <- function(from, to, push, asym = 0){

    if ( asym < -1 | asym > 1 ) stop("perpBisector requires asym parameter between -1, 1")

    mid <- z <- rep(NA, 2)

    dist <- sqrt((from[1] - to[1])^2 + (from[2] - to[2])^2)
    r1 <-  dist/2 +  dist * (asym/2)
    r2 <- dist - r1
    mid[1] <- (from[1]*r2 + to[1]*r1)/(r1 + r2)
    mid[2] <- (from[2]*r2 + to[2]*r1)/(r1 + r2)

    ##    lambda <- 0.5 + asym/2
    ##    mid  <- c(lambda*from[1] + (1-lambda)*to[1], lambda*from[2] + (1-lambda)*to[2])

    ## Bad Cases: from -> to is HORIZONTAL:
    if (isTRUE(all.equal(to[2], from[2]))) {
        z[1] <- mid[1]
        z[2] <- mid[2] + push
        attr(z, "bisector") <- function(x) {z[2]}
        return(z)
    } else if (isTRUE(all.equal(to[1], from[1]))) { ##VERTICAL
        z[1] <- mid[1] + push
        z[2] <- mid[2]
        attr(z, "bisector") <- function(x) {z[1]}
        return(z)
    }

    ## For other lines, we have to do some real work. Well,
    ## at least concentrate :)

    ## First, get normal form of line from "from" to "to"

    A2 <- -1 * (to[2] - from[2])
    B2 <- to[1] - from[1]
    C2 <- from[1]*to[2] - to[1]*from[2]
    D2 <- sqrt(A2^2 + B2^2)
    ## D2 is the normalizing coefficient.
    ## The point-point form of a line, descarta2d.com, p. 56-7
    ## -(to[2]-from[2])*x + (to[1]-from[2])*y + from[1]*to[2] - to[2]*from[1]

    ## descarta2d.com, p. 65
    ## The normal form for "from" -> "to" is scaled thus:
    ## (A2/D2) * x + (B2/D2) * y + C2/D2 = 0

    ## descarta2d.com, page 67
    ## z is a point displaced (perpendicularly) a distance t units from mid
    z <- rep(NA, 2)
    z[1] <- mid[1] + push * A2/D2
    z[2] <- mid[2] + push * B2/D2

    ## descarta2d.com, p. 60
    ## A line through a point z = c(z[1], z[2]) that is perpendicular
    ## to the from->to line is:
    ## B2 * x - A2 * y + (A2 * z[2] - B2 * z[1]) = 0
    ## which re-arranges:
    ## y = (B2/A2)*x    + (A2 * z[2] - B2 * z[1])/A2

    bisector <- function(x) (A2 * z[2] - B2 * z[1])/A2 + (B2/A2)*x
    attr(z, "bisector") <- bisector
    invisible(z)
}



## OK, lets try now.

from <- c(0.2, 0.2)
to <- c(0.8, 0.8)
#dev.new(height=5, width=5)
par(mar=c(5,5,5,5))
plot(0:1, 0:1, type="n")
bend(from, to, 0.1, label = 0.1)
bend(from, to, 0.2, label = 0.2)
bend(from, to, -0.1, label = -0.1, cex = 0.9)
bend(from, to, -0.2, label = -0.2, cex = 0.8)
bend(from, to, -0.4, label = "-0.4", cex = 0.7)
bend(from, to, 0, label = "NO BEND")

bp4 <- bend(from, to, 0, label = "NO BEND")
f <- attr(bp4, "bisector")
curve(f, from=0, to=1, add=TRUE, lty = 4)
##dev.off()

## OK, so far.

to <- c(0.1, .92)
from <- c(0.8, 0.18)
#dev.new(height=5, width=5)
par(mar=c(5,5,5,5))
plot(0:1, 0:1, type="n")
bend(from, to, 0.1, label = 0.1)
bend(from, to, 0.2, label = 0.2)
bend(from, to, -0.1, label = -0.1, cex = 0.9)
bend(from, to, -0.2, label = -0.2, cex = 0.8)
bend(from, to, -0.4, label = "-0.4", cex = 0.7)
bp3 <- bend(from, to, 0, label = "NO BEND")

f <- attr(bp3, "bisector")
curve(f, from=0, to=1, add=TRUE, lty = 4)
##dev.off()


## Lets try that asymmetric feature
to <- c(0.1, .92)
from <- c(0.8, 0.18)
##dev.new(height = 5, width = 5)
par(mar = c(5, 5, 5, 5))
plot(0:1, 0:1, type="n")
bend(from, to, 0.3, asym= 0.0, label = "0.1,a0")
bend(from, to, 0.3, asym= 0.1, label = "0.1,a.1")
bend(from, to, 0.3, asym= 0.2, label = "0.1,a.2")
bend(from, to, 0.3, asym= 0.3, label = "0.1,a.3")
bend(from, to, 0.3, asym= 0.4, label = "0.1,a.4")
bend(from, to, 0.3, asym= 0.5, label = "0.1,a.5")
bend(from, to, 0.3, asym= 0.6, label = "0.1,a.6")



bend(from, to, 0.3, asym= 0, label = "0.1")
bend(from, to, 0.3, asym= -0.8, label = "0.1")
bend(from, to, 0.3, asym= -1, label = "0.1")

bend(from, to, 0.1, asym= 0.2, label = "0.1,a2")


bend(from, to, 0.2, label = 0.2)
bend(from, to, -0.1, label = -0.1, cex = 0.9)
bend(from, to, -0.2, label = -0.2, cex = 0.8)
bend(from, to, -0.4, label = "-0.4", cex = 0.7)
bend(from, to, -0.4, asym = 0.8, label = "-0.4", cex = 0.7)


to <- c(1,1)
from <- c(0, 0)
## dev.new(height = 5, width = 5)
par(mar = c(5, 5, 5, 5))
plot(0:1, 0:1, type="n")
bend(from, to, 0.3, asym= 0.0, label = "0.1,a0")
b35 <- bend(from, to, 0.3, asym= 0.5, label = "0.1,a.1")





bp3 <- bend(from, to, 0, label = "NO BEND")

f <- attr(bp3, "bisector")
curve(f, from=0, to=1, add=TRUE, lty = 4)

## Notes

## descarta2d.com
## line perpendicular to line connecting x0,y0  x1, y1
## {2(x1-x0)} x + {2(y1-y0)}+ {x0^2-x1^2 + y0^2 - y1^2} = 0
##   A1             B1             C1

## Parametric form
## A1 <- 2*(x1 - x0)
## B1 <- 2*(y1 - y0)
## C1 <- x0^2 - x1^2 + y0^2 - y1^2

## x = -(A1 * C1)/(A1^2 + B1^2) + B1*t/(sqrt(A1^2 + B1^2))
## y = -(B1 * C1)/(A1^2 + B1^2) - A1*t/(sqrt(A1^2 + B1^2))
## {2(x1-x0)} x + {2(y1-y0)} y + {x0^2-x1^2 + y0^2 - y1^2} = 0
##   A1             B1             C1

## x0 = from[1]
## x1 = to[1]
## y0 = from[2]
## y1 = to[2]


## Also, if line segments going "from" and "to" are length r1 and r2,
## the proportional midpoint is.

## midpoint[1] <- (from[1]*r2 + to[1]*r1)/(r1 + r2)
## midpoint[2] <- (from[2]*r2 + to[2]*r1)/(r1 + r2)

## Note if want midpoint, r1=r2, and that simplifies to previous
##
## midpoint[1] <- (from[1] + to[1])/2
## midpoint[2] <- (from[2] + to[2])/2

