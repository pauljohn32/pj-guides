* Paul E. Johnson
* 20181129

capture log close
set more off, permanently
log using dwtest-20181129.log, replace text


use dwtest-20181129.dta

egen time = seq()
tsset time

reg y1 x
estat dwatson
*See stata help file rregresspostestimationtimeseries

reg y2 x
estat dwatson


*tsset time

prais y1 x



prais y2 x

