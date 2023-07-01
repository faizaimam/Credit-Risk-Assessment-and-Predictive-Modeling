library(tidyverse)
library(caret)
library(randomForest)

data <- read.csv("german_credit_data.csv")
breakpoints <- c(0,5000,10000,Inf)
data$risk <- cut(data$Credit.amount, breakpoints, labels = c("Low", "Medium", "High"))

cat_var <- sapply(data, is.character)
data[cat_var] <- lapply(data[cat_var],as.factor)
data <- subset(data, select = -X)

num_var <- sapply(data, is.numeric)
data[num_var] <- scale(data[num_var])

set.seed(73)
trainIndex <- createDataPartition(data$risk, p = 0.7, list = F)
train <- data[trainIndex, ]
test <- data[-trainIndex, ] 

trainX <- train[ ,c("Age","Sex","Job","Housing","Saving.accounts","Credit.amount","Duration","Purpose")]
trainY <- train$risk
testX <- test[ ,c("Age","Sex","Job","Housing","Saving.accounts","Credit.amount","Duration","Purpose")]
testY <- test$risk
#Modeling
#Random Forest Model
model_RF <- randomForest(x = trainX, y=trainY, ntree = 100)
predictions_RF <- predict(model_RF, newdata = testX)
CM_RF <- confusionMatrix(data = predictions_RF, reference = testY)
accuracyRF <- CM_RF$overall["Accuracy"]
accuracyRF

#I'll add more models for this data and compare among them
