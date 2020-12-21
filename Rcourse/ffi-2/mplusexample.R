mpprog <- '
TITLE:
  Alternative Fit Indices

DATA:
  FILE IS "rundata.dat";

VARIABLE:
  NAMES ARE y1-y6 cluster;
  USEVARIABLES ARE y1-y6;

MODEL:
  F1 BY y1-y3*.7;
  F2 BY y4-y6*.7;
  y1-y6*.51;
  F1@1.0;
  F2@1.0;
  F1 WITH F2*.3;

OUTPUT:
  STDYX;
'
cat(mpprog, file = "myMplus.inp")


run <- 7

mpprog1 <- '
TITLE:
  Alternative Fit Indices

DATA:
  FILE IS '

mpprog2 <- paste("\"data-", run, '.dat\";', sep = "")

mpprog3 <- '
VARIABLE:
  NAMES ARE y1-y6 cluster;
  USEVARIABLES ARE y1-y6;

MODEL:
  F1 BY y1-y3*.7;
  F2 BY y4-y6*.7;
  y1-y6*.51;
  F1@1.0;
  F2@1.0;
  F1 WITH F2*.3;

OUTPUT:
  STDYX;
'

outFileName <- paste0("myMplus-", run, ".inp", sep = "")
cat(mpprog1, file = outFileName)
cat(mpprog2, file = outFileName, append = TRUE)
cat(mpprog3, file = outFileName, append = TRUE)



myFile <- "MyMplusCode.inp"
cat("TITLE:",
"  Alternative Fit Indices;",
" ",
"DATA:",
"  FILE IS \"rundata.dat\";",
" ",
"VARIABLE:",
"  NAMES ARE y1-y6 cluster;",
"  USEVARIABLES ARE y1-y6;",
"  ",
"MODEL:",
"  F1 BY y1-y3*.7;",
"  F2 BY y4-y6*.7;",
"  y1-y6*.51;",
"  F1@1.0;",
"  F2@1.0;",
"  F1 WITH F2*.3;",
"  ",
"OUTPUT:",
"  STDYX;", sep = "\n", file = myFile)
