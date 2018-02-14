* Introduction to SAS;
* Copyright 2013 by Ani Katchova;

* Creating a library where SAS data files are located; 
libname lib1 '/folders/myfolders';  
run;

* Using a sas file;
data auto;
set lib1.intro_auto;
run;

* Importing a csv file;
proc import out=auto_csv
datafile = "/folders/myfolders/Econometrics/data/intro_auto.csv" 
dbms=csv replace; getnames=yes; datarow=2;
run;


* Importing an Excel file;
proc import out=auto_excel
datafile = "/folders/myfolders/Econometrics/data/intro_auto.xlsx" 
dbms=excel replace; getnames=yes;
sheet='Sheet1';
run;

* Print data in output window;
proc print data=auto (obs=10);
run; 

* Listing the variables;
proc contents data=auto;
run;

* Sorting the data;
proc sort data=auto;
by make price;
run;

* Descriptive statistics;
proc means data=auto;
*class foreign;
run; 

* Detailed descriptive statistics;
proc univariate data=auto;
var price mpg;
run; 

* Descriptive statistics saved in a file;
proc sort data=auto; by make; run;
proc univariate data=auto noprint;
var price mpg;
by make;
output out=stats mean=price_mean mpg_mean std=price_std n=obs;
run;

* Merging two files - "make" is the common variable;
proc sort data=auto; by make; run;
proc sort data=stats; by make; run;
data auto2;
merge auto stats;
by make;
run;

* Frequency distribution for different variables;
proc freq data=auto;
tables make foreign repairs;
run; 

* Bar chart;
proc gchart data=auto;
vbar make/ discrete;
run; 

* SAS Version;
proc product_status;
run;

* Correlations;
proc corr data=auto;
var price mpg weight length;
run; 

* Correlations by group - need to sort first and then use "by" statement;
proc sort data=auto; by foreign; run;
proc corr data=auto;
var price mpg weight length;
by foreign;
run; 

* Data manipulations;
data auto1;
set auto;
if price>6000 then highprice=1; else highprice=0;
if repairs=0 or repairs=1 then repairs_level=0; else if repairs=2 or repairs=3 then repairs_level=1; else repairs_level=2;
price_nominal=price*3.35;
if price=. then delete;
price_per_weight=price/weight;
where foreign=0;
run;

* Regression model - mpg is dependent variable and weight, length and foreign are independent variables;
proc reg data=auto;
model mpg = weight length foreign;
run;

* ANOVA test - if the mean mpg is the same for foreign and domestic cars;
proc glm data=auto;
class foreign;
model mpg = foreign;
run; 

* Exporting a SAS file as a sas file;
data lib1.auto1;
set auto1;
run;

* Exporting a SAS file as a csv file;
proc export data= auto1
outfile = "/folders/myfolders/Econometrics/data/auto1.csv" 
dbms=csv replace; putnames=yes;
run;

* Exporting a SAS file as an Excel file;
proc export data=auto1
outfile= "/folders/myfolders/Econometrics/data/auto1.xls" 
dbms=excel replace;
run;
