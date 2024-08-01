# Load necessary libraries
library(rpart)
library(rpart.plot)
library(caret) 

dbdata <- read.csv('~/Downloads/diabetes_dataset.csv')

set.seed(123)

trainIndex <- createDataPartition(dbdata$Diabetes_binary, p = 0.9, list = FALSE)
trainData <- dbdata[trainIndex, ]
testData <- dbdata[-trainIndex, ]

decision_tree <- rpart(Diabetes_binary ~ ., data = trainData, method = "class")

testData$Diabetes_binary <- factor(testData$Diabetes_binary)
predictions <- factor(predictions, levels = levels(testData$Diabetes_binary))

confusion <- confusionMatrix(predictions, testData$Diabetes_binary)
print(confusion)

rpart.plot(decision_tree, box.palette = "Blues")