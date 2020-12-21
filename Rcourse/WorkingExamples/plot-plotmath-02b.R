## Paul Johnson <pauljohn@ku.edu>
## 2013-04-24, 2013-05-18

## Simple plotmath example The goal here was to make nice looking
## labels on the## y axis. Step through the first part, see what we
## are aiming at, and then the second part is a little smarter.

## This one went into a student's prize winning honors project, In the
## first example, I get the result I want, but was really frustrated
## that I could not find a succinct way to generate the lambdas.
## But I finally remembered the fix, so it is all good in the end.

lwr <- c(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.1, 0.3)
upr <- c(0.3, 0.25, 0.6, 0.7, 0.6, 1.1, 0.7, 0.5)

yseq <- seq_along(lwr)

lambda <- paste("lambda[", yseq, "]",  sep ="")

lambda <- expression(lambda[1])

lambda1 <- substitute(lambda[AA], list(AA = 1))
lambda2 <- substitute(lambda[AA], list(AA = 2))
lambda3 <- substitute(lambda[AA], list(AA = 3))
lambda4 <- substitute(lambda[AA], list(AA = 4))
lambda5 <- substitute(lambda[AA], list(AA = 5))
lambda6 <- substitute(lambda[AA], list(AA = 6))
lambda7 <- substitute(lambda[AA], list(AA = 7))
lambda8 <- substitute(lambda[AA], list(AA = 8))
lambda9 <- substitute(lambda[AA], list(AA = 9))
lambda10 <- substitute(lambda[AA], list(AA = 10))
lambda11 <- substitute(lambda[AA], list(AA = 11))
lambda12 <- substitute(lambda[AA], list(AA = 12))
lambda13 <- substitute(lambda[AA], list(AA = 13))


mylabels <- as.expression(c(lambda1,lambda2, lambda3, lambda4,lambda5,
    lambda6, lambda7, lambda8, lambda9, lambda10, lambda11, lambda12,
    lambda13))

par(mar = c(5.1, 6.1, 4.1, 2.1))

plot( x = range(c(lwr, upr)), y = c(0, max(yseq) +1), type = "n", axes
= FALSE, ylab ="", xlab = "95% Confidence Interval for Estimate")

axis(1)
axis(2, at = yseq, labels = mylabels[yseq], las = 2)

arrows(lwr, yseq, upr, yseq, angle = 90, code = 3, length = 0.05)

box(bty = "L")


## 2013-05-18
## here's the way to generate the labels in a smarter way.

myLabels <- lapply(1:13, function(x) substitute(lambda[AAA], list(AAA = x)))
myLabels <- as.expression(myLabels)

par(mar = c(5.1, 6.1, 4.1, 2.1))
plot( x = range(c(lwr, upr)), y = c(0, max(yseq) +1), type = "n", axes = FALSE, ylab ="", xlab = "95% Confidence Interval for Estimate")

axis(1)

axis(2, at = yseq, labels = myLabels[yseq], las = 2)

arrows(lwr, yseq, upr, yseq, angle = 90, code = 3, length = 0.05)
box (bty = "L")

