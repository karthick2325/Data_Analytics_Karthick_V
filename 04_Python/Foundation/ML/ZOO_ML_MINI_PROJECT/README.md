# 🦁 Zoo Machine Learning Practice

## 📌 Project Overview

This project demonstrates the implementation and evaluation of five Machine Learning techniques using Python and Scikit-learn. The project uses a zoo-related dataset containing animal age, weight, health score, daily food cost, and disease risk information.

The main objective is to practice classification, regression, clustering, prediction, and model evaluation using different Machine Learning algorithms.

## 🎯 Project Objectives

- Explore and analyze the zoo dataset.
- Predict disease risk using classification algorithms.
- Estimate daily food cost using Linear Regression.
- Group similar records using K-Means clustering.
- Evaluate model performance using suitable evaluation metrics.
- Compare the results of different Machine Learning techniques.

## 🛠️ Technologies Used

- **Programming Language:** Python
- **Data Analysis:** Pandas, NumPy
- **Machine Learning:** Scikit-learn
- **Data Visualization:** Matplotlib
- **Development Environment:** Jupyter Notebook, Visual Studio Code
- **Dataset Format:** CSV

## 📂 Project Structure

```text
ZOO_ML_PRACTICE/
│
├── zoo_ml_dataset.csv
├── zoo_descison_tree.ipynb
├── zoo_logical_regression.ipynb
├── zoo_random_forest.ipynb
├── zoo_linear_reggression.ipynb
├── zoo_k-means.ipynb
├── Dataset
├── Outputs
└── README.md
```

## 📊 Dataset Description

The dataset contains **15 records and 5 columns**.

| Column | Description |
|---|---|
| `Age` | Age of the animal |
| `Weight` | Animal weight |
| `Health_Score` | Health score of the animal |
| `Daily_Food_Cost` | Daily food cost |
| `Disease_Risk` | Disease risk classification (`Yes` / `No`) |

### Dataset Usage

- **Input Features:** Age, Weight, Health_Score
- **Classification Target:** Disease_Risk
- **Regression Target:** Daily_Food_Cost
- **Clustering Features:** Age, Weight, Health_Score

## 🤖 Machine Learning Models

### 1. Decision Tree Classifier

Uses a Decision Tree algorithm to classify disease risk based on age, weight, and health score.

- Algorithm: `DecisionTreeClassifier`
- Maximum depth: 3
- Evaluation metrics: Accuracy, Precision, Recall, F1-score

### 2. Logistic Regression

Uses Logistic Regression to predict whether the disease risk is `Yes` or `No`.

- Algorithm: `LogisticRegression`
- Feature scaling: `StandardScaler`
- Maximum iterations: 1000
- Evaluation metrics: Accuracy and Classification Report

### 3. Random Forest Classifier

Uses an ensemble of decision trees to classify disease risk.

- Algorithm: `RandomForestClassifier`
- Number of estimators: 100
- Maximum depth: 3
- Evaluation metrics: Accuracy, Precision, Recall, F1-score

### 4. Linear Regression

Predicts daily food cost using animal age, weight, and health score.

- Algorithm: `LinearRegression`
- Training and testing split: 80% / 20%
- Evaluation metrics: MAE, RMSE, R² Score

### 5. K-Means Clustering

Groups similar records into three clusters based on selected numerical features.

- Algorithm: `KMeans`
- Number of clusters: 3
- Random state: 42
- Number of initializations: 10
- Feature scaling: `StandardScaler`
- Evaluation metric: Silhouette Score

## 📈 Model Evaluation Results

The following results were observed in the current Jupyter Notebook outputs.

| Model | Evaluation Metric | Result |
|---|---|---:|
| Decision Tree | Accuracy | 66.67% |
| Logistic Regression | Accuracy | 33.33% |
| Random Forest | Accuracy | 66.67% |
| Linear Regression | MAE | 122.66 |
| Linear Regression | RMSE | 167.89 |
| Linear Regression | R² Score | 0.885 |
| K-Means | Silhouette Score | 0.5055 |

### Understanding the Results

- **Accuracy:** Measures the proportion of correct classification predictions.
- **Precision:** Measures how many positive predictions were correct.
- **Recall:** Measures how many actual positive cases were identified.
- **F1-score:** Combines precision and recall into one metric.
- **MAE:** Measures the average absolute prediction error. Lower is generally better.
- **RMSE:** Measures prediction error while giving greater weight to larger errors. Lower is generally better.
- **R² Score:** Measures how well the regression model explains variation in the target.
- **Silhouette Score:** Evaluates how well-separated the clusters are. Higher values generally indicate better-separated clusters.

> **Important:** The classification notebooks currently evaluate only 3 test records. Therefore, the reported accuracy percentages are preliminary practice results and should not be treated as reliable estimates of real-world performance. A larger, representative dataset and cross-validation are recommended for a more reliable evaluation.

The Silhouette Score evaluates clustering quality; it is not a classification accuracy percentage.

 Visual Studio Code  
**Status:** Model training, prediction, and initial evaluation completed
