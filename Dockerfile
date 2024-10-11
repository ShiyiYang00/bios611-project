FROM rocker/rstudio

RUN apt-get update && apt-get install -y man-db && \
    yes | unminimize && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["/init"]
