## rmd stuff

### Right now building "notes" html like regular html (with this upstream rule)
### Could cause problems with figures or (less likely) mathjax
Sources += $(wildcard *.csv)

Ignore += $(wildcard *.mkd)
### mkd for _made_ markdown; not to be repo-ed
%.mkd: %.rmd
	echo 'knitr::knit("$<")' | R --vanilla

%.io.html: %.rmd
	echo 'rmarkdown::render("$<",output_format=ioslides_presentation(), output_file="$(notdir $@)", output_dir="$(dir $@))"' | R --vanilla

ioslides = echo 'rmarkdown::render("$<",output_format="ioslides_presentation", output_file="$(notdir $@)", output_dir="$(dir $@)")' | R --vanilla

gh-pages/%.slides.html: %.md
	$(ioslides)

gh-pages/%.slides.html: %.rmd
	$(ioslides)


## Does not work
## If requested again this year (2017), use print to file
%.slides.pdf: %.md
	echo 'library(rmarkdown); render("$<",output_format=presentation(), output_file="$@")' | R --vanilla

CA_homicide_pix.md: CA_homicide_pix.rmd
gh-pages/CA_homicide_pix.html: CA_homicide_pix.rmd
