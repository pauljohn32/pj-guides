## Paul Johnson <pauljohn@ku.edu>
## 20170911
## 20180920: bringing this full service, add png to git, commit, upload

## Longcan Huang <longcan@ku.edu>
## 20171030

## Hopefully, running this
## 1. Scans the tex file for committed tex files
## 2. makes pngs, checks to see if they are altered
## 3. If they are new or altered, then they are added, committed.
## 4. Rebuild the README file in front page
## 5. Runs git push



topdir <- "./"
topdir.full <- normalizePath(topdir)
tdir <- "."
tdir.full <- normalizePath(tdir)
odir <- "./tmpout"
if(file.exists(odir)) unlink(odir, recursive = TRUE)
dir.create(odir, recursive = TRUE)

## set up example class names
exampleClasses <- c("beamer"="beamer",
                    "tikzposter"="tikzposter",
                    "a0poster"="a0poster",
                    "D"="D")

## PJ 20170912
## Explanation: Goal is to prevent needless copying of
## same "newly" created png file into git every time this
## program runs. So only copy png if it is truly different.

## Step 1 is to get image signatures for each existing png.
## Scan tex folder for subdirs that have one/more png file(s).
## For each one that does, create an .md5sums.rds
## file. When there are new pngs calculated, we will calculate
## md5sums for each and use them to tell if the png file is altered.
## After some testing, I found out that each time you generate
## an equivalent png, the md5sum changes because the timestamp
## inside the image changes. So instead of using R md5sum, we
## need the "image signature", which ImageMagicK can provide
## https://www.imagemagick.org/discourse-server/viewtopic.php?t=23399
##
## TODO: only run this if there are png files not currently saved
## in .md5sums.rds file. How?
## TODO: figure out if getting signature is costly enough to
## make fussing worthwhile.
tdir.subdirs <- list.dirs(tdir,  recursive = FALSE)
tdir.subdirs <- list.dirs(tdir.subdirs, recursive = FALSE)
## Drop subdirs that don't have any png
tdir.subdirs <-
    tdir.subdirs[vapply(tdir.subdirs,
                        function(x) length(list.files(x, pattern = "pdf$")) > 0,
                        logical(1))]


createMD5pngtracker <- function(x){
    fn <- ".md5sums.rds"
    pngfiles <- list.files(x, pattern = "png")
    if (length(pngfiles) == 0) {
        print("hello")
        saveRDS(c("nullName" = "nullMD5sum"), file = fn)
    }
    md5sums <- vapply(pngfiles, function(y){
        ## Use ImageMagick to get signature
        system(paste("identify -verbose -format \"%#\"", file.path(x, y)), intern = TRUE)
    }, character(1))
    saveRDS(md5sums, file = file.path(x, fn))
    system(paste("git add", file.path(x, fn)))
    system(paste("git commit", file.path(x, fn), "-m \"md4sum update", file.path(x, fn), "\""))
    return(file.path(x, fn))
}

pngmd5files <- vapply(tdir.subdirs, createMD5pngtracker, character(1))


odir <- normalizePath(odir)

system(paste("git ls-files", "tex", " | tar cT - | tar -x -C ", odir))

setwd(tdir)
list.files(".")

system(paste("git ls-files . | tar cT - | tar -x -C ", odir))

dirs <- list.dirs(path = odir, recursive = FALSE)
## dirs <- list.files(path = odir, recursive = TRUE)

setwd(odir)
wd.orig <- getwd()

