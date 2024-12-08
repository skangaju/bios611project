## Archive of Our Own: 2021 Data Dump Analysis

This project explores a data dump from the Archive of Our Own (AO3), which is a public archive 
that houses written / literary transformative works (fan fiction, written roleplays, etc). The 
data was officially released by the site management team in March of 2021.

After cloning this repository and accessing it from your console / terminal, follow these
instructions to reproduce the data analysis and generate the project report:

1. Build and run the `rocker/verse`-based Docker image using the following commands:

```
docker build . -t ao3
docker run --rm -ti -e PASSWORD=yourpassword -v "$(pwd):/home/rstudio/work" -p 8787:8787 ao3 /bin/bash
```

2. Enter the work directory with the `cd work` command.

3. Unzip the data files using the following commands:

```
sudo apt-get install unzip
unzip 20210226-stats.zip -d 20210226-stats
```

4. Initialize the directory with the `make init` command.

5. Generate the report with the `make report.html` command.

At any time, you can reset the work directory and regenerate the report with the following commands:
```
make clean
make report.html
```