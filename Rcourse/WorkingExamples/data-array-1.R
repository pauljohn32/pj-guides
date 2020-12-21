## Paul Johnson <pauljohn@ku.edu>
## 2013-07-10

## For a CRMDA consulting problem, here's an interesting working
## example where arrays are actually relevant and useful.  This is an
## interesting case study in R recoding, whether or not the resulting
## array is good for the researchers.  This was a good way to distract
## myself from the book I'm supposed to write today.

## Client's data was originally stored in an array format on some
## federal government server, but the provider flattened it out into a
## spreadsheet format.  So none of the information we expect to fit together
## is easy to fit.  Can we recover the original array, and is it
## useful to do so?  I think yes, proof of concept and test case
## below.

## The original array is 5 dimensional. It classifies count
## information by Sex, 2 Race classifications, a variable name, and a
## district name.  The column names in the data that arrives are
## like this: 
## "F_WHI_5_My-Variable-Name", "F_WHI_7_My-Variable_Name",
## and so forth.

## In what follows, I treat "WHI" and "5" or "7" as different elements.
## In a given unit, they report data in either format 5 or 7, so one should
## be NA if other is present. In my first pass through this exercise,
## I did not know about that element, and did not plan for it, so
## it made for an easier solution, but at the end of this note there
## is a solution to the complication it caused. 

## Here is an automated way to take the spread sheet data about schools
## and pack it into an R array. 


## If this toy example. My variable names are "Var_1",
## "Var_1" for simplicity.

dat <- data.frame(F_WHI_5_Var_1 = c(0, 0, 11, 19, 21),
                  F_WHI_7_Var_1 = c(22, 1, 0, 0, 0),
                  M_WHI_5_Var_1 = c(0, 0, 31, 11, 41),
                  M_WHI_7_Var_1 = c(0, 51, 0, 0, 0),
                  F_BLA_5_Var_1 = c(0, 0, 11, 17, 1),
                  F_BLA_7_Var_1 = c(0, 11, 0, 0, 0),
                  M_BLA_5_Var_1 = c(0, 0, 21, 31, 41),
                  M_BLA_7_Var_1 = c(0, 71, 0, 0, 0),
                  F_WHI_5_Var_2 = c(0, 0, 31, 99, 81),
                  F_WHI_7_Var_2 = c(2, 11, 0, 0, 0),
                  M_WHI_5_Var_2 = c(0, 0, 14, 12, 31),
                  M_WHI_7_Var_2 = c(0, 1, 0, 0, 0),
                  F_BLA_5_Var_2 = c(0, 0, 13, 14, 1),
                  F_BLA_7_Var_2 = c(0, 11, 0, 0, 0),
                  M_BLA_5_Var_2 = c(0, 0, 21, 31, 41),
                  M_BLA_7_Var_2 = c(0, 71, 0, 0, 0)
                  )
## Note, I did not put in NAs here. I made myself an easier problem to
## solve. That was not on purpose, though. And there's a fix at the end.

 dat.cnames <- colnames(dat)

## DO this 3 times because we want to split this sequence at
## the first 3 underscores, but leave other underscores because they are
## inside the variable name.
dat.cnames <- sub("_","MYMARKER", dat.cnames)
dat.cnames <- sub("_","MYMARKER", dat.cnames)
dat.cnames <- sub("_","MYMARKER", dat.cnames)
## Split at MYMARKER:

## dcs means "dat.cnames.split". It is a list that will go into a matrix. 
dcs <- strsplit(dat.cnames, "MYMARKER")

## That gives a new thing with key variables separated from variable names. Study!

## OMG. No better way to press this into a matrix? Don't see one.
dcs <- matrix(unlist(dcs), ncol = 4, byrow = TRUE)

## Name those columns
colnames(dcs) <- c("sex", "race", "type", "var")
## and add the full variable name as the row name

## Review
dcs


rownames(dcs) <- colnames(dat)


## Guessing particulars from inspection of data:
## 2 values for sex, 6 for race, 2 for 5 or 7, and 20 variables. I have
## only 5 districts in example above. And not all races filled in. So
## I have plenty of missings.
dar <- array(
    data = NA, dim = c(2, 6, 2, 20, 5),
    dimnames = list(sex = c("F","M"),
        race = c("WHI","BLA","HIS","API","ASE","NAT"), type = c("T5", "T7"),
        var = paste0("Var_",1:20), dist = paste0("d",1:5))
    )

