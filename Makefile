# Variables for directories
INTERMEDIATE_DIR = derived_data
FIGURES_DIR = figs

# Clean target to remove intermediate data and figures
clean:
    rm -rf $(INTERMEDIATE_DIR) $(FIGURES_DIR)

# Target to build the report
report:
    Rscript -e "rmarkdown::render('report.Rmd')"
