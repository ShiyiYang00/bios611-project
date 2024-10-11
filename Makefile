# Variables for directories
INTERMEDIATE_DIR = intermediate_data
FIGURES_DIR = figures

# Clean target to remove intermediate data and figures
clean:
    rm -rf $(INTERMEDIATE_DIR) $(FIGURES_DIR)

# Target to build the report
report:
    Rscript -e "rmarkdown::render('report.Rmd')"