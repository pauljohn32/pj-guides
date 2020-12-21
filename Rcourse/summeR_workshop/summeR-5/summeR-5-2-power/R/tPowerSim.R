## Paul Johnson
## 20180517

## My workbench for the power analysis example with
## 2 groups and possibly unequal variances

tPowerSim <- function(conds, var.equal = TRUE){

    getTdata <- function(rep, N, M, SD) {
        Nvec <- as.numeric(unlist(strsplit(N, ":")))
        Mvec <- as.numeric(unlist(strsplit(M, ":")))
        SDvec <- as.numeric(unlist(strsplit(SD, ":")))
        
        dat <- data.frame(first = c(rep(0, times = Nvec[1]),
                                    rep(1, times = Nvec[2])))
        dat$IQ <- rnorm(sum(Nvec), m = Mvec[(dat$first + 1)], 
                        sd = SDvec[(dat$first + 1)])
        dat$IQ <- round(dat$IQ)
        attr(dat, "rep") <- rep
        attr(dat, "parms") <- c(N = N, M = M, SD = SD)
        dat
    }

    conductTtest <- function (dframe, y = "IQ", x = "first", var.equal){
        t.test(formula(paste(y, "~", x)),
               data = dframe, var.equal = var.equal)$p.value
    }
    
    runOneSim <- function(rep, N, M, SD, var.equal){
        dframe <- getTdata(rep, N = N, M = M, SD = SD)
        reslt <- conductTtest(dframe, var.equal = var.equal)
        parms <- attr(dframe, "parms")
        dframe2 <- data.frame(rep = attr(dframe, "rep"), 
                              pvalue = reslt,
                              reject.05 = if (reslt <= 0.05) 1 else 0,
                              reject.1 = if (reslt <= 0.10) 1 else 0,
                              N = parms["N"], M = parms["M"], SD = parms["SD"])
        dframe2
    }


    runOneCondition <- function(i, conds, var.equal){
        x <- conds[i, ]
        result.list <- lapply(1:x$nReps, runOneSim, 
                              N = x$N, M = x$M, SD = x$SD, var.equal = var.equal)
        do.call("rbind", result.list)
    }

    listofresults <- lapply(1:NROW(conds), runOneCondition, conds, var.equal = var.equal)
    stackedResults <- do.call(rbind, listofresults)
    output <- aggregate(stackedResults[, c("reject.05", "reject.1")],
                        by = list(N = stackedResults$N, SD = stackedResults$SD, M = stackedResults$M),
                        mean)
    names(output) <- c("N", "SD", "M", "reject.05.mean", "reject.1.mean")
    output
}


    
cond.N <- c("30:30", "40:20")
cond.SD <- c("10:20", "15:15", "20:10")
cond.M <- c("100:100") # for now, mean-difference = 0
conds <- expand.grid(nReps = 1000, SD = cond.SD, N = cond.N, M = cond.M,
                     stringsAsFactors = FALSE)
head(conds)

tPowerSim(conds, var.equal = TRUE)
tPowerSim(conds, var.equal = FALSE)



## Power analysis is the study of data group sizes
 
cond.N <- c("30:30", "40:20", "100:100")
cond.SD <- c("10:20", "15:15", "20:10")
cond.M <- c("100:105")

conds <- expand.grid(nReps = 1000, SD = cond.SD, N = cond.N, M = cond.M,
                     stringsAsFactors = FALSE)
tPowerSim(conds, var.equal = TRUE)
tPowerSim(conds, var.equal = FALSE)

cond.M <- c("100:106") 

conds <- expand.grid(nReps = 1000, SD = cond.SD, N = cond.N, M = cond.M,
                     stringsAsFactors = FALSE)
tPowerSim(conds, var.equal = TRUE)
tPowerSim(conds, var.equal = FALSE)

cond.N <- c("100:100", "150:150", "150:100", "100:150")
conds <- expand.grid(nReps = 1000, SD = cond.SD, N = cond.N, M = cond.M,
                     stringsAsFactors = FALSE)
tPowerSim(conds, var.equal = TRUE)
tPowerSim(conds, var.equal = FALSE)

cond.M <- c("100:110")
conds <- expand.grid(nReps = 1000, SD = cond.SD, N = cond.N, M = cond.M,
                     stringsAsFactors = FALSE)
tPowerSim(conds, var.equal = TRUE)
