********************************************************************************
*PURPOSE:  Demonstrate how to run configural invariance model in Stata.
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

log using "cfa-01-1-configural-output.txt", text replace

use "..\..\data\job_placement.dta", clear

sem (L1 -> wratcalc wjcalc  waiscalc) (L2 ->  wratspl wjspl waisspl), ///
group(female) ginvariant(none) latent(L1 L2) ///
cov( L1@1 L1*L2 L2@1) mean(L1@0 L2@0) nocapslatent method(mlmv)


***CLOSE LOG FILE***
capture log close
