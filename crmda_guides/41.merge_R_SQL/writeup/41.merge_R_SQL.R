## ----setup, include=FALSE------------------------------------------------
##This Invisible Chunk is required in all CRMDA documents
outdir <- paste0("tmpout")
if (!file.exists(outdir)) dir.create(outdir, recursive = TRUE)
knitr::opts_chunk$set(echo=TRUE, comment=NA, fig.path=paste0(outdir, "/p-"))
options(width = 75)

## ----themecopy, include=FALSE--------------------------------------------
library(kutils)
library(crmda)
## If theme directory does not have required images or TeX files
## we need to retrieve them and put them in "theme" directory. 
logos <- c(logoleft = "jayhawk.png", 
           logoright = "CRMDAlogo-vert.png")
files <- c("kutils.css", 
           "guide-boilerplate.html")
getFiles(logos, pkg = "crmda")
getFiles(files, pkg = "crmda")

## ---- echo=T, include=FALSE----------------------------------------------
pdf.options(onefile=FALSE, family="Times", paper="special", height=4,
            width=6, pointsize=10)

## ---- include = FALSE----------------------------------------------------
## Build Some Data
authors <- data.frame(
  surname = I(c("Tukey", "Venables", "Tierney", "Ripley", "McNeil")),
  nationality = c("US", "Australia", "US", "UK", "Australia"),
  deceased = c("yes", rep("no", 4)))

## Build Another Data Set
books <- data.frame(
  name = I(c("Tukey", "Venables", "Tierney",
             "Ripley", "Ripley", "McNeil", "R Core")),
  title = c("Exploratory Data Analysis",
            "Modern Applied Statistics",
            "LISP-STAT",
            "Spatial Statistics", "Stochastic Simulation",
            "Interactive Data Analysis",
            "An Introduction to R"),
  other_author = c(NA, "Ripley", NA, NA, NA, NA,
                   "Venables & Smith"))

## ---- eval=FALSE---------------------------------------------------------
##  SELECT "column_name(s)"
##  FROM "table1 "
##  JOIN "table2 "
##  ON "table1.key1=table2.key2;"

## ------------------------------------------------------------------------
## Data set x
authors
## Data set y
books

## ------------------------------------------------------------------------
merg.df.1 <- merge(x = authors, y = books, by.x = "surname", by.y = "name",
                   all = FALSE)
merg.df.1

## ---- eval=FALSE---------------------------------------------------------
##  SELECT authors.surname, authors.nationality, authors.deceased,
##         books.name, books.title, books.other_author
##  FROM authors
##  INNER JOIN books
##  ON authors.surname = books.name;

## ------------------------------------------------------------------------
merg.df.2 <- merge(x = books, y = authors, by.x = "name", by.y = "surname")
merg.df.2

## ------------------------------------------------------------------------
merg.df.3 <- merge(x = authors, y = books, by.x = "surname", by.y = "name",
                   all = TRUE)
merg.df.3

## ---- eval=FALSE---------------------------------------------------------
##  SELECT authors.surname, authors.nationality, authors.deceased,
##         books.name, books.title, books.other_author
##  FROM books
##  FULL JOIN authors
##  ON books.name = authors.surname ;

## ------------------------------------------------------------------------
merg.df.4 <- merge(x = authors, y = books, by.x = "surname", by.y = "name",
            all.x = TRUE)
merg.df.4

## ---- eval=FALSE---------------------------------------------------------
##  SELECT authors.surname, authors.nationality, authors.deceased,
##         books.name, books.title, books.other_author
##  FROM authors
##  LEFT JOIN books
##  ON authors.surname = books.name;

## ------------------------------------------------------------------------
merg.df.5 <- merge(x = authors, y = books, by.x = "surname", by.y = "name",
                   all.y = TRUE)
merg.df.5

## ---- eval=FALSE---------------------------------------------------------
##  SELECT authors.surname, authors.nationality, authors.deceased,
##         books.name, books.title, books.other_author
##  FROM authors
##  RIGHT JOIN books
##  ON authors.surname = books.name;

