* Linear Regression
* Copyright 2013 by Ani Katchova

clear all
set more off

use C:\Econometrics\Data\regression_auto

global ylist mpg
global x1list weight1
global xlist weight1 price foreign

describe $ylist $xlist 
summarize $ylist $xlist
summarize $ylist, detail

* Correlation
correlate $ylist $xlist

* Plotting the data
graph twoway (scatter $ylist $x1list)

* Simple regression 
reg $ylist $x1list

* Plotting a regression line
graph twoway (scatter $ylist $x1list)(lfit $ylist $x1list) 

* Predicted values for the dependent variable
predict y1hat, xb
summarize $ylist y1hat
graph twoway (scatter $ylist $x1list)(scatter y1hat $x1list)

* Regression residuals
predict e1hat, resid
summarize e1hat
graph twoway (scatter e1hat $x1list)

* Hypothesis testing (coefficient significantly different from zero)
test $x1list

* Marginal effects (at the mean and average marginal effect)
quietly reg $ylist $x1list
margins, dydx(*) atmeans
margins, dydx(*)


* Multiple regression
reg $ylist $xlist

* Predicted values for the dependent variable
predict yhat, xb
summarize $ylist yhat

* Regression residuals
predict ehat, resid
summarize ehat

* Hypothesis testing (coefficients jointly significantly different from zero)
test $xlist

* Marginal effects (at the mean and average marginal effect)
margins, dydx(*) atmeans
margins, dydx(*)
