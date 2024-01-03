R_OPTS = --vanilla
.DEFAULT_GOAL := all

*.yml: data.tsv scripts/create_ymls.R
	Rscript scripts/create_ymls.R
copy_yml: ymls/_quarto-english.yml ymls/_quarto-russian.yml
	cp ymls/_quarto-english.yml ./_quarto.yml
	cp ymls/_quarto-russian.yml ru/_quarto.yml
render_english: ./_quarto.yml index.qmd resources.qmd card.ejs copy_yml
	quarto render ./
render_russian: ru/_quarto.yml ru/index.qmd ru/resources.qmd card_ru.ejs copy_yml
	quarto render ./ru
all: render_english render_russian
