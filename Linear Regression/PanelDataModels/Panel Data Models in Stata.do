* Panel Data Models in Stata
* Copyright 2013 by Ani Katchova

clear all
set more off

use C:\Econometrics\Data\panel_wage

global id id
global t t
global ylist lwage
global xlist exp exp2 wks ed

describe $id $t $ylist $xlist
summarize $id $t $ylist $xlist

* Set data as panel data
sort $id $t
xtset $id $t
xtdescribe
xtsum $id $t $ylist $xlist

* Pooled OLS estimator
reg $ylist $xlist

* Population-averaged estimator
xtreg $ylist $xlist, pa

* Between estimator
xtreg $ylist $xlist, be

* Fixed effects or within estimator
xtreg $ylist $xlist, fe

* First-differences estimator
reg D.($ylist $xlist), noconstant

* Random effects estimator
xtreg $ylist $xlist, re theta

* Hausman test for fixed versus random effects model
quietly xtreg $ylist $xlist, fe
estimates store fixed
quietly xtreg $ylist $xlist, re
estimates store random
hausman fixed random

* Breusch-Pagan LM test for random effects versus OLS
quietly xtreg $ylist $xlist, re
xttest0

* Recovering individual-specific effects
quietly xtreg $ylist $xlist, fe
predict alphafehat, u
sum alphafehat

