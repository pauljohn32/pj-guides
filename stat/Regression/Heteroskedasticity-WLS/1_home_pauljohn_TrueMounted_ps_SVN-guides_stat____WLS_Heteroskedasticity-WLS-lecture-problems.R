### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.T18802/lyx_tmpbuf0/1_home_pauljohn_TrueMounted_ps_SVN-guides_stat____WLS_Heteroskedasticity-WLS-lecture-problems.Rnw'

###################################################
### code chunk number 1: 1_home_pauljohn_TrueMounted_ps_SVN-guides_stat____WLS_Heteroskedasticity-WLS-lecture-problems.Rnw:1-2
###################################################
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 2: Roptions
###################################################
options(device = pdf)
options(width=160, prompt=" ", continue="  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par() 
pjmar <- c(5.1, 5.1, 1.5, 2.1) 
#pjmar <- par("mar")
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)


