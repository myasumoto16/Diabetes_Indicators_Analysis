# Load necessary libraries
library(class)  # for kNN algorithm
library(caret)  # for data splitting and evaluation
library(dplyr)  # for data manipulation

# Load the dataset
data <- diabetes_dataset

# Check the structure of the dataset
str(data)

# Set a seed
set.seed(123)

# Split the data into training and testing sets
trainIndex <- createDataPartition(data$Diabetes_binary, p = 0.8, list = FALSE)
trainData <- data[trainIndex, ]
testData <- data[-trainIndex, ]

# Normalize the data
normalize <- function(x) {
  return((x - min(x)) / (max(x) - min(x)))
}

trainData_normalized <- as.data.frame(lapply(trainData[, -1], normalize))
testData_normalized <- as.data.frame(lapply(testData[, -1], normalize))

# Extract labels
trainLabels <- as.factor(trainData$Diabetes_binary)
testLabels <- as.factor(testData$Diabetes_binary)

# Perform k-NN with k = 5
k <- 5
predictedLabels <- knn(train = trainData_normalized, test = testData_normalized, cl = trainLabels, k = k)

# Convert predictedLabels to factor with the same levels as testLabels
predictedLabels <- factor(predictedLabels, levels = levels(testLabels))

# Evaluate the model
confusionMatrix(predictedLabels, testLabels)
