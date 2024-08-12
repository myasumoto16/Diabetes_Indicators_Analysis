# Load necessary libraries
library(e1071)
library(caret)

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

# Extract labels
trainLabels <- trainData$Diabetes_binary
testLabels <- testData$Diabetes_binary

# Train the Naive Bayes model
model <- naiveBayes(Diabetes_binary ~ ., data = trainData)

# Make predictions on the test set
predictedLabels <- predict(model, testData)

# Convert testLabels to a factor for the confusion matrix
testLabels <- as.factor(testLabels)

# Evaluate the model
confusionMatrix(predictedLabels, testLabels)

confusion_df <- as.data.frame(confusion$table)
ggplot(confusion_df, aes(x = Reference, y = Prediction, fill = Freq)) +
  geom_tile(color = "white") +
  scale_fill_gradient(low = "white", high = "blue") +
  geom_text(aes(label = Freq), vjust = 1) +
  theme_minimal() +
  labs(title = "Naive Bayes Confusion Matrix", x = "Predicted Class", y = "Actual Class")
