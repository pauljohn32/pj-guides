##Paul Johnson
## 2015-09-27

## Recently I noticed some old/new code in a project
## and think it is a pretty good example of the 
## process of converting a script that works
## into a function that works, so work can be
## segregated.



## Paul E. Johnson <pauljohn@ku.edu>
## Portable Parallel Seeds Project.

library(parallel)

RNGkind("L'Ecuyer-CMRG")
set.seed(23456)

## nrep = number of repetitions (or tasks)
## streamsPerRep = number of streams needed by each repetition
nReps <- 2000
streamsPerRep <- 3

## projSeeds=list of lists of stream seeds
projSeeds <- vector(mode="list", nReps)
for (i in 1:nReps) projSeeds[[i]] <- vector(mode="list", streamsPerRep)

runif(1) ##establishes .Random.seed
##Grab first seed
s <- .Random.seed
origSeed <- s

for (i in 1:nReps) {
  for (j in 1:streamsPerRep){
    projSeeds[[i]][[j]] <- s
    s <- nextRNGStream(s)
  }
}


save(nReps, streamsPerRep, projSeeds, file="projSeeds.rda")


##### 

Was revised into this, which is better

## Paul E. Johnson <pauljohn@ku.edu>
## Portable Parallel Seeds Project.

library(parallel)

RNGkind("L'Ecuyer-CMRG")
set.seed(23456)

## nrep = number of repetitions (or tasks)
## streamsPerRep = number of streams needed by each repetition
seedCreator <- function(nReps = 2000, streamsPerRep = 3, iseed){
  ## projSeeds=list of lists of stream seeds
  projSeeds <- vector(mode="list", nReps)
  for (i in 1:nReps) projSeeds[[i]] <- vector(mode="list", streamsPerRep)
  
  if (!exists(".Random.seed", envir = .GlobalEnv, inherits = FALSE))
    runif(1) ##establishes .Random.seed
  if (!is.missing(iseed)) set.seed(iseed)
  ##Grab first seed
  s <- .Random.seed
  origSeed <- s
  
  for (i in 1:nReps) {
    for (j in 1:streamsPerRep){
      projSeeds[[i]][[j]] <- s
      s <- nextRNGStream(s)
    }
  }

  save(nReps, streamsPerRep, projSeeds, file="projSeeds.rda")
  projSeeds
}

projSeeds <- seedCreator(2000, 3, iseed = 123456)



