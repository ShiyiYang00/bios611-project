# Analysis of Employee Resignation

## Introduction
Employee resignation is a critical challenge for organizations, often leading to disruptions in operations, increased recruitment costs, and reduced morale. Understanding the factors that drive resignation, predicting when employees are likely to leave, and identifying patterns within employee groups can empower organizations to take proactive measures to improve retention and foster a productive and supportive work environment.

This project uses the [Employee Performance and Productivity dataset](https://www.kaggle.com/datasets/mexwell/employee-performance-and-productivity-data) offered on Kaggle, which includes detailed metrics such as employee demographics, performance evaluations, satisfaction scores, and work experience.
This dataset contains 100,000 employees and related 20 features (Employee ID, Department, Gender, Age, Job Title, Hire Date, Years at Company, Education Level, Performance Score, Monthly Salary, Work Hours per Week, Projects Handled, Overtime Hours, Sick Days, Remote Work Frequency, Team Size, Training Hours, Promotions, Employee Satisfaction Score, Resigned). For more detailed information about these features, please refer to the [data page](https://www.kaggle.com/datasets/mexwell/employee-performance-and-productivity-data).

The study aims to explore the dynamics of employee resignation.

**Outcome of Interest**: 
- Resign (0: the employee hasn't resigned; 1: the employee has resigned); 
- Years At Company (the number of years the employee has been working for the company)

**Three key questions**:

1.	What feature significantly affects employee resignation?
    
    Approach: Logistic Regression to identify which factors (e.g., satisfaction score, hours worked, etc.) significantly impact resignation.
2.	When will an employee resign, and what factors speed up resignation?
    
    Approach: Apply Cox Proportional Hazards model to predict time-to-resignation and key predictors that accelerate the process.
3.	Are employee groups distinguishable based on resignation?

    Approach: UMAP to reduce dimensionality and cluster employees based on resignation, exploring patterns in these groups.



## Setup Instructions
This repository contains an analysis using R, and the workflow is Dockerized.

Build the container.
```bash
docker build . -t bios611proj-env
```
This Docker container is based on rocker/rstudio. To run rstudio server:
```bash
docker run -v $(pwd):/home/rstudio/bios611proj -e PASSWORD=yourpassword --rm -p 8787:8787 bios611proj-env
```

In addition, Makefile is also provided.

If you want to build the figures, please create the dataset first as I downsampled the original dataset

```bash
make derived_data/employ_data_sub.rds
```
