# Regression Models - Week 4 - Quiz 4
## Coursera - Data Science - Johns Hopkins


Question 1
----------
Consider the space shuttle data ??????????????? in the ???????? library. Consider modeling the use of the autolander as the outcome (variable name ??????). Fit a logistic regression model with autolander (variable auto) use (labeled as “auto” 1) versus not (0) as predicted by wind sign (variable wind). Give the estimated odds ratio for autolander use comparing head winds, labeled as “head” in the variable headwind (numerator) to tail winds (denominator).  

Answer: </br>
```R
library(MASS)
library(dplyr)
data(shuttle)
new_shuttle=mutate(shuttle,autobin= ifelse(use=='auto',1,0))
logfit = glm(new_shuttle$autobin~factor(new_shuttle$wind)-1,family="binomial")
coeff=summary(logfit)$coeff[,1]
ans=exp(coeff[1]-coeff[2])
ans

## factor(new_shuttle$wind)head 
##                    0.9686888
```


Question 2
----------
Consider the previous problem. Give the estimated odds ratio for autolander use comparing head winds (numerator) to tail winds (denominator) adjusting for wind strength from the variable magn.  

Answer: </br>
```R
mdl2 <- glm(use.bin ~ wind + magn - 1, family = "binomial", data = shuttle)
summary(mdl2)
exp(coef(mdl2))
exp(coef(mdl2))[[1]]/exp(coef(mdl2))[[2]]

## [1] 0.968
```
  

Question 3
----------
If you fit a logistic regression model to a binary variable, for example use of the autolander, then fit a logistic regression model for one minus the outcome (not using the autolander) what happens to the coefficients?
  
Answer: </br>
The coefficients reverse their signs (1-outcome ~. is equal to fitting -outcome~.+1 so it changes sign to the intercept, by means of the +1 addition, and to the slope, by means of the minus in front of the outcome)
  

Question 4
----------
Consider the insect spray data InsectSprays. Fit a Poisson model using spray as a factor level. Report the estimated relative rate comapring spray A (numerator) to spray B (denominator).
  
```R
data("InsectSprays")
fit = glm(InsectSprays$count ~factor(InsectSprays$spray)-1,family='poisson')
coeff3=summary(fit)$coeff[,1]
ans = exp(coeff3[1]-coeff3[2])
ans

## factor(InsectSprays$spray)A 
##                   0.9456522
```
  

Question 5
----------
Consider a Poisson glm with an offset, t. So, for example, a model of the form ??????(?????????? ~ ?? + ????????????(??), ???????????? = ??????????????) where ?? is a factor variable comparing a treatment (1) to a control (0) and ?? is the natural log of a monitoring time. What is impact of the coefficient for ?? if we fit the model ??????(?????????? ~ ?? + ????????????(????), ???????????? = ??????????????) where ?? <- ??????(????) + ??? In other words, what happens to the coefficients if we change the units of the offset variable. (Note, adding log(10) on the log scale is multiplying by 10 on the original scale.)
  

Answer: </br>
The intercept changes, but the coefficient estimate is unchanged.

```R
mdl5.1 <- glm(count ~ spray, offset = log(count+1), family = poisson, data = InsectSprays)
mdl5.2 <- glm(count ~ spray, offset = log(count+1)+log(10), family = poisson, data = InsectSprays)
summary(mdl5.1)
summary(mdl5.2)

rbind(coef(mdl5.1),coef(mdl5.2))

##      (Intercept)  sprayB sprayC sprayD sprayE  sprayF
## [1,]     -0.0667 0.00351 -0.325 -0.118 -0.185 0.00842
## [2,]     -2.3693 0.00351 -0.325 -0.118 -0.185 0.00842
```


Question 6
----------
Consider the following data set

```R
x <- -5:5
y <- c(5.12, 3.93, 2.67, 1.87, 0.52, 0.08, 0.93, 2.05, 2.54, 3.87, 4.97)

```

Using a knot point at 0, fit a linear model that looks like a hockey stick with two lines meeting at x=0. Include an intercept term, x and the knot point term. What is the estimated slope of the line after 0?

Answer: </br>
The slope of the line after 0 is 1.013.
  

```R
x <- -5:5
y <- c(5.12, 3.93, 2.67, 1.87, 0.52, 0.08, 0.93, 2.05, 2.54, 3.87, 4.97)

plot(x, y, pch = 21,  cex = 2, col="grey20", bg="cadetblue2")

knots <- 0
splineTerms <- sapply(knots, function(knot) (x > knot) * (x - knot))
xmat <- cbind(1, x, splineTerms)
mdl6 <- lm(y~xmat-1)
yhat<-predict(mdl6)
lines(x, yhat, col = "red", lwd = 2)
summary(mdl6)
sum(coef(mdl6)[2:3])
## [1] 1.01
```
