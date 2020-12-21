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

invlogit <- function(x, k0, k1){
   exp(k0 + k1 * x)/(1 + exp(k0 + k1 * x))
}

x1 <- seq(20, 70, length = 100)
beta0 <- -5
beta1 <- 0.1

## x1 <- 0:50                              
p <- invlogit(x1, beta0, beta1)
y <- rbinom(length(x1), size = 1, prob = p)

plot(x1, y, ylim = c(-.3, 1.3), xlab = "A numeric predictor",
     ylab="y coded 0 or 1", type="n")
points(x1, y)
title("Draw the best straight line to summarize the scatter")



plot(x1, y, xlab="A numeric predictor",
     ylab="y coded 0 or 1", type="n", ylim = c(-.3, 1.3))
points(x1,y)
abline(a = -1.2, b  = 0.04)
title("Straight Line is Not Right. Right?")
legend("topleft", c("Probability that y = 1"),
       lty = c(1), bty = "n")


## Now an S-shaped alternative
plot(x1, y, ,xlab="A numeric predictor",
     ylab="y coded 0 or 1", type="n", ylim = c(-0.3, 1.3))
points(x1,y)
lines(x1, p)
title("I'd Rather Have An S-shaped Curve")
legend("topleft", c("Probability that y = 1"),
       lty = c(1), bty = "n")



###################################################
### code chunk number 13: aoc2_1
###################################################
XBeta <- -0.2
xvals <- seq(-6, 6, length.out = 200)
xprob <- dlogis(xvals, scale = sqrt(3)/pi) 
xlt <- xvals < XBeta
xmax <- max(xvals[xlt])

plot(xvals, xprob, type = "l", ylim = c(0,0.6), xlab = expression(epsilon[i]),
     ylab = expression(Pr(y[i] == 1)), main = "") 

setx <- c(xseq[xlt], rev(xseq[xlt]))
sety <- c(rep(0, sum(xlt)), rev(xprob[xlt]))
polygon(setx, sety, col = "gray75")

text(XBeta, 0.01, expression(X[i]*beta == -0.2), pos = 4) 
text(-6, 0.3, labels = expression(paste(Area: Pr(y==1) == Pr(epsilon < X[i]*beta))), pos = 4, cex = 0.8)
legend("topleft", c(expression(paste("Logistic(", location==0, " , ",
                                     scale == sqrt(3)/pi, ")"))), lty=1:2, col=1:2, cex = 0.8) 
title("Logistic Probability that Y = 1")




beta0 <- -10
beta1 <- .1
xrange <- seq(50, 150, length = 200)
ProbY <- invlogit(xrange, beta0, beta1)

x <- rnorm(20, m = 100, s = 20)
x <- sort(x)

ypr <- invlogit(x, beta0, beta1)



plot(xrange, ProbY1, type="l",xlab='x', ylab='Probability(y=1)',
     ylim = c(-.2, 1.2), col = "gray60")

rug(x, lwd = 1)
points(x, ypr, lwd = 2, pch = 4)
abline(h = c(0,1), col = "gray70")
title("The \"true\" probabilty that y = 1")



plot(xrange, ProbY1, type="l",xlab='x',ylab = 'Probability(y=1)',
     ylim = c(-.2, 1.2), col = "gray60")
rug(x, ticksize = 0.02, lwd = 1)

points(x, ypr, pch = 4)
arrows(x[10], 0.05 + ypr[10], x[10], 1, length = 0.05) 
arrows(x[10], -0.05 + ypr[10], x[10], 0, length = 0.05) 
text(x[10], ypr[10]+ 0.5*(1 - ypr[10]), pos = 2, labels = paste("Pr[y = 1] = ", round(ypr[10], 2)))
text(x[10], ypr[10] - 0.5*(ypr[10]), pos = 4, labels = paste("Pr[y = 0] = ", round(1 - ypr[10], 2)))
abline(h = c(0,1), col = "gray70")





plot(xrange, ProbY1, type="l",xlab='x',ylab='Probability(y=1)',
     ylim = c(-.2, 1.2), col = "gray60")
rug(x, ticksize = 0.01, lwd = 1)
points(x, ypr, col = "gray60", pch = 4)
## monochromatic arrows
##arrows(x, ifelse(ypr < 0.94, 0.05 + ypr, ypr + 0.1 * (1-ypr)),  x, 1, length = 0.05) 
## arrows(x, ifelse(ypr > 0.05, ypr - 0.05, 0), x, 0, length = 0.05) 

grcol <- function(ypr) paste0("gray", round(20 + .6*(100*(1-ypr))))

arrows(x, ifelse(ypr < 0.94, 0.05 + ypr, ypr + 0.1 * (1-ypr)),  x, 1,
       length = 0.05, col = grcol(ypr)) 
arrows(x0 = x, y0 = ifelse(ypr > 0.05, ypr - 0.05, 0), x1 = x,
       y1 = 0.0, length = 0.05,
       col = grcol(1 - ypr))
title("Darker Arrow Points to More Likely Outcome")


dev.off()
