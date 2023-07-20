This project was done to get a better understanding of the topic by doing the work practically.
So, there might be mistakes or misinterpretations. Feel free to point them out. Thank you!

## Credit Risk Assesment and Predictive Modelling


### 1. Packages

```{r eval =TRUE, warning = FALSE, message = FALSE}
library(tidyverse)
library(caret)
library(randomForest)
```
### 2. Data Description

The data used here is from: https://www.kaggle.com/datasets/uciml/german-credit. 

The original dataset contains 1000 entries with 20 categorial/symbolic attributes prepared by Prof. Hofmann. In this dataset, each entry represents a person who takes a credit by a bank. Each person is classified as good or bad credit risks according to the set of attributes.

The selected attributes are:
`Age`(numeric), `Sex` (text- male, female), `Job` (numeric: 0 - unskilled and non-resident, 1 - unskilled and resident, 2 - skilled, 3 - highly skilled), `Housing` (text -own, rent, or free), `Saving.accounts` (text - little, moderate, quite rich, rich), `Checking.account` (text),`Credit.amount` (numeric), `Duration` (numeric, in month), `Purpose` (text: car, furniture/equipment, radio/TV, domestic appliances, repairs, education, business, vacation/others). 

#### 2.1 Loading Data

```{r comment = ""}
data <- read.csv("german_credit_data.csv")
```
#### 2.2 Preprocessing Data
##### 2.2.1 Checking for missing values nad removing them
```{r comment="" }
sum(is.na(data))
data <- na.omit(data)
```
```
[1] 577
```

##### 2.2.1 Changing the variable `Credit.Amount` to `risk`
```{r comment = ""}
breakpoints <- c(0,5000,10000,Inf)
data$risk <- cut(data$Credit.amount, breakpoints, labels = c("Low", "Medium", "High"))
```
##### 2.2.2 Converting Categorical Variables into Factors
```{r comment = "" }
cat_var <- sapply(data, is.character)
data[cat_var] <- lapply(data[cat_var],as.factor)
data <- subset(data, select = -X)
```
##### 2.2.3 Scaling Numerical Variables
```{r comment = "" }
num_var <- sapply(data, is.numeric)
data[num_var] <- scale(data[num_var])

```
### 3. Modeling
#### 3.1 Splitting the dataset into train and test set
```{r comment="" }
set.seed(73)
trainIndex <- createDataPartition(data$risk, p = 0.7, list = F)
train <- data[trainIndex, ]
test <- data[-trainIndex, ] 

trainX <- train[ ,c("Age","Sex","Job","Housing","Saving.accounts","Credit.amount","Duration","Purpose")]
trainY <- train$risk
testX <- test[ ,c("Age","Sex","Job","Housing","Saving.accounts","Credit.amount","Duration","Purpose")]
testY <- test$risk
```
#### 3.2 Random Forest Model
Random Forest is a popular machine learning algorithm and is particularly useful when dealing with complex and high-dimensional datasets. The model is an ensemble learning method that combines multiple decision trees, known as the "forest," to make more accurate and robust predictions. Each decision tree in the forest is trained on a random subset of the data and a random subset of features, which helps to reduce overfitting and improve generalization.
```{r warning = FALSE, message=FALSE, comment="" }
model_RF <- randomForest(x = trainX, y=trainY, ntree = 100)
predictions_RF <- predict(model_RF, newdata = testX)
```
#### 3.3 Confusion Matrix
A confusion matrix is primarily employed to evaluate the performance of a classification model. It is a square matrix that compares the predicted classifications of the model with the actual labels of the data. The matrix organizes the outcomes into four categories: true positives (correctly predicted positive instances), true negatives (correctly predicted negative instances), false positives (incorrectly predicted positive instances), and false negatives (incorrectly predicted negative instances). By examining these elements, the confusion matrix provides valuable insights into the model's accuracy, precision, recall, and F1 score, which are crucial performance metrics. This allows us to gain a comprehensive understanding of how well our model is performing and make informed decisions on potential improvements and adjustments.
```{r comment="" }
CM_RF <- confusionMatrix(data = predictions_RF, reference = testY)
CM_RF
```
```
Confusion Matrix and Statistics

          Reference
Prediction Low Medium High
    Low    127      0    0
    Medium   0     22    1
    High     0      0    5

Overall Statistics
                                          
               Accuracy : 0.9935          
                 95% CI : (0.9646, 0.9998)
    No Information Rate : 0.8194          
    P-Value [Acc > NIR] : 1.363e-12       
                                          
                  Kappa : 0.9789          
                                          
 Mcnemar's Test P-Value : NA              

Statistics by Class:

                     Class: Low Class: Medium Class: High
Sensitivity              1.0000        1.0000     0.83333
Specificity              1.0000        0.9925     1.00000
Pos Pred Value           1.0000        0.9565     1.00000
Neg Pred Value           1.0000        1.0000     0.99333
Prevalence               0.8194        0.1419     0.03871
Detection Rate           0.8194        0.1419     0.03226
Detection Prevalence     0.8194        0.1484     0.03226
Balanced Accuracy        1.0000        0.9962     0.91667
```
Interpretation of the result of the confusion matrix:

