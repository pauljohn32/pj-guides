### Paul Johnson
### June 21, 2010

### Suppose you have a data frame with some variables, and you have
### another variable that is a list of some "special" variable names.
### How can you carry out some regression for all of the "special"
### variables.



### Here's the example data frame
mydf <- data.frame("x1" = rnorm(100), "x2" = rnorm(100),
                   "y1" = rpois(100, lambda = 18),
                   "y2" = rpois(100, lambda = 3),
                   "y3" = rpois(100, lambda =  1),
                   "y4" = rpois(100, lambda = 1))

### For instance, suppose we want a regression for each dep. variable here:
specialVarNames <- c("y1","y2")

### First, figure how to run one particular element from
### specialVarNames

### 2 ways to run a regression for the first element of
### specialVarNames, which is "y1" (specialVarNames[1])

### 1. figure out which column has name [1] and grab that column 
mod1 <- lm(mydf[ , which(colnames(mydf) == specialVarNames[1])] ~ x1 + x2, data = mydf)
summary(mod1)

### Lacks finesse, but clear. It is the same as

magicColumnNumber <- which(colnames(mydf) == specialVarNames[1])
mod1 <- lm(mydf[,magicColumnNumber] ~ x1 + x2, data = mydf)
summary(mod1)


### 2. use the fact that a data frame is a list and items can
### be accessed as  mydf[["variableName"]].
mod2 <- lm(mydf[[specialVarNames[1]]] ~ x1 + x2, data = mydf)
summary(mod2)

### Same as
myVName <- specialVarNames[1]
mod2 <- lm( mydf[[myVName]] ~ x1 + x2, data = mydf)
summary(mod2)


### 3. perhaps the best, most elegant. A "formula" is a text
### string. So we can create the formula first, then run:
myNewFormula <- paste( eval(specialVarNames[1]), "~ x1 + x2")

mod3 <-lm(myNewFormula, data = mydf)
summary(mod3)


### Now do same work for each element in specialVarNames.
### Any clod could write a for loop. Let's be smarter
### and use lapply.

### First, create a function:
myFunc <- function(aString = NULL, dat = NULL){
  myNewFormula <- paste( eval(aString), "~ x1 + x2")
  mod3 <-lm( myNewFormula, data = mydf)
}

allRegs <- lapply(specialVarNames, function(X) myFunc(aString = X, dat = mydf))

### Just check item 2 in there
summary(allRegs[[2]])
### Just "parameters"? Do:
coef(summary(allRegs[[2]]))

### If you name the items in the regression list, then
### can access by name:
names(allRegs) <- specialVarNames

summary(allRegs[["y2"]])


### Can dump out list of all summaries:
lapply(allRegs, function(X) summary(X))


### Can easily massage output into a matrix of
### particulars from each models.
