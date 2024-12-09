rm(list=ls())
library(tidyverse)
library(labelled)
# library(table1)
getwd()

# 1. Read data and assign labels to columns
df = read_csv("source_data/Extended_Employee_Performance_and_Productivity_Data.csv",show_col_types = FALSE)
# assign labels to columns

df <- df %>%
  mutate(across(c(Department, Gender, Job_Title, Education_Level,Resigned, Remote_Work_Frequency, Promotions, Performance_Score), as.factor))
df$Resigned <- factor(df$Resigned, levels=c(FALSE, TRUE), labels=c("Not Resigned", "Resigned"))
df <- df %>%select(-Employee_ID,-Hire_Date)

# 2. Descriptive statistics - Table 1
df_table1 <- table1::table1 (~Department+Gender+Age+Job_Title+Years_At_Company+Education_Level+
          Performance_Score+Monthly_Salary+Work_Hours_Per_Week+Projects_Handled+
          Overtime_Hours+Sick_Days+Remote_Work_Frequency+Team_Size+
          Training_Hours+Promotions+Employee_Satisfaction_Score|Resigned, data=df)
set.seed(1234)
no_resign_sample <- df[df$Resigned == "Not Resigned", ] %>%
  sample_n(size = 10010, replace = FALSE)

# 3. Down-sampling
df_sub <- rbind(no_resign_sample, df[df$Resigned == "Resigned", ])
df_sub_table1 <- table1::table1(~Department+Gender+Age+Job_Title+Years_At_Company+Education_Level+
                          Performance_Score+Monthly_Salary+Work_Hours_Per_Week+Projects_Handled+
                          Overtime_Hours+Sick_Days+Remote_Work_Frequency+Team_Size+
                          Training_Hours+Promotions+Employee_Satisfaction_Score|Resigned, data=df_sub)

# 4. Save the data
var_label(df_sub$Performance_Score) <- "Employee's Performance Rating."
var_label(df_sub$Overtime_Hours) <- "Total Overtime Hours Worked in the Last Year."
var_label(df_sub$Remote_Work_Frequency) <- "Percentage of Time Worked Remotely."
var_label(df_sub$Employee_Satisfaction_Score) <- "Employee Satisfaction Rating."
var_label(df_sub$Job_Title) <- "Job Title"
var_label(df_sub$Years_At_Company) <- "Years at Company"
var_label(df_sub$Education_Level) <- "Education Level"
var_label(df_sub$Monthly_Salary) <- "Monthly Salary"
var_label(df_sub$Work_Hours_Per_Week) <- "Work Hours per Week"
var_label(df_sub$Projects_Handled) <- "Projects Handled"
var_label(df_sub$Sick_Days) <- "Sick Days"
var_label(df_sub$Team_Size) <- "Team Size"
var_label(df_sub$Training_Hours) <- "Training Hours"

saveRDS(df_sub, "derived_data/employ_data_sub.rds")