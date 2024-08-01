# Load necessary libraries
library(rpart)
library(rpart.plot)

dbdata <- read.csv('~/Downloads/diabetes_binary_5050split_health_indicators_BRFSS2015.csv')

# Fit the decision tree model
decision_tree <- rpart(Diabetes_012 ~ ., data = dbdata, method = "class")

# Plot the decision tree
rpart.plot(decision_tree, box.palette = "Blues")
