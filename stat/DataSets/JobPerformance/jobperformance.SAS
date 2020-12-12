/* Example Code to access the data "jobperformance.txt" from SAS */
/* Fan Jia 2011-08-12 */

proc import datafile='C:\Users\TEMP\Documents\jobperformance.txt' out=jobperf dbms=tab replace;
getnames=yes;
run;

proc print data=jobperf;
run;