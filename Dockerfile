FROM rocker/tidyverse
RUN apt update && apt install -y man-db && rm -rf /var/lib/apt/lists/*
yes | unminimize
