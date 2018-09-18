# Practical Machine Learning - Week 2 - Quiz 2
## Coursera - Data Science - Johns Hopkins


Question 1
----------
Which of the following commands will create non-overlapping training and test sets with about 50% of the observations assigned to each?

```{r}
adData = data.frame(predictors)
trainIndex = createDataPartition(diagnosis,p=0.5,list=FALSE)
training = adData[trainIndex,]
testing = adData[-trainIndex,]


adData = data.frame(diagnosis,predictors)
trainIndex = createDataPartition(diagnosis,p=0.50)
training = adData[trainIndex,]
testing = adData[-trainIndex,]


adData = data.frame(diagnosis,predictors)
trainIndex = createDataPartition(diagnosis, p = 0.50,list=FALSE)
training = adData[trainIndex,]
testing = adData[-trainIndex,]


adData = data.frame(diagnosis,predictors)
train = createDataPartition(diagnosis, p = 0.50,list=FALSE)
test = createDataPartition(diagnosis, p = 0.50,list=FALSE)
```

Answer: </br>
The source dataset needs to contain both diagnosis and predictors, and the result of CreateDataPartition cannot be a list, otherwise the use in adData produces an error.

```{r}
adData = data.frame(diagnosis,predictors)
trainIndex = createDataPartition(diagnosis, p = 0.50,list=FALSE)
training = adData[trainIndex,]
testing = adData[-trainIndex,]
```

  
Question 2
----------
Load the cement data using the commands:

```{r}
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]
```

Make a plot of the outcome (CompressiveStrength) versus the index of the samples. Color by each of the variables in the data set (you may find the cut2() function in the Hmisc package useful for turning continuous covariates into factors). What do you notice in these plots?


```{r}
suppressMessages(library(Hmisc))
suppressMessages(library(dplyr))
suppressMessages(library(Hmisc))
suppressMessages(library(gridExtra))
training <- mutate(training, index=1:nrow(training))
cutIndex <- cut2(training$index, g=5)
breaks <- 5

qplot(index, CompressiveStrength, data=training, color=cut2(training$Cement, g=breaks), main = "Cement")
qplot(index, CompressiveStrength, data=training, color=cut2(training$BlastFurnaceSlag, g=breaks), main = "BlastFurnaceSlag")
qplot(index, CompressiveStrength, data=training, color=cut2(training$FlyAsh, g=breaks), main = "FlyAsh")
qplot(index, CompressiveStrength, data=training, color=cut2(training$Water, g=breaks), main = "Water")
qplot(index, CompressiveStrength, data=training, color=cut2(training$Superplasticizer, g=breaks), main = "Superplasticizer")
qplot(index, CompressiveStrength, data=training, color=cut2(training$CoarseAggregate, g=breaks), main = "CoarseAggregate")
qplot(index, CompressiveStrength, data=training, color=cut2(training$FineAggregate, g=breaks), main = "FineAggregate")
qplot(index, CompressiveStrength, data=training, color=cut2(training$Age, g=breaks), main = "Age")

```

