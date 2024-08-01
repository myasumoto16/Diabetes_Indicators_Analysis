library(caret) 
library(ggplot2) 

dbdata <- read.csv('~/Downloads/diabetes_dataset.csv')

set.seed(123)

trainIndex <- createDataPartition(dbdata$Diabetes_binary, p = 0.8, list = FALSE)
trainData <- dbdata[trainIndex, ]
testData <- dbdata[-trainIndex, ]

trainData$Diabetes_binary <- factor(trainData$Diabetes_binary)
testData$Diabetes_binary <- factor(testData$Diabetes_binary)

logistic_model <- glm(Diabetes_binary ~ ., data = trainData, family = binomial)

probabilities <- predict(logistic_model, testData, type = "response")
predictions <- ifelse(probabilities > 0.5, "1", "0")

predictions <- factor(predictions, levels = levels(testData$Diabetes_binary))

confusion <- confusionMatrix(predictions, testData$Diabetes_binary)

print(confusion)

accuracy <- confusion$overall['Accuracy']
error_rate <- 1 - accuracy

cat("Accuracy: ", accuracy, "\n")
cat("Error Rate: ", error_rate, "\n")

confusion <- confusionMatrix(predictions, testData$Diabetes_binary)
confusion_df <- as.data.frame(confusion$table)

confusion_plot <- ggplot(confusion_df, aes(x = Reference, y = Prediction, fill = Freq)) +
  geom_tile(color = "white") +
  scale_fill_gradient(low = "white", high = "blue") +
  geom_text(aes(label = Freq), vjust = 1) +
  theme_minimal() +
  labs(title = "Confusion Matrix", x = "Predicted Class", y = "Actual Class")

print(confusion_plot)