## variable names cannot begin with a number, so we have to preface the type
## with T and district number by d.

## In a "real" exercise, do not define dar this way. This way
## required you to count the dim and dimnames, and you should not.
## I have way to automate this.

## First, prove sanity:
## Lets test and fill those manually
dar[1, 1, 2, 1, ] <- dat$F_WHI_7_Var_1
dar[1, 1, 1, 2, ] <- dat$F_WHI_5_Var_2
dar[1, 1, 2, 2, ] <- dat$F_WHI_7_Var_2

## watch out, don't type dar, it is a huge immense structure. But
## check the slices
dar[1,1,1,1,] ## access by index number
dar["F","WHI","T5",,] ##access by name

## Now, suppose we put elements into the array by names we stored above
## in dcs. First, fix the third column

dcs[ , 3] <- paste0("T", dcs[ ,3])

## Now, lets try to automate the filling up of dar.
## Will go through rows of dcs

rnames <- row.names(dcs)
## OMG, need abbreviation


for (i in seq_along(rnames)){
    dar[dcs[i,1], dcs[i, 2], dcs[i, 3], dcs[i, 4], ] <- dat[ , rnames[i]]
}
## Seems to work
dar[1,,,"Var_1",]
dar[1,"WHI",,"Var_1",]

## Now, here's the motivating problem. T5 and T7 are
## measures of same thing, we need to add them together. This
## will essentially collapse the array to 4 dimensions. 

## So, if you want to sum all variables across T5 and T7.
## Like magic:
dar.allT <- dar[, , "T5",  , ] + dar[ , , "T7", , ]

## Note, that eliminates dimension "type", which was what we want. It
## combined the T5 and T7 arrays entirely.
dim(dar.allT)

dar.allT[ , "WHI", "Var_1", ]
dar.allT[ , "BLA", "Var_1", ]

dar.allT[ , c("WHI","BLA"), c("Var_1","Var_2"), ]


## You'd have to tell me if the numbers are correct.
## I think so.


## Now, the important new information.
## Follow up SOLUTIONS (previously called this PROBLEMS)


## 1. How to automate dar creation?
## Above was dangerous because it required user to count number
## of values of the different dimensions, that's error prone.

## This way scans the actual "dat" data frame to get the needed
## array dimensions and names.

dar2 <- array (
    data = NA,
    dim = c(length(unique(dcs[,"sex"])),
        length(unique(dcs[ , "race"])),
        length(unique(dcs[ , "type"])),
        length(unique(dcs[ , "var"])),
        NROW(dat)),
    dimnames = list(sex = unique(dcs[ , "sex"]),
        race = unique(dcs[ , "race"]),
        type = unique(dcs[ ,"type"]),
        var = unique(dcs[ , "var"]),
        dist = paste0("d", seq(1, NROW(dat))))
    )

## This way is much less error prone, presuming we did the work
## on dat to create dcs correctly above
dar2


for (i in seq_along(rnames)){
    dar2[dcs[i,1], dcs[i, 2], dcs[i, 3], dcs[i, 4], ] <- dat[ , rnames[i]]
}
## test
dar2

dar2[1, , , "Var_1", ]
dar2[1, "WHI", , "Var_1",]

## Compare to dar
dar[1,,,"Var_1",]
dar[1,"WHI",,"Var_1",]

## dar2 only uses the actual data in "dat", which is a plus.
## otherwise same.



## FOLLOWUP SOLUTION 2

## 2. Missing values!

## If there are NAs, then the sum solution above causes lots of NA

dar2[ , , "T5", "Var_1", ] <- NA

dar.allT2 <- dar2[ , , "T5",  , ] + dar2[ , , "T7", , ]

## Note bad result, sum is all NA because of NAs on T5
dar.allT2[ , "WHI", "Var_1", ]
dar.allT2[ , "BLA", "Var_1", ]

## Ways to avoid that?

dar.allT2 <- apply(dar2, c(1, 2, 4, 5), sum, na.rm = TRUE)
dar.allT2[ , "WHI", "Var_1", ]
dar.allT2[ , "BLA", "Var_1", ]

## problem solved.

## For an explanation of why the apply() succeeds, well,
## think hard. Or read the companion help page data-array-2.R,
## which explains how I found out about that one.
