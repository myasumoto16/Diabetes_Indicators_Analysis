library(caTools)
library(e1071)
library(caret)
library(ggplot2)

data <- read.csv('~/Downloads/diabetes_dataset.csv')

data$Diabetes_binary <- as.factor(data$Diabetes_binary)

set.seed(123)
split <- sample.split(data$Diabetes_binary, SplitRatio = 0.8)
trainData <- subset(data, split == TRUE)
testData <- subset(data, split == FALSE)

trainData_std <- scale(trainData[,-which(names(trainData) == "Diabetes_binary")])
testData_std <- scale(testData[,-which(names(testData) == "Diabetes_binary")])

pca <- prcomp(trainData_std, center = TRUE, scale. = TRUE)

print(summary(pca))

trainData_pca <- data.frame(pca$x)
testData_pca <- predict(pca, newdata = testData_std)
testData_pca <- data.frame(testData_pca)

trainData_pca$Diabetes_binary <- trainData$Diabetes_binary
testData_pca$Diabetes_binary <- testData$Diabetes_binary

model_pca_svm <- svm(Diabetes_binary ~ ., data = trainData_pca, kernel = "linear")
predictions_pca <- predict(model_pca_svm, testData_pca)

confusion_pca <- confusionMatrix(predictions_pca, testData_pca$Diabetes_binary)

confusion_frame <- as.data.frame(confusion_pca$table)

confusion_plot <- ggplot(confusion_frame, aes(x = Reference, y = Prediction, fill = Freq)) +
  geom_tile(color = "white") +
  scale_fill_gradient(low = "white", high = "blue") +
  geom_text(aes(label = Freq), vjust = 1) +
  theme_minimal() +
  labs(title = "Confusion Matrix - PCA", x = "Predicted Class", y = "Actual Class")

print(confusion_pca)

print(confusion_plot)


accuracy_pca <- confusion_pca$overall['Accuracy']
error_rate_pca <- 1 - accuracy_pca

cat("Accuracy (PCA): ", accuracy_pca, "\n")
cat("Error Rate (PCA): ", error_rate_pca, "\n")

plot(pca, main = "PCA Biplot")
biplot(pca, main = "PCA Biplot")

# Save the PCA biplot
ggsave("pcaplot.png", width = 8, height = 6)
