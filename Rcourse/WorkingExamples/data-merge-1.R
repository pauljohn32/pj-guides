## Paul E. Johnson <pauljohn@ku.edu>
## 2013-07-23

## "Merging" datasets means many different things.  It always
## means putting different things together, but that's all it
## means, in general.

## Simple case 1. Side-To-Side Merge

## There are 2 different datasets about the same people.
## Or some of the same people.

set.seed(234234)
dat1 <- data.frame(id = 10:1, reading = rnorm(10))

dat2 <- data.frame(id = c(3,2,4,1,5, 6:10), math = runif(10)*10)


## Here's a mistake. See what's wrong? This is ghastly!

combo <- cbind(dat1, math = dat2$math)


## The easiest fix. Sort the two data sets so they
## are in the same row order.

dat1s <- dat1[ order(dat1$id), ]
dat1s
              
dat2s <- dat2[ order(dat2$id), ]
dat2s



## Method 1: Pick the correct columns to cbind, such as::

datCombo <- cbind( dat1s, math = dat2s$math)
datCombo[ datCombo$id, ]


## Or, equivalently

datCombo <- cbind( dat1s[ , c("id", "reading")], dat2s[ , "math"])
datCombo


## Now, make a list of ways in which this approach can go wrong.

## IT should be a long list. Go ahead. I'll wait.

## Here's one way it goes wrong

set.seed(234234)
dat1 <- data.frame(id = 14:1, reading = rnorm(14))
dat1s <- dat1[ order(dat1$id), ]

dat2 <- data.frame(id = c(3,2,4,1,5, 6:10), math = runif(10)*10)
dat2s <- dat1[ order(dat2s$id), ]


cbind(dat1s, dat2s)
## error



## Method 2: use R matching concepts. 

## What does this output mean?
match(dat1$id, dat2$id)

## We can use that to reorder dat1 to make its id variable
## match dat2

## 
d1matchd2 <- match(dat1$id, dat2$id)
## Finds the first match of dat1$id in dat2$id. Which element in dat2$ind
## equals each given value in dat1$ind.

## Reorder dat2 in the same way as dat1
dat2[ d1matchd2, ]

datCombo <- cbind(dat1, dat2$math[d1matchd2])
datCombo


## Method 3: use the merge function

merge(dat1, dat2, by = c("id"))

## Do we like that result?

merge(dat1, dat2, by = c("id"), all.x = TRUE)

## using argument names explicitly helps here
merge(x = dat1, y = dat2, by = c("id"), all.x = TRUE)
## all = TRUE, or all.y = TRUE and/or all.x = TRUE
merge(x = dat1, y = dat2, by = c("id"), all.y = TRUE)


set.seed(234234)
dat1 <- data.frame(id = 14:1, reading = rnorm(14) )
dat1s <- dat1[ order(dat1$id), ]

dat2 <- data.frame(id = c(3,2,4,1,5, 6:10), math = runif(10)*10)
dat2s <- dat1[ order(dat2s), ]




## Key ideas.
## Constantly double-check data to make sure the correct
## information is combined.

## R merge works well, as long as you double-check the result.
## Be conscious of how many cases you should have at the end,
## verify a goodly collection of rows.