## ---- include=FALSE------------------------------------------------------
x <- data.frame(k1 = c(NA, NA, 3, 4, 5, 6), k2 = c(1, NA, NA, 4, 5, 6), ID = 1:6)
y <- data.frame(k1 = c(NA, 2, NA, 4, 5, 6), k2 = c(NA, NA, 3, 4, 5, 6), ID = 1:6)

## ------------------------------------------------------------------------
x
y

## ------------------------------------------------------------------------
merg.df.6 <- merge(x = x, y = y, by = c("k1", "k2"))
## Loose your job
merg.df.6

## ------------------------------------------------------------------------
merg.df.7 <- merge(x = x, y = y, by = c("k2"), incomparables = NA)

## ------------------------------------------------------------------------
merg.df.7

## ---- include = FALSE----------------------------------------------------
n <- 30
d <- data.frame(ID = 1:n, Company =
       sample(c("Company_A", 	  "Company_B", "Company_C", "Company_D"),
       						             size = n,replace = TRUE),
	   profit = rnorm(n, 100, 15))

d2 <- data.frame(ID = 1:n, Company = d$Company,
       Region = sample(c("Midwest","Southeast","Deep_South","West_Coast","East_Coast"),
           size = n, replace = TRUE),
	   Cost = rnorm(n, 1000, 150))

## ------------------------------------------------------------------------
d_merged <- merge(x = d, y = d2, by = c("ID", "Company"),
                  sort = TRUE, all.x = TRUE)
d_merged

## ------------------------------------------------------------------------
d_merged <- merge(x = d, y = d2, by = c("ID", "Company"),
                  sort = FALSE, all.x = TRUE)
d_merged

## ------------------------------------------------------------------------
d$ID <- rockchalk::padW0(d$ID)
d2$ID <- rockchalk::padW0(d$ID)

d_merged_pad <- merge(x = d, y = d2, by = c("ID", "Company"),
                      sort = TRUE, all.x = TRUE)
d_merged_pad

## ---- include=FALSE------------------------------------------------------
n  <- 16
ID <- c(rep(1, 4), rep(2, 4),rep(3, 4),rep(4, 4))
d_long <- as.data.frame(ID)
d_long["Region"]  <-
    sample(c("Midwest", "Southeast", "Deep_South", "West_Coast", "East_Coast"),
           size = n, replace = TRUE)
ID <- seq(1,4)
d_wide <- as.data.frame(ID)
d_wide["Industry"] <- sample(c("Hot_Dogs", "Toilet_Paper", "Candy", "YoYo's"),
                             size = 4)

## ------------------------------------------------------------------------
d_long
d_wide

## ------------------------------------------------------------------------
d_merged <- merge(d_long, d_wide, by.x = "ID", by.y = "ID", all.y = TRUE)
d_merged

## ---- include=FALSE------------------------------------------------------
library(kutils)
df1 <- data.frame(id = 1:7, x = rnorm(7))
df2 <- data.frame(id = c(2:6, 9:10), x = rnorm(7))

## ------------------------------------------------------------------------
df1
df2

## ------------------------------------------------------------------------
mergeCheck(x = df1, y = df2, by = "id")

## ---- include=FALSE------------------------------------------------------
df1 <- data.frame(id = c(1:3, NA, NaN, "", " "), x = rnorm(7))
df2 <- data.frame(id = c(2:6, 5:6), x = rnorm(7))

## ------------------------------------------------------------------------
df1
df2

## ------------------------------------------------------------------------
mergeCheck(x = df1, y = df2, by = "id")

## ------------------------------------------------------------------------
df1 <- data.frame(id = c(1:10), x = rnorm(10))
df2 <- data.frame(id = c(1:10), x = rnorm(10))

mergeCheck(x = df1, y = df2, by = "id")

## ----include =FALSE------------------------------------------------------
library("plyr")

## ------------------------------------------------------------------------
colnames(authors) <- gsub("surname", "name", colnames(authors))

## ------------------------------------------------------------------------
join(x = books, y = authors, by = "name", type = "left")

## ------------------------------------------------------------------------
join(x = books , y= authors , by="name",type = "right")

## ------------------------------------------------------------------------
join(x = books , y = authors , by="name",type = "full")

## ---- error = TRUE-------------------------------------------------------
join(x = books, y= authors, by="name",type = "inner")

