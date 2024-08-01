library(rpart)
library(rpart.plot)
library(caret) 
library(ggplot2)  

dbdata <- read.csv('~/Downloads/diabetes_dataset.csv')

set.seed(123)

trainIndex <- createDataPartition(dbdata$Diabetes_binary, p = 0.8, list = FALSE)
trainData <- dbdata[trainIndex, ]
testData <- dbdata[-trainIndex, ]

decision_tree <- rpart(Diabetes_binary ~ ., data = trainData, method = "class")

predictions <- predict(decision_tree, testData, type = "class")

testData$Diabetes_binary <- factor(testData$Diabetes_binary)
predictions <- factor(predictions, levels = levels(testData$Diabetes_binary))

confusion <- confusionMatrix(predictions, testData$Diabetes_binary)

print(confusion)

accuracy <- confusion$overall['Accuracy']
error_rate <- 1 - accuracy

cat("Accuracy: ", accuracy, "\n")
cat("Error Rate: ", error_rate, "\n")

confusion_df <- as.data.frame(confusion$table)

ggplot(confusion_df, aes(x = Reference, y = Prediction, fill = Freq)) +
  geom_tile(color = "white") +
  scale_fill_gradient(low = "white", high = "blue") +
  geom_text(aes(label = Freq), vjust = 1) +
  theme_minimal() +
  labs(title = "Confusion Matrix", x = "Predicted Class", y = "Actual Class")
