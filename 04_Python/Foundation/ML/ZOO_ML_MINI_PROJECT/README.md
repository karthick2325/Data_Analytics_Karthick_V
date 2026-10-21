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

## ⚙️ Installation and Setup

### Step 1: Install Python

Install Python from the official website:

https://www.python.org/downloads/

### Step 2: Install Required Libraries

Open the terminal in Visual Studio Code and run:

```bash
pip install pandas numpy scikit-learn matplotlib jupyter
```

### Step 3: Open the Project Folder

Open the `ZOO_ML_PRACTICE` folder in Visual Studio Code.

### Step 4: Check the Dataset Filename

The notebooks load the dataset using:

```python
data = pd.read_csv("zoo_ml_dataset.csv")
```

Make sure the CSV file is named `zoo_ml_dataset.csv` and is located in the same working directory as the notebooks. If your downloaded file has a different name, rename it or update the file path in the notebooks.

### Step 5: Run the Notebooks

Open each `.ipynb` file, select a Python kernel, and execute the cells from top to bottom.

Review the prediction outputs and evaluation metrics at the end of each notebook.

## 🔄 Project Workflow

1. Load the dataset using Pandas.
2. Explore the dataset and its columns.
3. Select the input features and target variable.
4. Split the data into training and testing sets for supervised learning.
5. Train the selected Machine Learning model.
6. Generate predictions or cluster assignments.
7. Evaluate model performance using appropriate metrics.
8. Review and interpret the results.

## 🚀 Future Improvements

- Increase the dataset size for more reliable evaluation.
- Perform detailed exploratory data analysis.
- Improve data validation and preprocessing.
- Use cross-validation for model comparison.
- Tune model hyperparameters.
- Compare additional classification and regression algorithms.
- Visualize model results and cluster assignments.
- Develop a dashboard for displaying predictions and evaluation metrics.

## 📝 Conclusion

This project provides practical experience with classification, regression, and clustering using Python and Scikit-learn.

Decision Tree and Random Forest achieved 66.67% accuracy in the current test outputs, while Logistic Regression achieved 33.33%. The Linear Regression model reported an R² score of 0.885, and K-Means achieved a Silhouette Score of 0.5055.

These results demonstrate the implementation of different Machine Learning evaluation techniques. Further testing with a larger dataset is necessary before drawing conclusions about model performance.

---

**Project Category:** Machine Learning Practice  
**Language:** Python  
**Environment:** Jupyter Notebook / Visual Studio Code  
**Status:** Model training, prediction, and initial evaluation completed
