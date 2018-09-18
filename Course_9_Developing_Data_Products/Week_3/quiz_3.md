# Developing Data Products - Week 3 - Quiz 3
## Coursera - Data Science - Johns Hopkins


Question 1
----------
Which of the following items is required for an R package to pass R CMD check without any warnings or errors?

* **An explicit software license**


Question 2
----------
Which of the following is a generic function in a fresh installation of R, with only the default packages loaded? (Select all that apply)

* **show**
* **mean**
* **predict**


Question 3
----------
What function is used to obtain the function body for an S4 method function?

* **getMethod()**


Question 4
----------
Please download the R package DDPQuiz3 from the course web site. Examine the ???????????????????? function implemented in the R/ sub-directory. What is the appropriate text to place above the ???????????????????? function for Roxygen2 to create a complete help file?

* **An R package interface to the javascript library of the same name**
* **A javascript library for creating interactive maps**

```{r}
#' This function calculates the mean
#' 
#' @param x is a numeric vector
#' @return the mean of x
#' @export
#' @examples 
#' x <- 1:10
#' createmean(x)
```