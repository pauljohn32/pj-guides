## Title: data-aggregate-1.R
## Author: Paul Johnson <pauljohn at ku.edu>
## Date posted: 2013-07-30
## Description. Demonstrates the R aggregate and by functions.

## A toy example of how to use aggregate and then compare with by

dat <- data.frame(x1 = rnorm(100), x2 = rnorm(100), z = gl(2,50))

datAgg1 <- aggregate(dat[ c("x1", "x2")],
                     by = list(z = dat$z),
                     function(x) { c("mean" = mean(x), "std.dev." = sd(x))})


## notice the difference if you do not include the names in by and the function return value

datAgg2 <- aggregate(dat[ c("x1", "x2")],
                     by = list(dat$z),
                     function(x) { c(mean(x), sd(x))})


## Notice the by() function is similar in spirit, not so tight in output.
## by is better for running regressions on subsets, perhaps.

by(dat[ , c("x1", "x2")], INDICES = list(z = dat$z), summary)

by(dat[ , c("x1")], INDICES = list(z = dat$z),
   function(x) {rockchalk::summarize(x)})


## by returns an error with this
by(dat[ , c("x1", "x2")], INDICES = list(z = dat$z), function(x) mean(x))
## That's frustrating.


## Can get by to run on just one column
by(dat[ , c("x1")], INDICES = list(z = dat$z), function(x) mean(x))


## Also can make work with 2 columns if we are clever, but this really seems like work to me. function inside has to receive the subset and then apply mean to each row
by(dat[ , c("x1", "x2")], INDICES = list(z = dat$z),
   function(x) apply(x, 2, mean ))

## That worked, now see avenue to get mean and sd
by(dat[ , c("x1", "x2")], INDICES = list(z = dat$z),
   function(x) apply(x, 2, function(y) c(mean(y), sd(y))))

by(dat[ , c("x1", "x2")], INDICES = list(z = dat$z),
   function(x) apply(x, 2, function(y) c("mean" = mean(y), "std.dev." = sd(y))))

## So the labels are nicer with  by, perhaps.

## but aggregate is tighter

aggregate(dat[ c("x1", "x2")], by = list(z = dat$z),
          function(x) { c("mean" = mean(x), "std.dev." = sd(x))})


## Now add another classifier

dat$z2 <- gl(4, 25)


aggregate(dat[ c("x1", "x2")], by = list(z = dat$z, z2 = dat$z2),
          function(x) { c("mean" = mean(x), "std.dev." = sd(x))})



by(dat[ , c("x1", "x2")], INDICES = list(z = dat$z, z2 = dat$z2),
   function(x) apply(x, 2, function(y) c("mean" = mean(y), "std.dev." = sd(y))))


## Note how by and aggregate deal differently with the non-observed
## combinations of z and z2. Very interesting.

## So conclusions?  by() may have better on-screen separation.

## aggregate: much tighter output, more easily diverted to next analysis

## if you add the argument simplify = FALSE in both of these, some
## superficial differences are observed.

## In a research context, z might be "province" and z2 might be
## district (which are nested within province).

## One might want to get 3 levels of aggregation, nationwide,
## province, and district. Here's one way.

res <- list()

res[["distAgg"]] <- aggregate(dat[ ,c("x1", "x2")],
                              by = list(z = dat$z, z2 = dat$z2),
                              function(x) { c("mean" = mean(x), "std.dev." = sd(x))})

res[["provAgg"]] <- aggregate(dat[ ,c("x1", "x2")], by = list(z = dat$z),
                              function(x) { c("mean" = mean(x), "std.dev." = sd(x))})

res[["national"]] <- apply(dat[ , c("x1", "x2")], 2,
     function(x) { t(c("mean" = mean(x), "std.dev." = sd(x)))})

## Frustrating to get national result in same format as others, have to transpose.

## Maybe best to re-do with a phony aggregation variable

dat$z3 <- 1