![](https://github.com/aakhacha/Coursera_Data_Science_Johns_Hopkins/blob/master/Course_8_Practical_Machine_Learning/Week_2/plot1.png)
![](https://github.com/aakhacha/Coursera_Data_Science_Johns_Hopkins/blob/master/Course_8_Practical_Machine_Learning/Week_2/plot2.png)
![](https://github.com/aakhacha/Coursera_Data_Science_Johns_Hopkins/blob/master/Course_8_Practical_Machine_Learning/Week_2/plot3.png)
![](https://github.com/aakhacha/Coursera_Data_Science_Johns_Hopkins/blob/master/Course_8_Practical_Machine_Learning/Week_2/plot4.png)
![](https://github.com/aakhacha/Coursera_Data_Science_Johns_Hopkins/blob/master/Course_8_Practical_Machine_Learning/Week_2/plot5.png)
![](https://github.com/aakhacha/Coursera_Data_Science_Johns_Hopkins/blob/master/Course_8_Practical_Machine_Learning/Week_2/plot6.png)
![](https://github.com/aakhacha/Coursera_Data_Science_Johns_Hopkins/blob/master/Course_8_Practical_Machine_Learning/Week_2/plot7.png)
![](https://github.com/aakhacha/Coursera_Data_Science_Johns_Hopkins/blob/master/Course_8_Practical_Machine_Learning/Week_2/plot8.png)

  
Question 3
----------
Load the cement data using the commands:

```{r}
suppressWarnings(library(AppliedPredictiveModeling))
data(concrete)
suppressWarnings(library(caret))
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]
```
Make a histogram and confirm the SuperPlasticizer variable is skewed. Normally you might use the log transform to try to make the data more symmetric. Why would that be a poor choice for this variable?

* There are values of zero so when you take the log() transform those values will be -Inf.
* The SuperPlasticizer data include negative values so the log transform can not be performed.
* The log transform does not reduce the skewness of the non-zero values of SuperPlasticizer
* The log transform produces negative values which can not be used by some classifiers.

![](https://github.com/aakhacha/Coursera_Data_Science_Johns_Hopkins/blob/master/Course_8_Practical_Machine_Learning/Week_2/plot9.png)
![](https://github.com/aakhacha/Coursera_Data_Science_Johns_Hopkins/blob/master/Course_8_Practical_Machine_Learning/Week_2/plot10.png)

Answer: </br>
We can notice that some values of Superplasticizer are 0, which is confirmed by calling the summary on training dataset. So There are values of zero so when you take the log() transform those values will be -Inf.

Question 4
----------
Load the Alzheimer’s disease data using the commands:

```{r}
suppressWarnings(library(caret))
suppressWarnings(library(AppliedPredictiveModeling))
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
```

Find all the predictor variables in the training set that begin with IL. Perform principal components on these variables with the preProcess() function from the caret package. Calculate the number of principal components needed to capture 90% of the variance. How many are there?

* 10
* 8
* 7
* 9

Answer: </br>

```{r}
IdxCol_IL <- grep("^IL", names(training))
train_IL <- training[,IdxCol_IL]
test_IL <- testing[,IdxCol_IL]
preproc <- preProcess(train_IL, method="pca", thresh=0.9)
preproc$numComp

## [1] 9
```

Question 5
----------
Load the Alzheimer’s disease data using the commands:

```{r}
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
```

Create a training data set consisting of only the predictors with variable names beginning with IL and the diagnosis. Build two predictive models, one using the predictors as they are and one using PCA with principal components explaining 80% of the variance in the predictors. Use method=“glm” in the train function.

What is the accuracy of each method in the test set? Which is more accurate?

* Non-PCA Accuracy: 0.91 | PCA Accuracy: 0.93
* Non-PCA Accuracy: 0.72 | PCA Accuracy: 0.65
* Non-PCA Accuracy: 0.72 | PCA Accuracy: 0.71
* Non-PCA Accuracy: 0.65 | PCA Accuracy: 0.72

Answer: </br>
```{r}
set.seed(3430)
suppressMessages(library(dplyr))
IdxCol_IL <- grep("^IL", names(testing))
names_IL <- names(testing[,IdxCol_IL])
newcols <- c(names_IL,"diagnosis")
new_testing <- testing [,newcols]
new_training <- training[,newcols]





# Model 1 : predictors as they are, without PCA
model_without_PCA <- train(diagnosis~., data=new_training,   preProcess=c("center","scale"),method="glm")
model_result_without_PCA <- confusionMatrix(new_testing$diagnosis,predict(model_without_PCA,subset(new_testing, select = -c(diagnosis))))
model_result_without_PCA

##                Accuracy : 0.6463 



# Model 2 : predictors using PCA, with explanation of 80% of variance
preProc_pca <-  preProcess(subset(new_training, select = -c(diagnosis)), method="pca", thresh=0.8)

trainPC <- predict(preProc_pca,subset(new_training, select = -c(diagnosis)))
testPC <- predict(preProc_pca,subset(new_testing, select = -c(diagnosis)))
# Syntax to use to avoid "undefined columns selected" error message (by following the formula  defined in the slides.)
model_with_PCA<- train(x = trainPC, y = new_training$diagnosis,method="glm") 
model_result_with_PCA <- confusionMatrix(new_testing$diagnosis,predict(model_with_PCA, newdata=testPC))
model_result_with_PCA

##                Accuracy : 0.7195
```

We can notice that the model using PCA is more accurate (71.95%) than the one using the original predictors (64.63%).