### R code from vignette source 'summeR-2-5-graphics-uniquebackupstring.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: summeR-2-5-graphics-uniquebackupstring.Rnw:40-41
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: tmpout
###################################################
tdir <- "tmpout"
if(!dir.exists(tdir)) dir.create(tdir, showWarnings=FALSE)


###################################################
### code chunk number 3: Roptions
###################################################
opts.orig <- options()
options(width=100, prompt="> ")
options(useFancyQuotes = FALSE)
set.seed(12345)
par.orig <- par(no.readonly = TRUE) 
pjmar <- c(4.1, 4.1, 1.5, 2.1)
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12, xpd=F)))
pdf.options(onefile=F,family="Times",pointsize=12)
if(!file.exists("theme")) file.symlink("../../../../template/theme", "theme")


###################################################
### code chunk number 4: saver10 (eval = FALSE)
###################################################
## pdf("myfirst.pdf")  
## hist(rnorm(1000), main = "1000 random normals") 
## dev.off()


###################################################
### code chunk number 5: summeR-2-5-graphics-uniquebackupstring.Rnw:409-410 (eval = FALSE)
###################################################
## list.files() 


###################################################
### code chunk number 6: summeR-2-5-graphics-uniquebackupstring.Rnw:448-450
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 7: saver14 (eval = FALSE)
###################################################
## SAVEME <- FALSE
## if (SAVEME){
##   pdf(file = "afilename.pdf", paper = "special", 
##      height = 5, width = 7, onefile = FALSE, family = "Times")
## } else {
##   ## If you are not using Rstudio, this works in an interactive session
##   if (interactive()) dev.new(height = 5, width = 7)
## }
## plot(y ~ x, data = dat, xlab = "My super plot", ylab = "My other variable", main = "smarter than you")
## lines(z ~ x, data = dat, col = "green")
## if (SAVEME) dev.off()


###################################################
### code chunk number 8: summeR-2-5-graphics-uniquebackupstring.Rnw:468-469
###################################################
options(options.orig)


###################################################
### code chunk number 9: saver11
###################################################
odir <- "output/"
chk <- dir.create(odir, recursive = TRUE)
print(chk)


###################################################
### code chunk number 10: saver12
###################################################
pdf(file.path(odir, "myfirst.pdf"))
hist(rnorm(1000), main = "1000 random normals") 
dev.off()


###################################################
### code chunk number 11: saver13
###################################################
odir2 <- rockchalk::dir.create.unique("output/")
odir2


###################################################
### code chunk number 12: saver14b (eval = FALSE)
###################################################
## pdf(file = file.path(odir2, "myfirst.pdf"))
## hist(rnorm(1000), main = "1000 random normals") 
## dev.off()
## list.files(odir2)


###################################################
### code chunk number 13: summeR-2-5-graphics-uniquebackupstring.Rnw:533-535 (eval = FALSE)
###################################################
## pdf(file = "afilename.pdf", height = 5, width = 7,
## paper = "special", onefile = FALSE, family = "Times")


###################################################
### code chunk number 14: saver20
###################################################
SAVEME <- TRUE
if (SAVEME){
    odir <- rockchalk::dir.create.unique("output/")
    pdf(file = file.path(odir, "histo-100.pdf"), onefile = TRUE)
} else {
	par(ask = TRUE)
}
set.seed(234)
for(i in 1:100){
	x <- rpois(20, lambda = 4)
	hist(x, main = paste("Run number", i),
         breaks = -0.5:15.5,
         xlim = c(0, 15), xlab = "histogram",
        )
}
if (SAVEME) dev.off()


###################################################
### code chunk number 15: saver30
###################################################
SAVEME <- TRUE
if (SAVEME){
    odir <- rockchalk::dir.create.unique("output/")
    print(odir)
    pdf(file = paste0(odir, "/histo-%03d.pdf"), onefile = FALSE)
} else {
	par(ask = TRUE)
}
set.seed(234)
for(i in 1:100){
	x <- rpois(20, lambda = 4)
	hist(x, main = paste("Run number", i),
         breaks = -0.5:15.5,
         xlim = c(0, 15), xlab = "histogram",
        )
}
if (SAVEME) dev.off()



###################################################
### code chunk number 16: summeR-2-5-graphics-uniquebackupstring.Rnw:638-640
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 17: summeR-2-5-graphics-uniquebackupstring.Rnw:645-647
###################################################
## the first 30 file names
list.files(odir)[1:30]


###################################################
### code chunk number 18: summeR-2-5-graphics-uniquebackupstring.Rnw:650-651
###################################################
options(options.orig)


###################################################
### code chunk number 19: summeR-2-5-graphics-uniquebackupstring.Rnw:661-662 (eval = FALSE)
###################################################
## pdf.options(onefile = FALSE, family = "Times", paper = "special", height = 4, width = 6)


###################################################
### code chunk number 20: summeR-2-5-graphics-uniquebackupstring.Rnw:667-670 (eval = FALSE)
###################################################
## if (SAVEME) pdf(file = "afilename.pdf")
## ## make a plot, silly
## if (SAVEME) dev.off()


###################################################
### code chunk number 21: summeR-2-5-graphics-uniquebackupstring.Rnw:676-679 (eval = FALSE)
###################################################
## if (SAVEME) pdf(file = "afilename.pdf", height = 10, width = 7)
## ## make a plot, silly
## if (SAVEME) dev.off()


###################################################
### code chunk number 22: summeR-2-5-graphics-uniquebackupstring.Rnw:700-703 (eval = FALSE)
###################################################
## if (SAVEME) png(file = "afilename.png", height = 800, width = 800)
## ## draw your plot here
## if (SAVEME) dev.off()


###################################################
### code chunk number 23: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 24: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


