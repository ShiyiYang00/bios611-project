FROM rocker/rstudio

RUN R -e "install.packages('tidyverse')"
RUN R -e "install.packages('labelled')"
RUN R -e "install.packages('table1')"
RUN R -e "install.packages('ragg')"
RUN R -e "install.packages('sjPlot')"
RUN R -e "install.packages('MASS')"
RUN R -e "install.packages('survival')"
RUN R -e "install.packages('survminer')"
RUN R -e "install.packages('umap')"

