Paul Johnson
Chantelle Dowsett

This is a realistic example with data pulled from one of our projects.

There is information in the file "parents.xlsx". 
Those rows look like this.

   pb_pid pb_clid pb_fid pb_chid pb21_ed
1  101202       1      1       1       3
2  101202       1      2       2       1
3  101203       1      1       1       5
4  101203       1      3       3       4
5  101203       1      2       2       4

pb_pid is the "by" variable in there. For each of those
values, we want to grab information from the other file.

pb_clid is the classroom ID, 
pb_fid is the family ID (there are some siblings) 
pb_chid is the child ID,



The top rows of the schools.xlsx file look like this


   ctb_pid ctb10_pay ctb10_payp ctb12_ed
1   101202   1675.00          2        4
2   101203   3000.00          2        6
3   301204        NA          4        6
4   301205     14.00          0        4


In schools, the "by" id variable we are interested in is "ctb_pid".
We want to unite the information from those rows with the
parents data, so we end up with something like

  pb_pid pb_clid pb_fid pb_chid pb21_ed ctb10_pay ctb10_payp ctb12_ed
1  101102       1      2       1       1     60.00          1        4
2  101102       1      3       1       6     60.00          1        4
3  101102       1      1       2       4     60.00          1        4
4  101102       1      1       1       4     60.00          1        4
5  101105       1      2       2       3    100.00          1        1
6  101105       1      3       3       3    100.00          1        1
7  101105       1      4       4       4    100.00          1        1


Your mission: 

Import the files

1. school.xls
2. parents.xls

Merge school ID ctb_pid in school file with pb_pid from parent file


Don't worry what these variables are yet. We are working up a more
complete description of this.

