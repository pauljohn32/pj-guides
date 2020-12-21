## Paul E. Johnson
## 2013-05-18

## Insertion of an invalid factor level obliterates a valid score.
##
## I found a hard to track bug in a student project.
## Here's the essence of it.
x <- factor(c("a","b","a","b","b"))
x
x[4] <- 1
x

## Here's what you see in the terminal:
## > x[4] <- 1
## Warning message:
## In `[<-.factor`(`*tmp*`, 4, value = 1) : invalid factor level, NA generated
##
## That's unfortunate. I'd suggest that users should not ignore
## warnings .

## Now, x is damaged. Putting it to use
## damages other things. See?

y <- c(1, 2, 3, 4, 5)
names(y) <- c("a","b","c","d","e")
y[x]
names(y) <- c("g","h","i","a","b")
y[x]



