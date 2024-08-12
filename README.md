# Diabetes Indicators Analysis Report

## 1. Introduction
- **Objective**: Analyze the Diabetes Health Indicators dataset to build models that can predict diabetes based on various health indicators.
- **Dataset Source**: Diabetes Health Indicators Dataset from Kaggle, uploaded by Alex Teboul.
- **Methodology**:
  - Explored different machine learning models.
  - Evaluated models based on accuracy, sensitivity, specificity, and other metrics.
  - Applied dimensionality reduction using PCA.
  - Performed unsupervised learning using K-Means Clustering.

## 2. Data Preparation
- **Dataset**:
  - https://archive.ics.uci.edu/dataset/891/cdc+diabetes+health+indicators
  - Consists of 21 features and a binary outcome (presence or absence of diabetes).
- **Preprocessing Steps**:
  - Handled missing values.
  - Standardized continuous features.
  - Encoded categorical variables.
- **Train/Test Split**: 80% training set, 20% test set.

## 3. Model Selection
- **Models Evaluated**:
  - K-Nearest Neighbors (K-NN)
  - Decision Tree
  - Naive Bayes
  - Logistic Regression
  - Support Vector Machine (SVM)
  - Principal Component Analysis (PCA) for dimensionality reduction
  - K-Means Clustering for unsupervised learning

## 4. Results and Discussion

### 4.1 Logistic Regression
- **Accuracy**: 72.06%
- **Sensitivity**: 69.20%
- **Specificity**: 74.91%
- **Positive Predictive Value (PPV)**: 72.50%
- **Kappa Statistic**: 0.4412 (moderate agreement)
- **Error Rate**: 27.94%
- **Statistical Significance**: P-value < 2e-16, significantly better than random guessing.

### 4.2 K-Nearest Neighbors (K-NN)
- **Accuracy**: 67.93%
- **Sensitivity**: 60.43%
- **Specificity**: 75.43%
- **Positive Predictive Value (PPV)**: 69.71%
- **Kappa Statistic**: 0.3540 (fair agreement)
- **Error Rate**: 32.07%
- **Model Selection**: Optimal K-value selected through cross-validation.

### 4.3 Decision Tree
- **Accuracy**: 64.69%
- **Sensitivity**: 64.49%
- **Specificity**: 64.89%
- **Positive Predictive Value (PPV)**: 64.54%
- **Kappa Statistic**: 0.2938 (fair agreement)
- **Error Rate**: 35.31%
- **Model Insights**: 
  - Prone to overfitting.
  - Complexity controlled by pruning.

### 4.4 Naive Bayes
- **Accuracy**: 71.74%
- **Sensitivity**: 65.22%
- **Specificity**: 78.26%
- **Positive Predictive Value (PPV)**: 75.68%
- **Kappa Statistic**: 0.4369 (moderate agreement)
- **Error Rate**: 28.26%
- **Model Characteristics**:
  - Assumes feature independence.
  - Performs well with categorical data.

### 4.5 Support Vector Machine (SVM)
- **Accuracy**: 72.03%
- **Sensitivity**: 69.14%
- **Specificity**: 74.94%
- **Positive Predictive Value (PPV)**: 72.54%
- **Kappa Statistic**: 0.4403 (moderate agreement)
- **Error Rate**: 27.97%
- **Statistical Significance**: P-value < 2e-16, significantly better than random guessing.

### 4.6 PCA Analysis
- **Purpose**: Reduce dimensionality of the dataset.
- **Transformation**: Original 21 features reduced to a smaller set of uncorrelated components.
- **Scree Plot**:
  - Showed a sharp decline after the first few components.
  - Indicated that the first few components captured most of the variance.
- **Key Features Identified**:
  - High blood pressure.
  - BMI.
  - General health.
- **Impact**: Enhanced model interpretability and performance by mitigating multicollinearity and noise.

### 4.7 K-Means Clustering
- **Objective**: Explore the underlying structure of the data.
- **Optimal Clusters**: Determined using the elbow method, suggesting three clusters.
- **Cluster Characteristics**:
  - Cluster 1: Primarily individuals with high risk factors.
  - Cluster 2: Mixed risk profile.
  - Cluster 3: Individuals with low risk factors.
- **Insights**:
  - Clustering provided insights into different risk profiles for diabetes.
  - Enhanced understanding of data segmentation.

## 5. Conclusion
- **Best Performing Models**: Logistic Regression and SVM with over 72% accuracy.
- **Key Findings**:
  - High blood pressure, BMI, and general health are significant predictors.
  - PCA and K-Means Clustering added value in understanding data structure and reducing dimensionality.
- **Future Work**: Consider advanced models or ensemble methods to improve prediction accuracy.

## 6. References
- Diabetes Health Indicators Dataset: Kaggle, uploaded by Alex Teboul.
- Instructor: Dr. Yousseff Qranfal, Wentworth Institute of Technology.