**Accuracy:**
The overall accuracy of the model is 0.9935 or 99.35%. This indicates that the model correctly predicts the credit risk categories (Low, Medium, High) for approximately 99.35% of the instances in the dataset.

**95% Confidence Interval (CI):**
The accuracy has a 95% confidence interval between 0.9646 and 0.9998.

**No Information Rate (NIR):**
The no information rate represents the accuracy achieved by a naive model that always predicts the most prevalent class. Here, the NIR is 0.8194 or 81.94%. The model's accuracy is significantly better than the NIR, indicating that it is providing valuable predictions.

**Kappa:**
The Kappa statistic is a measure of agreement between the model's predictions and the actual classes. A Kappa of 0.9789 indicates very high agreement between the predicted and actual classes.

**Sensitivity, Specificity, Positive Predictive Value, Negative Predictive Value:**

Sensitivity represents the proportion of actual positive instances correctly predicted as positive. Here, the model has a sensitivity of 1.0000 for the "Low" and "Medium" classes, meaning it correctly identifies all instances of these classes. For the "High" class, the sensitivity is 0.83333, indicating that the model correctly identifies 83.33% of the "High" risk instances.

Specificity is the proportion of actual negative instances correctly predicted as negative. This model has a specificity of 1.0000 for the "Low" class, indicating that it correctly identifies all instances of "Low" risk. For the "Medium" class, the specificity is 0.9925, indicating that it correctly identifies 99.25% of the "Medium" risk instances. The "High" class has a specificity of 1.0000, meaning it correctly identifies all "High" risk instances.

The positive predictive value (precision) measures the accuracy of the model's positive predictions. The model has a precision of 1.0000 for the "Low" and "High" classes, indicating that all instances predicted as "Low" or "High" are correct. For the "Medium" class, the precision is 0.9565, meaning 95.65% of the instances predicted as "Medium" are correct.

The negative predictive value measures the accuracy of the model's negative predictions. The model has a negative predictive value of 1.0000 for the "Low" class, indicating that all instances predicted as "Not Low" are correct. For the "Medium" class, the negative predictive value is 1.0000, indicating that all instances predicted as "Not Medium" are correct. For the "High" class, the negative predictive value is 0.99333, meaning 99.33% of the instances predicted as "Not High" are correct.

**Prevalence, Detection Rate, Detection Prevalence:**
Prevalence is the proportion of instances belonging to each class in the dataset. The prevalence of "Low," "Medium," and "High" risk classes are 0.8194, 0.1419, and 0.03871, respectively. Detection rate measures the proportion of actual positive instances correctly predicted by the model. The detection rates for the "Low," "Medium," and "High" classes are 0.8194, 0.1419, and 0.03226, respectively. Detection prevalence measures the proportion of predicted positive instances in the dataset. The detection prevalences for the "Low," "Medium," and "High" classes are 0.8194, 0.1484, and 0.03226, respectively.

Overall, the model exhibits high accuracy and good performance in predicting credit risk categories. It shows high sensitivity, specificity, and precision for most classes, indicating its ability to identify and classify instances correctly. However, the performance for the "High" risk class is slightly lower compared to the other classes, as reflected in the lower sensitivity and balanced accuracy. This could suggest that the model might struggle to correctly identify instances with high credit risk.

We'll use some other predictive models to see the differences between the performances and choose the best one.
