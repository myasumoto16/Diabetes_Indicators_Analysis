# Load necessary libraries
library(ggplot2)
library(dplyr)

# Load the dataset
data <- diabetes_dataset

# Check the structure of the dataset
str(data)

# Standardize the data (excluding the target variable)
data_standardized <- as.data.frame(scale(data[, -1]))

# Perform PCA
pca_result <- prcomp(data_standardized, center = TRUE, scale. = TRUE)

# Summary of PCA
summary(pca_result)

# Loadings of the first few principal components
print(pca_result$rotation[, 1:5])

# Add the cluster assignments to the original data
set.seed(123)
k <- 3
kmeans_result <- kmeans(data_standardized, centers = k)
data$Cluster <- kmeans_result$cluster

# Create a data frame for plotting
data_pca <- as.data.frame(pca_result$x)
data_pca$Cluster <- as.factor(data$Cluster)

# Visualize the clusters using the first two principal components
ggplot(data_pca, aes(x = PC1, y = PC2, color = Cluster)) +
  geom_point() +
  ggtitle('K-Means Clustering with PCA') +
  xlab('Principal Component 1') +
  ylab('Principal Component 2') +
  theme_minimal()