## ------------------------------------------------------------------------
join(x = d_long , y = d_wide , by = "ID", type = "full")

## ------------------------------------------------------------------------
merge(x = d_long, y = d_wide, by = "ID", all.x = TRUE, all.y = TRUE)

## ------------------------------------------------------------------------
join(x = x , y = y , by = "ID", type = "inner")

## ---- include=FALSE------------------------------------------------------
n <- 30
ID <- seq(1, n)
d <- as.data.frame(ID)
d["Company"] <- sample(c("Company_A", "Company_B",
                         "Company_C", "Company_D"),
                       size = n, replace = TRUE)
d["Profit"] <- rnorm(n, 100, 15)
ID <- seq(1, n)
d2 <- as.data.frame(ID)
d2["Company"] <- d$Company
d2["Region"]  <-
    sample(c("Midwest", "Southeast", "Deep_South", "West_Coast",
             "East_Coast"), size = n, replace = TRUE)
d2["Cost"] <- rnorm(n, 1000, 150)

## ------------------------------------------------------------------------
join(x = d, y = d2, by = "ID", type = "inner")

## ---- include=TRUE-------------------------------------------------------
library(data.table)

## ---- include=FALSE------------------------------------------------------
authors <- data.frame(
    surname = I(c("Tukey", "Venables", "Tierney", "Ripley", "McNeil")),
    nationality = c("US", "Australia", "US", "UK", "Australia"),
    deceased = c("yes", rep("no", 4)))

books <- data.frame(
    name = I(c("Tukey", "Venables", "Tierney",
               "Ripley", "Ripley", "McNeil", "R Core")),
    title = c("Exploratory Data Analysis",
              "Modern Applied Statistics",
              "LISP-STAT",
              "Spatial Statistics", "Stochastic Simulation",
              "Interactive Data Analysis",
              "An Introduction to R"),
    other_author = c(NA, "Ripley", NA, NA, NA, NA,
                     "Venables & Smith"))

## ---- include=TRUE-------------------------------------------------------
authors
books
authors <- as.data.table(authors)
books <- as.data.table(books)
setkey(authors, surname)
setkey(books, name)

## ------------------------------------------------------------------------
books[authors]

## ------------------------------------------------------------------------
authors[books]

## ------------------------------------------------------------------------
authors[books, nomatch=0]

## ------------------------------------------------------------------------
x <- data.frame("Name" = c("Johnson", NA, "Brady", "Ryan", NA, "Goff"),
                "Titles" = c(1, 0, 5, 0, 1, 0))
				
y <- data.frame("LastName" = c(NA, "Marino", "Brady", "Ryan", "Wilson",
                               "Bryant", NA),
                "MVPs" = c(0, NA, 3, 0, 0, 0, 0))
x
y

## ---- echo=TRUE----------------------------------------------------------
x <- as.data.table(x)
y <- as.data.table(y)
setkey(x, Name)
setkey(y, LastName)

## Left join
y[x]

## Right join
x[y]

## Inner join
y[x, nomatch = 0]

## ------------------------------------------------------------------------
x <- data.frame("First" = c("Peyton", "Eli", "Tom", "Matt"),
                "Last" = c("Manning", "Manning", "Brady", "Ryan"),
                "Titles" = c(2, 2, 5, 0))

y <- data.frame("FirstName" = c("Peyton", "Tom", "Matt", "Russell",
                                "Dez", "Von"),
                "LastName" = c("Manning", "Brady", "Ryan", "Wilson",
                               "Bryant", "Miller"),
                "MVPs" = c(3, 3, 1, 0, 0, 0))
x
y

## ---- echo=TRUE----------------------------------------------------------
x <- data.table(x)
y <- data.table(y)
setkey(x, Last)
setkey(y, LastName)

## Left join
y[x]

## Right join
x[y]

## Inner join
y[x, nomatch = 0]

## ---- echo=TRUE----------------------------------------------------------
nrow(x) == length(unique(x[ , Last]))

## ------------------------------------------------------------------------
nrow(x) == nrow(unique(x[ , Last, First]))

## ------------------------------------------------------------------------
setkey(x, Last, First)
setkey(y, LastName, FirstName)
## Left join
y[x]
## Right join
x[y]

