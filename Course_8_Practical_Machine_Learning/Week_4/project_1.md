---
title: "Practical Machine Learning | Week 4 | Project 1"
author: "Armen Khachatourian"
date: "7/18/2018"
output: html_document
---

## Coursera - Data Science - Johns Hopkins

### Step 1: Basic Setup

* Read CSVs.
* Get a count of the variable we’re trying to predict in our training set (classe).
* Choosing variables: I chose belt, dumbbell, arm, and forearm movements that we could measure.
  * Left out user name variables so that we can predict properly on new users, instead of just old ones.
  * Left out time stamps as its unrelated to the exercises and more related with each users work out timing preference.
  * Left out other variables that have a high NA count.
* Subset training set to a training and validation set (70/30), and only include the variables we chose.
* Double check NAs via graph on new training subset.

```{r}
# Read CSVs
training <- read.csv("C:/Users/Armen/Desktop/Newest Coursera/pml-training.csv")
testing  <- read.csv("C:/Users/Armen/Desktop/Newest Coursera/pml-testing.csv")

# Get Count
count(training$classe)

# Choose Vars
vars = c("gyros_belt_x", "gyros_belt_y", "gyros_belt_z", "accel_belt_x", "accel_belt_y", "accel_belt_z", "magnet_belt_x", "magnet_belt_y", "magnet_belt_z", "roll_belt", "pitch_belt", "yaw_belt", "total_accel_belt",
         "gyros_dumbbell_x", "gyros_dumbbell_y", "gyros_dumbbell_z", "accel_dumbbell_x", "accel_dumbbell_y", "accel_dumbbell_z", "magnet_dumbbell_x", "magnet_dumbbell_y", "magnet_dumbbell_z", "roll_dumbbell", "pitch_dumbbell", "yaw_dumbbell", "total_accel_dumbbell",
         "gyros_arm_x", "gyros_arm_y", "gyros_arm_z", "accel_arm_x", "accel_arm_y", "accel_arm_z", "magnet_arm_x", "magnet_arm_y", "magnet_arm_z", "roll_arm", "pitch_arm", "yaw_arm", "total_accel_arm",
         "gyros_forearm_x", "gyros_forearm_y", "gyros_forearm_z", "accel_forearm_x", "accel_forearm_y", "accel_forearm_z", "magnet_forearm_x", "magnet_forearm_y", "magnet_forearm_z", "roll_forearm", "pitch_forearm", "yaw_forearm", "total_accel_forearm")

# Subsetting for only chosen vars
newtrainingpresplit <- training[c(vars,"classe")]
newtesting <-   testing[vars]

# Subsetting training set to create a validation set
inTrain <- createDataPartition(newtrainingpresplit$classe, p = 0.7, list = F)

newtraining <- newtrainingpresplit[ inTrain,]
newvalidation <- newtrainingpresplit[-inTrain,]
rm(newtrainingpresplit, testing, training, vars, inTrain)

#check for NA/NULLs
aggr(newtraining)
```

![](https://github.com/aakhacha/Coursera_Data_Science_Johns_Hopkins/blob/master/Course_8_Practical_Machine_Learning/Week_4/plot2.png)

### Step 2: Model
* Choosing Model: Choosing K-nearest neighbors model because it’s perfect for predicting class outcome based on variables. It uses the variables to cluster each row as a “Type” and predicts the outcome based on what “Type” they are closest to (based on euclidian distance).
* Setting up train controls.
* Train the model.

```{r}
# Setting up train controls
repeats = 3
numbers = 10
tunel = 10
set.seed(100)

x = trainControl(method = "repeatedcv",
                 number = numbers,
                 repeats = repeats,
                 classProbs = TRUE)


# Training the knn model
model <- train(classe~. , data = newtraining, method = "knn",
                preProcess = c("center","scale"),
                trControl = x,
                metric = "Accuracy",
                tuneLength = tunel)
```

### Step 3: Summary of Output
```{r}
# Model Accuracy
plot(model, main = "Accuracy by k count")
```
![](https://github.com/aakhacha/Coursera_Data_Science_Johns_Hopkins/blob/master/Course_8_Practical_Machine_Learning/Week_4/plot3.png)

```{r}
train_pred <- predict(model, newtraining)
cfm_in <- confusionMatrix(newtraining$classe, train_pred)

# Predict on Validation set
valid_pred <- predict(model, newvalidation)
cfm <- confusionMatrix(newvalidation$classe, valid_pred)


ggplotConfusionMatrix <- function(m){
  mytitle <- paste("Accuracy", percent_format()(m$overall[1]),
                   "Kappa", percent_format()(m$overall[2]))
  p <-
    ggplot(data = as.data.frame(m$table) ,
           aes(x = Reference, y = Prediction)) +
    geom_tile(aes(fill = log(Freq)), colour = "white") +
    scale_fill_gradient(low = "white", high = "green") +
    geom_text(aes(x = Reference, y = Prediction, label = Freq)) +
    theme(legend.position = "none") +
    ggtitle(mytitle)
  return(p)
}

# Show Results of Validation set prediction based on training
ggplotConfusionMatrix(cfm)
```

![](https://github.com/aakhacha/Coursera_Data_Science_Johns_Hopkins/blob/master/Course_8_Practical_Machine_Learning/Week_4/plot4.png)

* As expected, model accuracy is highest at k = 5
* In-Sample Error Rate (Train Set) = 100% - 98.5% = 1.51%
* Out-Of-Sample Error Rate (Cross-Validation Set) = 100% - 97% = 3.02%

### Step 4: Predict on 20q Quiz (Test Set)
```{r}
test_pred <- predict(model, newtesting)
test_pred

##  [1] B A A A A E D B A A B C B A E E A B B B
## Levels: A B C D E

newtesting$pred_classe <- test_pred
```
Predicted with 95% accuracy on testing set based on 20 question quiz results.