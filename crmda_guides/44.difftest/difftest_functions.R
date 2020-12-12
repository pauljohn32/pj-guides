
##' Parse an Mplus difftest file
##'
##' Creates a list with the following elements:
##'
##' \itemize{
##' \item{T:}{ discrepancy, unscaled squared differences of s and sigma }
##' \item{groups:}{ integer for number of groups}
##' \item{sampStats:}{  number of sample statistics}
##' \item{params:}{ number of parameters in model}
##' \item{Delta:}{ matrix of derivatives}
##' \item{P:}{matrix P}
##' \item{V:}{matrix}
##' }
##' @param diff A text file with one column created by Mplus
##' @return A list with 7 objects.
##' @author Ben Kite <bakite@@ku.edu>
##' @examples
##' d1 <- diffReader("../output/m1.dif")
diffReader <- function(diff) {
    require(MplusAutomation)
    x <- read.table(diff)
    header <- x[1:4, ]
    T <- header[1]
    groups <- header[2]
    samplestats <- header[3]
    params <- header[4]
    deltasize <- samplestats*params*groups
    psize <- (params*params - params)/2 + params
    vsize <- (params*params - params)/2 + params
    if (nrow(x) - 4 - deltasize - psize - vsize != 0){
        stop("could not parse matrices correctly!")
    }
    x <- x[5:nrow(x), ]
    Delta <- matrix(x[1:deltasize], nrow = samplestats*groups, byrow = TRUE)
    p <- x[(deltasize + 1):(deltasize + psize)]
    P <- matrix(0, nrow = params, ncol = params)
    i <- 1
    for (k in 1:params){
        for (j in 1:params){
            if (j <= k){
                P[k, j] <- p[i]
                P[j, k] <- p[i]
                i <- i + 1
            }
        }
    }
    v <- x[(length(x) + 1 - vsize):length(x)]
    V <- matrix(0, nrow = params, ncol = params)
    i <- 1
    for (k in 1:params){
        for (j in 1:params){
            if (j <= k){
                V[k,j] <- v[i]
                V[j,k] <- v[i]
                i <- i + 1
            }
        }
    }
    out <- list()
    out[["T"]] <- T
    out[["groups"]] <- groups
    out[["sampStats"]] <- samplestats
    out[["params"]] <- params
    out[["Delta"]] <- Delta
    out[["P"]] <- P
    out[["V"]] <- V
    out
}

##' Does T3 chisq difference scaling procedure discribed by Asparohov and Muthen (2010).
##'
##' @param T1 T value from difftest file in parent model.
##' @param T0 T value from difftest file in nested model.
##' @param DF1 df value for parent model.
##' @param DF0 df value for nested model.
##' @param N Total sample size.
##' @param Delta1 Delta matrix for parent model from difftest file.
##' @param P P matrix for parent model from difftest file.
##' @param V V matrix for parent model from difftest file.
##' @param Delta0 Delta matrix for nested model from difftest file.
##' @param T2 Logical indicating if the T2 statistic described by
##'     Asparohov and Muthen (2006) should be returned. Defaults to
##'     FALSE.
##' @return T3 corrected chi-square value, or a T2 value if T2 = TRUE.
##' @author Ben Kite <bakite@@ku.edu>
lav_diff_mplus2010 <- function(T1, T0, DF1, DF0, N, Delta1, P, V, Delta0, T2 = FALSE){
    require(psych)
    T.chisq <- (T0 - T1)*sum(N)*2L
    D <- DF0 - DF1
    #H <- solve(t(Delta1) %*% Delta1) %*% t(Delta1) %*% Delta0
    H <- solve(crossprod(Delta1), crossprod(Delta1, Delta0))
    M <- (P - P %*% H %*%solve((t(H) %*% P %*% H))%*% t(H) %*% P) %*% V
    sdiagM2 <- sum(diag(M %*% M))
    if (isTRUE(T2)){
        d1 <- (tr(M)^2)/sdiagM2
        d <- floor(d1 +.5)
        T2 <- (d/tr(M))*T.chisq
        p <- pchisq(T2, d, lower.tail = FALSE)
        output <- data.frame("CRMDA_DIFFTEST_VALUE" = round(T2, 3), "DF" = round(d1,3), "p" = round(p, 4))
    }else{
        a <- sqrt(D/sdiagM2)
        b <- D - sqrt((D*(tr(M)^2))/sdiagM2)
        T3 <- T.chisq*a + b
        p <- pchisq(T3, D, lower.tail = FALSE)
        output <- data.frame("CRMDA_DIFFTEST_VALUE" = round(T3, 3), "DF" = as(D, "integer"), "p" = round(p, 4))
    }
    output
}

