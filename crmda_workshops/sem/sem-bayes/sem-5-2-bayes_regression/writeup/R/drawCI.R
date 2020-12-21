## Paul Johnson
## 2015-07-14
## 2018-04-13


##' Create a Gelman-Hill style plot, emphasizing shrinkage.
##'
##' Horizontal has sample size, vertical has estimate and CI This
##' style of plot is emphasized in Gelman and Hill, chapter 12.2, but
##' I've made it a free standing function.
##'
##' Draws a reference line at the median of the y variable
##' 
##' As far as I can tell, these intervals are 2*std.error in total
##' width, 1sd on either side.  I need to find out why not 1.95 or
##' such.
##' @param x A sample size number for the horizontal axis
##' @param y A value that is predicted, conditional mode, BLUP, etc
##' @param z standard error of y, will be scaled +1, -1
##' @param focal Row Numbers of cases that deserve special emphasis in
##'     the graph. Will be circled.
##' @param labelfocal Should we label the emphasized points?
##' @param main Main for top of graph
##' @param xlab x label
##' @param ylab y label
##' @param xlim limits of the x axis.
##' @param ylim limits of the y axis. If unspecified, function will
##'     choose round numbers that leave some "padding"
##' @return list with elements xlim, ylim, focal
##' @author Paul Johnson <pauljohn@@ku.edu>
drawCI <- function(x, y, z, focal = NULL, labelfocal = FALSE,
                   main = "CI Plot",
                   xlab = "Sample size within unit (jittered)",
                   ylab = "Estimate with +/- standard error",
                   xlim = NULL,
                   ylim = NULL){
    if(is.null(ylim)){
        ylim <- rockchalk::magRange(c(y-z, y + z), 1.1)
        ylim[1] <- floor(ylim[1])
        ylim[2] <- ceiling(ylim[2])
    }

    if(is.null(xlim)){
        xlim <- range(x)
    }
    
    plot.default(x, y, cex.lab = .9, cex.axis = 1,
          xlab = xlab,
          ylab = ylab,
          log = "x",
          ##cex = .3,
          ylim = ylim,
          xlim = xlim,
          axes = FALSE,
          type = "n")
    box()
    points(x, y, cex = 1, pch = 20)
    axis (1, c(1, 3, 10, 30, 100), cex.axis = .9,  mgp = c(1.5, .5, 0))
    axis (2, seq(ylim[1], ylim[2], by = 0.5), cex.axis = .9,
          mgp = c(1.5, .5, 0))
    
    for (j in seq_along(y)){
        lines (rep(x[j],2), y[j] + c(-1,1)*z[j], lwd = .5)
    }
    abline(h = median(y))
    points(x[focal], y[focal], cex = 4)
    if (labelfocal){
        text(x[focal] - .035,   y[focal],
             focal, cex = 0.8, bg = "white")
    }
    title(main, cex.main = .9, line = 1)
    list(ylim = ylim, xlim = xlim, focal = focal)
}
