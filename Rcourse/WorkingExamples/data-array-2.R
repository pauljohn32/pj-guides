## Paul E. Johnson
## 2013-07-10

## I like 2 dimensional arrays: matrices. I like data frames.  Two
## separate clients have asked for array help this week. If you saw
## data-array-1.R, you see I made some progress. Maybe then I'll be
## more ready to help when a problem like that comes along again if I
## work out some more array examples.

## But I still hate it. I'm scouring Internet for examples to chew on.

##
## Example 1. a 3x3x9 matrix that needs to be grouped by values of
## a factor.

## http://stackoverflow.com/questions/16135877/applying-a-function-to-a-multidimensional-array-with-grouping-variable

## User asked about working with an array.
V <- 1:81
dim(V) <- c(3, 3, 9) ## fast way to create array V
group <- c('a','a','a','b','b','b','c','c','c')
## User asks for advice about condensing the 3x3x9 array.
## "Given that the grouping variable has 3 levels (a, b and c),
## the result (out) I'm looking for is an array of dimension 3x3x3."

## Here's a solution that depends on the package abind

library(abind)

out1 <- apply(V[ , , c(1:3)], c(1, 2), sum)
out2 <- apply(V[ , , c(4:6)], c(1, 2), sum)
out3 <- apply(V[ , , c(7:9)], c(1, 2), sum)

out <- abind(out1, out2, out3, along = 3)

## User asks for a general R solution, not depending on abind.

## I have no idea what this code means.
out <- apply(V, c(1, 2), by, group, sum)

## The group and sum arguments aren't named, I can't tell what they are
## used for. So I had to go run by a whole lot of times, to figure
## out what it is doing.

## Aha. syntax: by(x, INDICES = group, FUN = sum)
## and x is a sub array extracted from V. Headache.

## Take one example from the array, choosing this piece:

myx1 <- V[1, 1, ]
## Apply by to just that one bit
by(myx1, INDICES = group, FUN = sum)
## Take another piece
myx2 <- V[1, 2, ]
by(myx2, INDICES = group, FUN = sum)
## so the apply puzzle clear up. It cycles over

## This uses aperm to take same and re-organize the dimensions.
out <- aperm(apply(V, c(1, 2), by, group, sum), c(2, 3, 1))

## OK, so I think I understand that one.



## Example 2. This is about "compressing" 2 "sections" into 1.
## I think it helps to visualize it with named dimensions and columns and rows
V <- array(1:27, c(3, 3, 3), dimnames = list("myDim1" = c("A","B","C"),
                             "myDim2" = c("G","H","I"),
                             "myDim3" = c("X","Y","Z")))
V
## Names really help me see what is up here
## Now you can ask for pieces by name!
V["A","G", ]

V["A", , ]


## Suppose you want to aggregate values "X" and "Y" by summing.
V[ , , "X"]
V[ , , "Y"]

V[ , , "X"] + V[ , , "Y"]

## Now, replace the bit that was V[ , , c("X","Y")] with that new thing.
## Appears this works, but seems dumb to me.
V[ , , "X"] <- V[ , , "X"] + V[ , , "Y"]

Vnew <- V[ , , c("X","Z")]
Vnames <- dimnames(Vnew)
Vnames$myDim3[1] <- "XandY"
dimnames(Vnew) <- Vnames
Vnew

## There's got to be a better way to collapse 2 slices


## Example 4. Take 3, but with a missing.
## Now, a relevant problem. What if there is an NA in one spot?

V["A", "G", "X"] <- NA
V
V[ , , "X"]
V[ , , "Y"]

V[ , , "X"] + V[ , , "Y"]
## If you want a missing in there, OK. But what if you want the
## NA to be treated as zero. Harder.

## Put the "Z" part out of the way. Here's one way
V[ , , -3]

## That's risky, 3 might be the wrong number. Can choose by name.
V[ , , -which(dimnames(V)[[3]] == "Z")]

VxAndy <- apply(V[ , , -which(dimnames(V)[[3]] == "Z")], MARGIN = c(1,2), FUN = sum, na.rm = T)
VxAndy

Vnew2 <- V[ , , c("X", "Z")]
Vnew2[ , , "X"] <- VxAndy

Vnames <- dimnames(Vnew2)
Vnames$myDim3[1] <- "XandY"
dimnames(Vnew2) <- Vnames
Vnew2
## Remember where we started.
Vnew


## Example 3. Transpose one slice from an array.
## http://stackoverflow.com/questions/13811133/apply-a-function-to-each-layer-of-a-3d-array-returning-an-array
A <- array (1:27, c(3,3,3))
A
## similar idea to previous example. Go through first and second dimensions,
##
apply(A, 1:2, t)


## The plyr package helps here too. I've seen it do amazing things to
## rearrange repeated observation data from wide to long.

library(plyr)

aaply(A,3,t)