##' Conducts Mplus DIFFTEST
##'
##' @param out1 Mplus output file for parent model.
##' @param out0 Mplus output file for nested model.
##' @param samplesize Total sample size for data provided to
##'     Mplus. For now this is necessary if there are multiple groups.
##' @param compare2mplus Logical indicating if the DIFFTEST value
##'     should be extracted from the Mplus output.
##' @param T2 Logical indicating if the T2 statistic described by
##'     Asparohov and Muthen (2006) should be returned. Defaults to
##'     FALSE.
##' @return Mplus DIFFTEST with corrected chi-square value.
##' @author Ben Kite <bakite@@ku.edu>
crmda_difftest <- function(out1, out0, samplesize = NULL, compare2mplus = TRUE, T2 = FALSE){
    require(MplusAutomation)
    mplusdir1 <- paste0(dirname(out1), "/")
    mplusdir0 <- paste0(dirname(out0), "/")
    o1 <- readModels(out1)
    o0 <- readModels(out0)
    m1 <- paste0(mplusdir1, o1$savedata_info$fileName)
    m0 <- paste0(mplusdir0, o0$savedata_info$fileName)
    groups <- o1$summaries["NGroups"][[1]]
    if (is.null(samplesize)){
        if (groups == 1){
            samplesize <- o1$summaries["Observations"][[1]]
        } else {
            stop("For now, you must supply a sample size with multiple groups. MplusAutomation can't find the sample size for us.")
        }
    }

    d1 <- diffReader(m1)
    d0 <- diffReader(m0)
    delta1 <- d1[["Delta"]]
    delta0 <- d0[["Delta"]]
    pmat <- d1[["P"]]
    pmat0 <- d0[["P"]]
    vmat <- d1[["V"]]
    df1 <- d1[["sampStats"]]*d1[["groups"]] - d1[["params"]]
    df0 <- d0[["sampStats"]]*d0[["groups"]] - d0[["params"]]
    output <- lav_diff_mplus2010(d1[["T"]], d0[["T"]], df1, df0, samplesize, d1[["Delta"]], d1[["P"]], d1[["V"]], d0[["Delta"]], T2)
    if(isTRUE(compare2mplus)){
        if(sum(c("ChiSqDiffTest_Value", "ChiSqDiffTest_DF", "ChiSqDiffTest_PValue") %in% names(o0$summaries)) == 3){
            mplusout <- o0$summaries[c("ChiSqDiffTest_Value", "ChiSqDiffTest_DF", "ChiSqDiffTest_PValue")]
            names(mplusout) <- c("MPLUS_DIFFTEST_VALUE", "DF", "p")
            return(list("R computations" = output, "Mplus computations" = mplusout))
        } else {
            warning(paste("The Mplus DIFFTEST results couldn't be found in ", out0, ". Ensure that the difftest file for the parent model is provided in the analysis command for the nested model."))
            return(output)
        }
    } else {
        return(output)
    }
    output
}

##' Conducts Mplus DIFFTEST procedure for two nested lavaan models.
##'
##' Currently only designed for models estimated with DWLS (i.e., "DWLS"
##' or "WLSMV"). Matches results obtained in Mplus very closely.
##'
##' @param mout1 lavaan output for parent model
##' @param mout0 lavaan output for nested model
##' @param T2 Logical indicating if the T2 statistics from Asparohov
##'     and Muthen (2006) should be computed. Defaults to FALSE.
##' @return T3 corrected chi-square value provided by
##'     lav_diff_mplus2010
##' @author Benjamin Arthur Kite
CRMDA_lav_difftest <- function(mout1, mout0, T2 = FALSE){
    ## Check to ensure that both models have the same estimator.
    est1 <- mout1@Model@estimator
    est0 <- mout0@Model@estimator
    if (est1 != est0){
        stop("The parent model is estimated with ", est1, ", whereas the nested model is estimated with ", est0)
    }else{
        ## We only trust this for DWLS, allow it to run but warn the user.
        if(est1 != "DWLS"){
            warning(paste0("Currently the difftest procedure is only suggested for models estimated with DWLS."))
        }
    }
    require(psych)
    N <- do.call("sum", mout1@Data@nobs)
    sampleprops <- unlist(mout1@Data@nobs)/N
    T1l <- mout1@Fit@fx
    DF1l <- mout1@test[[1]]$df
    ## Must obtain a single W matrix.
    W1l <- lavTech(mout1, "WLS.V")
    for (w in 1:length(W1l)){
        W1l[[w]] <- W1l[[w]] * sampleprops[w]
    }
    Wtext <- paste0("diag(c(", paste0("diag(W1l[[", seq(1, length(W1l)), "]])", collapse = ", "), "))")
    W1l <- eval(parse(text = Wtext))
    ## Need a single Gamma matrix
    G1l <- lavTech(mout1, "Gamma")
    groups <- length(G1l)
    if (groups > 1){
        tmp <- matrix(0, nrow(G1l[[1]])*length(G1l), ncol(G1l[[1]])*length(G1l))
        dims <- c(1, nrow(G1l[[1]]))
        for (i in 1:groups){
            tmp[c(dims[1]:dims[2]), c(dims[1]:dims[2])] <- G1l[[i]] / sampleprops[i]
            dims <- dims + nrow(G1l[[1]])
        }
        G1l <- tmp
    } else {
        G1l <- G1l[[1]]
    }
    D1l <- do.call("rbind", lavTech(mout1, "Delta"))
    constraintM1 <- mout1@Model@eq.constraints.K
    ## If there are model constraints, multiply the contraint matrix and delta
    if (sum(dim(constraintM1)) > 0){
        D1l <- D1l %*% constraintM1
    }
    Pl <- t(D1l) %*% W1l %*% D1l
    Vl <- solve(Pl) %*% t(D1l) %*% W1l %*% G1l %*% W1l %*% D1l %*% solve(Pl)
    T0l <- mout0@Fit@fx
    DF0l <- mout0@test[[1]]$df
    D0l <- do.call("rbind", lavTech(mout0, "Delta"))
    constraintM <- mout0@Model@eq.constraints.K
    ## If there are model constraints, multiply the contraint matrix and delta 
    if (sum(dim(constraintM)) > 0){
        D0l <- D0l %*% constraintM
    }
    output <- lav_diff_mplus2010(T1l, T0l, DF1l, DF0l, N, D1l, Pl, Vl, D0l, T2)
    output
}