for (dir in dirs) {
    ind.dir <- list.dirs(path = dir, recursive = FALSE)
    for (j in ind.dir) {
        setwd(j)
        print(j)
        rel.dir <- unlist(strsplit(j, "tmpout/"))[-1]
        fn.md5 <- ".md5sums.rds"
        if (file.exists(fn.md5)) {
            md5sums <- readRDS(fn.md5)
        }
        fnsf <- list.files(pattern = "tex$")
    ## Remove the setupXX.tex files from the list
    ## fnsf <- grep("^(?!setup).*tex$", fnsf, perl = TRUE,  value = TRUE)
        print(fnsf)
        for(i in fnsf) {

        ## TODO: Only run this if tex file is newer than pdf file. How check? Cache?
        ## RUN <- paste("texi2pdf -q", i)
        ## print(RUN)
        ## system(RUN)
        ## TODO: related: write png here, then only copy if different.
        ## TODO: Find out how to check inf convert fails, and issue error message
            fn.pdf <-  gsub("tex$", "pdf", i)
            fn.png <- gsub("tex$", "png", i)
            RUN2 <- paste("convert -quality 100 -flatten -strip -geometry 500",
                          fn.pdf, fn.png)
            system(RUN2)
            RUN3 <- paste("identify -verbose -format \"%#\"", fn.png)
            fn.png.md5 <- system(RUN3, intern = TRUE)
            if (!(fn.png %in% names(md5sums)) || fn.png.md5 != md5sums[fn.png]) {
                fn.png.fullpath <- file.path(topdir.full, rel.dir, fn.png)
                file.copy(from = fn.png,
                          to = fn.png.fullpath,
                          overwrite = TRUE)
                print(paste("md5sum changed:", fn.png))

                RUN4a <- paste("git add", fn.png.fullpath)
                system(RUN4a)
                RUN4b <- paste("git commit", fn.png.fullpath,
                               "-m \"png image update:", fn.png,"\"")
                system(RUN4b)
            }
        }
    }
    setwd(wd.orig)
}

setwd(topdir.full)


## Now rebuild the README.md file, using png we find in the
## tex folder

## Erase README.md, and re-start with HEADER.md content
unlink(file.path(topdir.full, "README.md"))
fcopy <- file.copy(from = file.path(topdir.full, "HEADER.md"),
          to =  file.path(topdir.full, "README.md"),
          overwrite = TRUE)
if (!fcopy) {
    MESSG <- "file.copy failed"
    stop(paste(MESSG))
}

fn.png <- list.files(path = odir, pattern = "png$", recursive = TRUE,
                     full.names = FALSE)
names(fn.png) <- gsub(".png", "", fn.png)
fn.tex <- list.files(path = odir, pattern = "tex$", recursive = TRUE,
                     full.names = FALSE)
## Remove the setupXX.tex files from the list
## fn.tex <- fn.tex[grep("^(?!setup).*tex$", basename(fn.tex), perl = TRUE)]
##names(fn.tex) <- gsub(".tex", "", basename(fn.tex))
names(fn.tex) <- gsub(".tex", "", fn.tex)

header <- vector(length=length(fn.png))
k <- 1
for (i in names(fn.tex)) {

    texfn <- fn.tex[i]
    pngfn <- fn.png[i]
    pathdirs <- unlist(strsplit(i, "/"))
    parentdir <- pathdirs[(length(pathdirs) - 2)]
    classHeader <- exampleClasses[parentdir]
    ## print(classHeader)
    header[k] <- classHeader

    if (k == 1 || header[k] != header[k-1]) {
        cat(paste0("<br><br><br>\n## ",
                   classHeader,
                   "\n<br><br>\n"
                  ),
            file=file.path(topdir.full, "README.md"), append=TRUE)
    }

    fn.nosuffix <- names(texfn)
    pngfn <- fn.png[fn.nosuffix]
    ## pdffn <- gsub(".tex", ".pdf", texfn, fixed=TRUE)

    resline <- paste0(
        "<kbd>",
        "<a href=\"", texfn, "\">",
        "<img src=\"", pngfn, "\"",
        " title=\"Open TeX Source\"",
        ">",
        "</a>",
        "</kbd>\n"
    )
    cat(resline, file = file.path(topdir.full, "README.md"), append = TRUE, fill = TRUE)

    k <- k + 1

}

RUN <- paste("git commit", file.path(topdir.full, "README.md"), "-m \" README.md \"" )
system(RUN)

RUN <- paste("git push")
system(RUN)
