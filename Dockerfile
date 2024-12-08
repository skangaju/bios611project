FROM rocker/verse:latest
RUN R -e "install.packages('tidyverse')"
