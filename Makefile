.PHONY: clean
.PHONY: init

init:
	mkdir -p derived_data
	mkdir -p figures

clean:
	rm -rf report.html
	rm -rf derived_data
	rm -rf figures
	mkdir -p derived_data
	mkdir -p figures

# Tables and Figures from Works Data
derived_data/language_counts.csv figures/worksperyear.jpg figures/completion.jpg figures/restricted.jpg figures/wordcounts_10000.jpg figures/wordcounts_50000.jpg: works_tables_and_figures.R
	Rscript works_tables_and_figures.R

# Tables and Figures from Tags Data
derived_data/ratings_counts.csv derived_data/warnings_counts.csv derived_data/categories_counts.csv figures/worksbyfandom.jpg: tags_tables_and_figures.R
	Rscript tags_tables_and_figures.R
	
# Non-English Languages Histogram
figures/nonenglish_languages.jpg: derived_data/language_counts.csv nonenglish_languages.R
	Rscript nonenglish_languages.R

# Ratings Bar Chart
figures/ratings.jpg: derived_data/ratings_counts.csv ratings.R
	Rscript ratings.R

# Archive Warnings Bar Chart
figures/warnings.jpg: derived_data/warnings_counts.csv warnings.R
	Rscript warnings.R

# Categories Bar Chart
figures/categories.jpg: derived_data/categories_counts.csv categories.R
	Rscript categories.R

# Final Report
report.html: report.Rmd derived_data/language_counts.csv derived_data/ratings_counts.csv\
derived_data/warnings_counts.csv derived_data/categories_counts.csv\
figures/nonenglish_languages.jpg figures/worksperyear.jpg figures/completion.jpg\
figures/restricted.jpg figures/wordcounts_10000.jpg figures/wordcounts_50000.jpg\
figures/worksbyfandom.jpg figures/ratings.jpg figures/warnings.jpg figures/categories.jpg
	Rscript -e "rmarkdown::render('report.Rmd', output_format='html_document')"