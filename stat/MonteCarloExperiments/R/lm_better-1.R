## Paul Johnson
## 2015-10-28
##
## I broke code chunks out of mcExperiment-1-code
## for ease of use in lab exercises

## Demonstrates Chambers's method of snapshotting the seed's state for
## replication. It weaves the seed records onto the generated data.
## Does not show portableParallelSeeds.
## Does not show tricks in paramSweep.R

##<<better10,echo=T>>=
a <- 2; b <- 5; stde <- 100; N <- 100; Nexp <- 30
set.seed(4343432)
## FIXME: 50 and 100 are hard coded into function. Add as arguments.
getPhonyData <- function(N, a, b, stde){
    inState <- .Random.seed
    x <- rnorm(N, mean = 50, sd = 100)
    y <- a + b*x + rnorm(N, mean = 0, sd = stde)
    outState <- .Random.seed
    list(dat=data.frame("input" = x, "output" = y), "inState" = inState,
         "outState" = outState)
}



##<<better20,echo=T>>=
analyzePhonyData <- function(dat){
    ## Consider optimising, use lm.fit instead,
    ## set x=FALSE y=FALSE to turn off
    ## data storage
    mymod <- lm(output ~ input, data = dat)
}



## FIXME: I am lazy using variables from environment.
## Would not encourage this in more serious effort.
##
conductSim <- function(i){
    d1 <- getPhonyData(N, a, b, stde)
    res <- analyzePhonyData(d1$dat)
    list("res" = res, "d" = d1)
}



## FIXME: I am lazy using variables from environment.
## Would not encourage this in more serious effort.
##
mysims <- lapply(1:1000, conductSim)

## Confirm you get same with a for loop
##<<better65,echo=T>>=
.Random.seed <- mysims[[1]]$d$inState
mysims2 <- vector("list", 100)
for( i in 1:100) {
    mysims2[[i]] <- conductSim(i)
}

all.equal(mysims, mysims2)



## I considered various ways to work with the created
## results.  I find this intriguing.  rbinding lists
## creates an array of lists.
## <<better70,echo=T>>=
regs <- do.call("rbind", mysims)
dim(regs)
names(regs[[1,2]])
names(regs[[1,1]])
is.array(regs)
is.list(regs[,1])


## <<better71,echo=T>>=
summary(regs[[33,1]])
summary(regs[[34,1]])


## <<better72,echo=T>>=
lsimres <- lapply((regs[,1]), summary)


##<<better73,echo=T>>=
ssimres <- sapply((regs[,1]), summary)
## Note, output is "sideways" compared to what I expect
is.matrix(ssimres)
dim(ssimres)
rownames(ssimres)

##<<better75, fig=T, echo=T>>=
rsquares <- ssimres[8, ]
str(rsquares)
ursquares <- unlist(rsquares)
ursquares

## FIXME 1: insert a legend
## FIXME 2: use plot math to write R^2 like math
## FIXME 3: Wrap this into a function so you can call it over and over on
## various simulations.
hist(ursquares, xlab = "100 estimated R-squares", prob = TRUE, ylab = "proportion", main = "")
lines(density(ursquares), col = "red", lty = 2)




