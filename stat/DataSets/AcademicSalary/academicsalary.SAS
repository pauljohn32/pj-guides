/* Example Code to access the data "academicsalary.txt" from SAS */
/* Fan Jia 2011-08-12 */

proc import datafile='C:\Users\TEMP\Documents\academicsalary.txt' out=academic dbms=tab replace;
getnames=yes;
run;

proc print data=academic;
run;