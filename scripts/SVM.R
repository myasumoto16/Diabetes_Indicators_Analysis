library(caTools)
library(e1071)
library(caret)
library(ggplot2)
library(gridExtra)

data <- read.csv('~/Downloads/diabetes_dataset.csv')
summary(data)
set.seed(123)

split <- sample.split(data$Diabetes_binary, SplitRatio = 0.8)
trainData <- subset(data, split == TRUE)
testData <- subset(data, split == FALSE)

trainData$Diabetes_binary <- factor(trainData$Diabetes_binary)
testData$Diabetes_binary <- factor(testData$Diabetes_binary)

model <- svm(Diabetes_binary ~ ., data = trainData, kernel = "linear")

predictions <- predict(model, testData)

predictions <- factor(predictions, levels = levels(testData$Diabetes_binary))

confusion <- confusionMatrix(predictions, testData$Diabetes_binary)


# Confusion Table
confusion_frame <- as.data.frame(confusion$table)

confusion_plot <- ggplot(confusion_frame, aes(x = Reference, y = Prediction, fill = Freq)) +
  geom_tile(color = "white") +
  scale_fill_gradient(low = "white", high = "blue") +
  geom_text(aes(label = Freq), vjust = 1) +
  theme_minimal() +
  labs(title = "Confusion Matrix - SVM", x = "Predicted Class", y = "Actual Class")

print(confusion_plot)


