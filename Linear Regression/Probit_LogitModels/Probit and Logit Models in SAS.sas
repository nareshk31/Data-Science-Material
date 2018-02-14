* Probit and Logit Models in SAS;
* Copyright 2013 by Ani Katchova;

proc import out= work.data
datafile= "C:\Econometrics\Data\probit_insurance.csv" 
dbms=csv replace; getnames=yes; datarow=2; 
run;

proc means data=data;
var ins retire age hstatusg hhincome educyear married hisp;
run;

proc freq data=data;
tables ins;
run;

*OLS;
proc reg data=data; 
model ins = retire age hstatusg hhincome educyear married hisp; 
run;

*Logit;
proc logistic data=data descending; 
model ins = retire age hstatusg hhincome educyear married hisp/ ctable pprob=0.5; 
output out=lpred predicted=plogit;
run;

*Logit;
proc qlim data=data;
model ins = retire age hstatusg hhincome educyear married hisp / discrete (dist=logit);
output out=mfx marginal;
run;

*Logit marginal effects;
proc means data=mfx mean std;
var Meff_P2_retire Meff_P2_age Meff_P2_hstatusg Meff_P2_hhincome Meff_P2_educyear 
Meff_P2_married Meff_P2_hisp;
run;

*Logit predicted probabilities;
proc means data=lpred;
var ins plogit;
run;

*Probit;
proc logistic data=data descending; 
model ins = retire age hstatusg hhincome educyear married hisp / link=probit ctable pprob=0.5; 
output out=ppred predicted=pprobit;
run;

*Probit;
proc qlim data=data;
model ins = retire age hstatusg hhincome educyear married hisp / discrete (dist=normal);
output out=mfx marginal;
run;

*Probit marginal effects;
proc means data=mfx mean std;
var Meff_P2_retire Meff_P2_age Meff_P2_hstatusg Meff_P2_hhincome Meff_P2_educyear 
Meff_P2_married Meff_P2_hisp;
run;

*Probit predicted probabilities;
proc means data=ppred;
var ins pprobit;
run;

*Probit predicting y=0;
proc probit data=data;
class ins;
model ins = retire age hstatusg hhincome educyear married hisp;
run;
