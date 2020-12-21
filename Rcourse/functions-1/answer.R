##This is me, taunting you. Still


numOnes <- 4

x <- c(rep(1, numOnes), rep(0, 7-numOnes))


total <- 44

x <- c(rep(1, numOnes), rep(0, total-numOnes))


magicVectorMaker <- function(tot, y){
  c(rep(1, y), rep(0, tot - y))
}


magicVectorMaker(14, 2)
