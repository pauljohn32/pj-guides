## Paul Johnson
## 20200923

## Doodles on CI for proportions

## Wilson, E.B. (1927).  Probable inference, the law of succession, and
## statistical inference.  _Journal of the American Statistical
## Association_, *22*, 209-212.  doi: 10.2307/2276774 (URL:
## https://doi.org/10.2307/2276774).

## Newcombe R.G. (1998).  Two-Sided Confidence Intervals for the
## Single Proportion: Comparison of Seven Methods.  _Statistics in
## Medicine_, *17*, 857-872.  doi:
## 10.1002/(SICI)1097-0258(19980430)17:8<857::AID-SIM777>3.0.CO;2-E
## (URL:
## https://doi.org/10.1002/(SICI)1097-0258(19980430)17:8<857::AID-SIM777>3.0.CO;2-E).

## Newcombe R.G. (1998).  Interval Estimation for the Difference
## Between Independent Proportions: Comparison of Eleven Methods.
## _Statistics in Medicine_, *17*, 873-890.  doi:
## 10.1002/(SICI)1097-0258(19980430)17:8<873::AID-SIM779>3.0.CO;2-I
## (URL:
## https://doi.org/10.1002/(SICI)1097-0258(19980430)17:8<873::AID-SIM779>3.0.CO;2-I).


## A. Agresti and B.A. Coull (1998), Approximate is better than
## "exact" for interval estimation of binomial proportions, _American
## Statistician_, *52*:119-126.

## R.G. Newcombe, Logit confidence intervals and the inverse sinh
## transformation (2001), _American Statistician_, *55*:200-202.

## L.D. Brown, T.T. Cai and A. DasGupta (2001), Interval estimation
## for a binomial proportion (with discussion), _Statistical
## Science_, *16*:101-133.




N <- 100
x <- rbinom(1, N, p=.2)
x <- rbinom(1, N, p=.5)
## asymptotic
prop.test(x, N)
## Without Yates's continuity correction
prop.test(x, N, correct=FALSE)


## p.c <- x/N


## Fisher's exact
binom.test(x, N)

## conf.level <- .95

## qnorm(0.025)
## qnorm(0.975, lower.tail=TRUE)

## z <- qnorm(0.975, lower.tail=TRUE)
## z22n <- z^2/(2 * N)

## # CI will be something like

## # lower:   p.c - z * std.error
## # upper:   p.c + z * std.error

## n <- N
## std.error <- sqrt(p.c * (1 - p.c)/n + z22n/(2 * n)) / (1 + 2 * z22n)

## p.c + z22n + z * std.error


library(binom)

help(package="binom")

?binom.confint


binom.confint(x, N, methods = c("exact", "ac"))

# ac = Agresti-Coull method
binom.confint(x, N, methods = c("exact", "ac", "wilson", "asymptotic"))

binom.confint(x, N, methods = "all")





xpt <- prop.test(x = x, n = N, p = .2, alternative = "two.sided")
print(xpt)


## the 'exact' test
xet <- binom.test(x = x, n = N, p = 0.2, alternative = "two.sided")
print(xet)


xet <- binom.test(x = x, n = N, p = 0.3, alternative = "two.sided")
print(xet)


##library(PropCIs)
