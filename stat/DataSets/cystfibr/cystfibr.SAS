data cf; 
infile 'C:\Users\TEMP\Documents\cystfibr.txt' firstobs=2; 
input age sex height weight bmp fev1  rv frc tlc pemax; 
run;

proc print data=cf;
run;