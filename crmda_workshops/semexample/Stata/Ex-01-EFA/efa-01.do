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

log using "efa-01-output.txt", text replace

use "..\..\data\job_placement.dta", clear

factor wjcalc wjspl wratspl wratcalc waiscalc waisspl, factors(2)
rotate, oblique quartimin

***CLOSE LOG FILE***
capture log close
