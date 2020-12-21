## Paul Johnson
## 2017-05-16


## Some graphs I used in a lecture about logistic regression

outdir <- "../output/"
if(!file.exists(outdir)) dir.create(outdir, recursive = TRUE)

pdf.options(onefile = FALSE, paper = "special",
            family = "Times", height = 5, width = 6)

SAVEME <- TRUE


options(useFancyQuotes = FALSE) 
set.seed(12345)
library(rockchalk)

if (SAVEME){
    pdf(file = paste0(outdir, "logit-%d.pdf"))
} else {
    dev.new(height = 5, width = 6)
    par(ask = TRUE)
}




##' Illustrate ordinal logit as division of a probability density
##'
##' Run the examples. Just set tau, let the defaults stay unless
##' you want trouble. 
##'
##' TODO: fix the problem that the group labels appear outside
##' the curve when tau close to edge.
##' TODO: deal with problem that the labels in bottom should be
##'  tau -X beta, not just tau.  But tau looks so clean and nice!
##' @param tau Vector of threshold values, each between -3 and + 3
##' @param yname Text string to print, defaults "y"
##' @param escale Character string describing scale parameter
##'     calculation. This is used both to set the scale and then
##'     pretty-print the formula in the legend
##' @param ylim axis range
##' @param xlim axis range
##' @return list including the x values, probability values, and the
##'     thresholds
##' @author Paul Johnson
##' @examples
##' set.seed(234234)
##' tau <- c(-0.2, 0.6, 1.6)
##' plot.ologit(tau)
##' tau <- sort(rlogis(3, scale = sqrt(3)/pi))
##' plot.ologit(tau)
##' tau <- sort(rlogis(4, scale = sqrt(3)/pi))
##' plot.ologit(tau)
##' tau <- c(.4, 1.6, 1.8, 2.0)
##' plot.ologit(tau)
##' tau <- c(-.9, 0, .9, 1.8)
##' plot.ologit(tau, yname = "y")
plot.ologit <- function(tau, yname = "y",
                        escale = "sqrt(3)/pi",
                        ylim = c(-0.05, 0.6),
                        xlim = c(-3, 3))
{

    drawCutlines <- function(tau, scale = sqrt(3)/pi, col = "gray75"){
        cutline <- function(tau, col = col, scale = scale){
            xprob <- dlogis(tau, scale = scale)
            lines(c(tau, tau), c(0, 0.98 * xprob), col = col)
            NULL
        }
        sapply(tau, cutline, col = col, scale = scale)
        
        for(i in seq_along(tau))
            text(tau[i], 0, substitute(tau[indx], list(indx = i)),
                 pos = 1, cex = 1)
        text(tau[1] - 2 * strwidth("-XB"), 0, expression(-X * beta + phantom()), pos = 1, cex = 1)
    }
    
    
    labelMids <- function(tau, xvals, xprob, ypos = 0.05, yname = "y"){
        xmin <- min(xvals, na.rm = TRUE)
        xmax <- max(xvals, na.rm = TRUE)
        taumids <-  c(xmin + 0.85 * (tau[1] - xmin),
                      0.5 * (tau[-1L] + tau[-length(tau)]),
                      tau[length(tau)] + 0.1 * (xmax - tau[length(tau)]))
        labels <- seq_along(taumids)
        labels[1] <- paste(yname, " = ", labels[1])
        text(taumids, ypos, labels = labels, pos = 1)
        NULL
    }

    tau <- sort(tau)
    xvals <- seq(xlim[1], xlim[2], length.out = 200)
    xprob <- dlogis(xvals, scale = eval(parse(text = escale))) 
    plot(xvals, xprob, type = "l", ylim = ylim,
         xlab = expression(epsilon[i]),
         ylab = expression(Density(epsilon[i])), main = "")

    legend("topleft", c(expression(paste("Logistic(", location==0, " , ",
                                        scale == sqrt(3)/pi, ")"))), lty=1:2, col=1:2, cex = 0.8)
    
    abline(h=0, col = "gray60")

    drawCutlines(tau)
    labelMids(tau, xvals = xvals, xprob = xprob, yname = yname)

    text(min(xvals), .8 * par("usr")[4],
         expression(Pr(y <= j) == Pr(X[i] * beta + epsilon[i] <= tau[j])),
         pos = 4)

    text(min(xvals), .6 * par("usr")[4],
         expression(Pr(y <= j) == frac(exp(tau[j] - X*beta), 1 + exp(tau[j] - X*beta))),
         pos = 4)
    
    invisible(list(xvals = xvals, xprob = xprob, tau = tau))
}




## 20170517: Remainder is doodles that do not work yet
## text(min(xvals), .8 * par("usr")[4],
##      expression(Pr(y <= j) == frac(exp(X*beta), 1 + exp(XB))),
##      pos = 4) 

