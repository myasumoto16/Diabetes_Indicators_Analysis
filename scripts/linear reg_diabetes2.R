# Install the ggplot2 package if not already installed
# install.packages("ggplot2")

# Load necessary libraries
library(caret)
library(ggplot2)

# Load the dataset
data <- diabetes_dataset

# Check the structure of the dataset
str(data)

# Set a seed
set.seed(123)

# Split the data into training and testing sets
trainIndex <- createDataPartition(data$BMI, p = 0.8, list = FALSE)
trainData <- data[trainIndex, ]
testData <- data[-trainIndex, ]

# Train the Linear Regression model
model <- lm(BMI ~ ., data = trainData)

# Make predictions on the test set
predictedValues <- predict(model, testData)

# Calculate the performance metrics
mse <- mean((predictedValues - testData$BMI)^2)
rmse <- sqrt(mse)
r2 <- summary(model)$r.squared

# Print the performance metrics
print(paste("MSE:", mse))
print(paste("RMSE:", rmse))
print(paste("R-squared:", r2))

# Convert predicted and actual BMI values to categorical outcomes
threshold <- 25
predictedCategorical <- ifelse(predictedValues > threshold, 1, 0)
actualCategorical <- ifelse(testData$BMI > threshold, 1, 0)

# Evaluate the model with a confusion matrix
conf_matrix <- confusionMatrix(as.factor(predictedCategorical), as.factor(actualCategorical))

# Print the confusion matrix
print(conf_matrix)

# Create a data frame for plotting
plotData <- data.frame(Actual = testData$BMI, Predicted = predictedValues)

# Create the plot
ggplot(plotData, aes(x = Actual, y = Predicted)) +
  geom_point(color = 'blue') +
  geom_abline(intercept = 0, slope = 1, color = 'red') +
  ggtitle('Predicted vs. Actual BMI') +
  xlab('Actual BMI') +
  ylab('Predicted BMI') +
  theme_minimal()