res[["national"]] <- aggregate(dat[ ,c("x1", "x2")],
                         by = list(z = dat$z3),
                         function(x) { c("mean" = mean(x), "std.dev." = sd(x))})


## Yes, at least that output is consistent.


## Now to a particular kind of output we want. We want the means, the
## standard deviations,  the difference of the means by a category,
## and maybe a t-test.

datAgg <- aggregate(dat[ c("x1", "x2")], by = list(z = dat$z, z2 = dat$z2),
                    function(x) { c("mean" = mean(x), "std.dev." = sd(x))},
                    simplify = TRUE)

## Unfortunately, here we are screwed a little bit. Look here.
## IT seems like we ought to have columns named "x1.mean" and "x2.mean",
## doesn't it? Look:

## > datAgg
##   z z2      x1.mean  x1.std.dev.       x2.mean   x2.std.dev.
## 1 1  1 -0.081676222  1.203269529 -0.0006042752  0.7754499882
## 2 1  2 -0.003150713  0.962611546  0.0186762727  1.1697592779
## 3 2  3  0.171069342  0.823261626 -0.0416486490  0.8629138910
## 4 2  4  0.021394010  1.060191970  0.2192164114  0.7857715910

## But I can't find the variables. What the heck?
## > datAgg$x1.mean
## NULL
## > colnames(datAgg)
## [1] "z"  "z2" "x1" "x2"

## Hmm. Think that over. what is datAgg?  Why do I get this?
## > datAgg$x1
##              mean  std.dev.
## [1,] -0.081676222 1.2032695
## [2,] -0.003150713 0.9626115
## [3,]  0.171069342 0.8232616
## [4,]  0.021394010 1.0601920


## This is bad, how to get those out? Why does datAgg the print out
## that way if the columns aren't really there? I'm stumped, apparently
## I don't know as much about data frames as I thought.

## This does obtain the column of means, however:
datAgg$x1[ , "mean"]

## and this does obtain a whole row

datAgg[1 , ]

## We'll have to think more on what we really want out of that
## before I type more idiocy.


## Oh, I should mention there is a formula interface

aggregate(cbind(x1, x2) ~ z, dat, mean)



aggregate(cbind(x1, x2) ~ z, dat,
          function(x) c("mean" = mean(x), "std.dev." = sd(x)))

aggregate(cbind(x1, x2) ~ z + z2, dat,
          function(x) c("mean" = mean(x), "std.dev." = sd(x)))

aggregate(cbind(x1, x2) ~ z + z2 + z3, dat,
          function(x) c("mean" = mean(x), "std.dev." = sd(x)))

## I just wish I knew how to "flatten" that.

datAgg <- aggregate(cbind(x1, x2) ~ z, dat,
                    function(x) c("mean" = mean(x), "std.dev." = sd(x)))

## > datAgg
##   z     x1.mean x1.std.dev.     x2.mean x2.std.dev.
## 1 1 -0.04241347  1.07915843 0.009035999 0.982255563
## 2 2  0.09623168  0.94245051 0.088783881 0.827339099

## But maybe I shouldn't want to. Look how tight this is to get the
## differences of means, once you understand the output.

datAgg$x1[1 ,"mean"] - datAgg$x1[2, "mean"]

datAgg[ , c("x1", "x2")]

## Nope, I still wish I could flatten that.

datAggTest <- datAgg[ , c("x1", "x2")]


## > datAgg[ , c("x1", "x2")]
##       x1.mean x1.std.dev.     x2.mean x2.std.dev.
## 1 -0.04241347  1.07915843 0.009035999 0.982255563
## 2  0.09623168  0.94245051 0.088783881 0.827339099
## > datAggTest <- datAgg[ , c("x1", "x2")]
## > dim(datAggTest)
## [1] 2 2

## It really seems to me that dim should be 2 x 4. So
## the data frame has nested matrices inside it. And once again
## that proves I just don't know as much about data frames as I thought.
