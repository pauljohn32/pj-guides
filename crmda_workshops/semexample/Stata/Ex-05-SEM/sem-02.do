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

log using "sem-02-output.txt", text replace

use "..\..\data\insomnia.dta", clear

sem (Impact -> insom5 insom6 insom7)(Severity -> insom1 insom2 insom3) ///
(Satisf -> insom4 insom1 insom7)(QoL -> phy psy soc env) ///
(QoL <- Impact Severity Satisf), method(mlmv)
* This matches Mplus if there method(mlmv) command is at the end.  This handles the missing values.

***CLOSE LOG FILE***
capture log close