## text(min(xvals), .7 * par("usr")[4],
##      expression(Pr(y <= j) == Pr(epsilon <= X * beta)),
##      pos = 4) 

## XB + epsilonj < tauj

## epsilonj < tauj - XB

## text(min(xvals), .8 * par("usr")[4],
##      expression(Pr(y <= j) == Pr(X[i] * beta + epsilon[i] <= tau[j])),
##      pos = 4)

## text(min(xvals), .6 * par("usr")[4],
##      expression(Pr(y <= j) == frac(exp(tau[j] - X*beta), 1 + exp(tau[j] - X*beta))),
##      pos = 4)



## labely <- .1 + .8 * dlogis(taumids, scale = escale)
## positions <- c(2, rep(1, length(tau)-1), 4)




## ##' Logistic probability as a function of x and 2 constants
## ##'
## ##' @param x a variable
## ##' @param k0 
## ##' @param k1 
## ##' @return 
## ##' @author Paul Johnson
## invlogit <- function(x, k0, k1){
##    exp(k0 + k1 * x)/(1 + exp(k0 + k1 * x))
## }

## x1 <- seq(20, 70, length = 100)
## beta0 <- -5
## beta1 <- 0.1





## for(ii in seq_along(taumids)){
##   ##text(taumids[ii], labely, substitute(Pr(y[i] == j), list(j = ii)))
##     text(taumids[ii], 0.05, labels = ii, pos = 1)
## }
## points(taumids, rep(0.05, length(taumids)))


## setx <- c(xseq[xlt], rev(xseq[xlt]))
## sety <- c(rep(0, sum(xlt)), rev(xprob[xlt]))
## polygon(setx, sety, col = "gray75")

## text(XBeta, 0.01, expression(X[i]*beta == -0.2), pos = 4) 
## text(-6, 0.3, labels = expression(paste(Area: Pr(y==1) == Pr(epsilon < X[i]*beta))), pos = 4, cex = 0.8)
## title("Logistic Probability that Y = 1")




## beta0 <- -10
## beta1 <- .1
## xrange <- seq(50, 150, length = 200)
## ProbY <- invlogit(xrange, beta0, beta1)

## x <- rnorm(20, m = 100, s = 20)
## x <- sort(x)

## ypr <- invlogit(x, beta0, beta1)



## plot(xrange, ProbY1, type="l",xlab='x', ylab='Probability(y=1)',
##      ylim = c(-.2, 1.2), col = "gray60")

## rug(x, lwd = 1)
## points(x, ypr, lwd = 2, pch = 4)
## abline(h = c(0,1), col = "gray70")
## title("The \"true\" probabilty that y = 1")



## plot(xrange, ProbY1, type="l",xlab='x',ylab = 'Probability(y=1)',
##      ylim = c(-.2, 1.2), col = "gray60")
## rug(x, ticksize = 0.02, lwd = 1)

## points(x, ypr, pch = 4)
## arrows(x[10], 0.05 + ypr[10], x[10], 1, length = 0.05) 
## arrows(x[10], -0.05 + ypr[10], x[10], 0, length = 0.05) 
## text(x[10], ypr[10]+ 0.5*(1 - ypr[10]), pos = 2, labels = paste("Pr[y = 1] = ", round(ypr[10], 2)))
## text(x[10], ypr[10] - 0.5*(ypr[10]), pos = 4, labels = paste("Pr[y = 0] = ", round(1 - ypr[10], 2)))
## abline(h = c(0,1), col = "gray70")





## plot(xrange, ProbY1, type="l",xlab='x',ylab='Probability(y=1)',
##      ylim = c(-.2, 1.2), col = "gray60")
## rug(x, ticksize = 0.01, lwd = 1)
## points(x, ypr, col = "gray60", pch = 4)
## ## monochromatic arrows
## ##arrows(x, ifelse(ypr < 0.94, 0.05 + ypr, ypr + 0.1 * (1-ypr)),  x, 1, length = 0.05) 
## ## arrows(x, ifelse(ypr > 0.05, ypr - 0.05, 0), x, 0, length = 0.05) 

## grcol <- function(ypr) paste0("gray", round(20 + .6*(100*(1-ypr))))

## arrows(x, ifelse(ypr < 0.94, 0.05 + ypr, ypr + 0.1 * (1-ypr)),  x, 1,
##        length = 0.05, col = grcol(ypr)) 
## arrows(x0 = x, y0 = ifelse(ypr > 0.05, ypr - 0.05, 0), x1 = x,
##        y1 = 0.0, length = 0.05,
##        col = grcol(1 - ypr))
## title("Darker Arrow Points to More Likely Outcome")


## dev.off()
