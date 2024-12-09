rm(list=ls())
library(tidyverse)
library(sjPlot)
library(ragg)
getwd()

df <-  readRDS("derived_data/employ_data_sub.rds")
set.seed (1234)
train_idx <- sample(nrow(df), 0.8*nrow(df))
df.train <- df[train_idx,]
df.validate <-df[-train_idx ,]

# Full Model
fit.logit <- glm(Resigned~., data=df.train, family=binomial())
# summary(fit.logit)

fit.logit.reduced <- MASS::stepAIC(fit.logit, direction = "backward",trace = FALSE)
anova(fit.logit.reduced, fit.logit, test = "Chisq")
# summary(fit.logit.reduced)

logit.plot <- sjPlot::plot_model(
  fit.logit.reduced, 
  show.values = TRUE, 
  value.offset = .3,
  title = "Forest Plot of the Reduced Logistic Regression Model")

# Save plot using agg_png
agg_png("figs/reduced_logistic_reg_forest_plot.png", width = 3500, height = 2000, res = 500)
logit.plot
dev.off()


prob <- predict(fit.logit.reduced,df.validate,type="response")
# confusion table
logit.pred <- factor(prob>0.5, levels=c(FALSE, TRUE),labels=c("Not Resigned","Resigned"))
logit.perf <- table(df.validate$Resigned,logit.pred,dnn=c("Actual","Predicted"))
logit.perf

confusion_df <- as.data.frame(as.table(logit.perf))

# Plot the confusion matrix as a heatmap
ggplot(confusion_df, aes(x = Predicted, y = Actual, fill = Freq)) +
  geom_tile() +
  geom_text(aes(label = Freq), color = "white", size = 5) +
  labs(title = "Confusion Matrix", x = "Predicted", y = "Actual") +
  theme_minimal()

ggsave("figs/reduced_logistic_reg_pred_confusion_matrix.png")