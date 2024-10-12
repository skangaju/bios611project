.PHONY: clean
.PHONY: init

init:
    mkdir -p derived_data
    mkdir -p figures

clean:
    rm -rf derived_data
    rm -rf figures
    mkdir -p derived_data
    mkdir -p figures

# Final Report
report.html: report.Rmd
	Rscript -e "rmarkdown::render('report.Rmd', output_format='html_document')"