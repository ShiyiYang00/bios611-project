clean:
	rm -f derived_data/*
	rm -f figs/*
	rm -f report.pdf

report.pdf: report.Rmd
	Rscript -e "rmarkdown::render('report.Rmd', output_format='pdf_document')"

derived_data/employ_data_sub.rds: source_data/Extended_Employee_Performance_and_Productivity_Data.csv exploratory_analysis.R
	Rscript exploratory_analysis.R

figs/reduced_logistic_reg_forest_plot.png: derived_data/employ_data_sub.rds logistic_regression.R
	Rscript logistic_regression.R

figs/reduced_logistic_reg_pred_confusion_matrix.png: derived_data/employ_data_sub.rds logistic_regression.R
	Rscript logistic_regression.R

figs/KM_plot.png: derived_data/employ_data_sub.rds survival_analysis.R
	Rscript survival_analysis.R

figs/umap.png: derived_data/employ_data_sub.rds dimension_reduction.R
	Rscript dimension_reduction.R

