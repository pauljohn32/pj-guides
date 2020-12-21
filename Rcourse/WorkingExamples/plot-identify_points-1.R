## Title: plot-identify-points-1
## Author: Paul Johnson <pauljohn at ku.edu>
## Date posted: 2013-02-08
## Description. Given a scatterplot, label particular points.
## Useful for identifying "outliers" or "interesting" cases.

## I forget how to do this and it is frustrating because
## it is very easy, as long as you understand the procedure

x <- rnorm(100)
y <- rnorm(100)
plot(x,y)

### In this example usage of identify, labels are just numbers from 1 to 100

identify(x,y, labels=1:100)

## CLICK the points in the scatter with the left button.
## Watch the R session while you click, it will tell you if you
## missed a point with your click.
##
## Note the positioning of the labels depends on where you click. See?

## Middle click to stop choosing points

## IF YOU DON'T middle click, you can never escape the control
## of that identify() function and you can't do any more work.

## Now do it with a data frame?

mydf <- data.frame(x,y)

rm(x,y)

plot(y ~ x, data = mydf)

##

with(mydf,
     identify(x, y, row.names(mydf))
     )

### Sometimes you will see this error in the console.
### The meaning is pretty obvious.

##warning: nearest point already identified
##warning: nearest point already identified
##warning: nearest point already identified
##warning: nearest point already identified
##warning: nearest point already identified


## In this example, I used the integers as the names.  So let's
## make up some names with letters.
## Obviously, if you had "state names" or something nice, you could
## use them.  I'm just using the letters for ease of illustration.

mydf$myText <- paste( rep(letters[1:25]), 1:100, sep="-")

plot(y ~ x, data = mydf)

with (mydf,
      identify(x,y, myText)
      )

##Could assign those as row names, as long as they are unique.
## Otherwise, just leave them as a column in the data frame.

row.names(mydf) <- mydf$myText
mydf$myText <- NULL

plot(y ~ x, data = mydf)

with(mydf,
     identify(x, y, row.names(mydf))
     )
