********************************************************************************
*PURPOSE:  Demonstrate how to run an EFA in Stata.
*
*
*AUTHOR: Ben Kite
*
*
*DATE LAST MODIFIED: 2015-12-08
********************************************************************************

***INITIAL SETUP***
* clear everything
cscript
* close any open log file
capture log close
* set output window to be printable
set linesize 80
* disable annoying "feature" where the output window won't scroll
set more off
* enable automatic reporting of execution and system time
set rmsg on

log using "lgc-01-output.txt", text replace

use "..\..\data\anxiety.dta", clear

sem (SLOPE -> anxiety1@0 anxiety2@1 anxiety3@2 anxiety4@3) ///
(INTERCEPT -> anxiety1@1 anxiety2@1 anxiety3@1 anxiety4@1) ///
(anxiety1 anxiety2 anxiety3 anxiety4 <- _cons@0), mean(SLOPE INTERCEPT) 
***CLOSE LOG FILE***
capture log close
