### R code from vignette source '/home/pauljohn/SVN/SVN-guides/Rcourse/functions-1/functions-1.5-codingn.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: functions-1.5-codingn.Rnw:88-89
###################################################
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 2: Roptions
###################################################
options(width=200, prompt="> ", continue=" ")
options(useFancyQuotes = FALSE)
set.seed(12345)
op <- par()
pjmar <- c(5.1, 4.1, 1.5, 2.1)
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=10)))
pdf.options(onefile=F,family="Times",pointsize=6)
ps.options(horizontal=F, onefile=F, family="Times", paper="special", height=3, width=4.75)
options(papersize="special")


###################################################
### code chunk number 3: functions-1.5-codingn.Rnw:484-524 (eval = FALSE)
###################################################
## 
## ##Create one MPlus Input file corresponding to following parameters.
## createInpFile <- function(path="apath", gen="afilename.inp", perclust=2, nclust=100, iter=1000, mod=1, strong=1, between=1, within=1){
## 
##     ## Here is one cat that writes out the top stanza
##     cat("MONTECARLO:
##       NAMES ARE y1-y6;
##       NOBSERVATIONS = ", perclust*nclust, "; \n",
##       ifelse(perclust != 7.5 ,
##              paste("NCSIZES = 1; \n   CSIZES = ", nclust, "(", perclust, ");\n"),
##              paste("NCSIZES = 2; \n   CSIZES = ", nclust/2, " (7) ", nclust/2 , " (8); \n" ) ), file=gen,   append=T,
##       sep="")
##     
##     ##Writes out another section: user-specified iterations
##     cat( "NREPS = ", iter, ";
##        SEED = 791305;
##        REPSAVE=ALL;
##        SAVE=", path, "\\data*.dat;
##        ANALYSIS: TYPE = TWOLEVEL;
##        MODEL POPULATION:
##        %WITHIN% \n", file=gen, append=T, sep="")
## 
##     ## baseline loadings are all .3, add .4 if "within" = 1, but change based on mod/strong
##     ## Writes out section specifying models
##     cat("FW BY y1-y2*", .3+(within*(.4+strong*.1)),
##         "y3-y4*", .3+(within*(.4-mod*.3)),
##         "y5-y6*", .3+(within*(.4-strong*.1)),
##         "FW@1; \n",
##         "y1-y2*", 1-(.3+(within*(.4+strong*.1)))^2, "; \n",
##         "y3-y4*", 1-(.3+(within*(.4-mod*.3)))^2, "; \n",
##         "y5-y6*", 1-(.3+(within*(.4-strong*.1)))^2, "; \n",
##         " %BETWEEN% ",
##         "FB BY y1-y2*", sqrt((.3+(between*(.4+strong*.1)))^2*(1+(icc*(.053-1)))),
##         "y3-y4*", sqrt((.3+(between*(.4-mod*.3)))^2 *(1+(icc*(.053-1)))),
##         "y5-y6*", sqrt((.3+(between*(.4-strong*.1)))^2 *(1+(icc*(.053-1)))),"; FB@1;  \n",
##         "y1-y2*", 1+(icc*(.053-1))-sqrt((.3+(between*(.4+strong*.1)))^2*(1+(icc*(.053-1))))^2, ";",
##         "y3-y4*", 1+(icc*(.053-1))-sqrt((.3+(between*(.4-mod*.3)))^2 *(1+(icc*(.053-1))))^2, ";",
##        "y5-y6*", 1+(icc*(.053-1))-sqrt((.3+(between*(.4-strong*.1)))^2 *(1+(icc*(.053-1))))^2, ";",
##        "\n", file=gen, append=T, sep="")
## }


