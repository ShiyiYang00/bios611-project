rm(list=ls())
library(tidyverse)
library(survival)
library(survminer)
getwd()

df <-  readRDS("derived_data/employ_data_sub.rds")

df <- df %>%
  mutate(Resigned = ifelse(Resigned == "Resigned", 1, 0))

km_fit <- survfit(Surv(Years_At_Company, Resigned) ~ 1, data=df)
ggsurvplot(
  km_fit,
  data = df,
  xlab = "Years at Company",
  ylab = "Probability of Not Resigning",
  ggtheme = theme_minimal()
)
ggsave("figs/KM_plot.png",dpi=500)

summary(km_fit)$table

fit.coxph <- coxph(Surv(Years_At_Company, Resigned) ~ Department + Gender + Age + I(Age^2)+ Job_Title + Education_Level + Performance_Score + Monthly_Salary + Work_Hours_Per_Week + Projects_Handled + Overtime_Hours + Sick_Days + Remote_Work_Frequency + Team_Size + Training_Hours + Promotions + Employee_Satisfaction_Score, data=df)
# summary(fit.coxph)$coeff

fit.coxph.reduced <- MASS::stepAIC(fit.coxph, direction = "backward", trace=F)
# summary(fit.coxph.reduced)

anova(fit.coxph, fit.coxph.reduced, test = "Chisq")