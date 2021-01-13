
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

######################################################################

## Need to update vim stuff before this works with C-F3
## pullup: pull_pages

pull_pages:
	cd gh-pages && make pull

## Update the _local copy_ of the site (open to open the main page as well)
push_local: 
	$(MAKE) figure gh-pages/figure gh-pages/qmee.css $(pages) $(slides) $(pscripts)
	-rsync figure/* gh-pages/figure

open_local: 
	$(MAKE) push_local
	$(MAKE) gh-pages/index.html.go

## Push the site to github.io (all to simultaneously sync this repo)
push_site: 
	$(MAKE) push_local
	cd gh-pages && $(MAKE) remotesync

push_all: 
	$(MAKE) push_site
	$(MAKE) sync

######################################################################


### Suppress stuff that's not working!
### Use sparingly
pagelist = $(md:%.md=%) $(rmd:%.rmd=%)
pageroots = $(filter-out MultivariateMixed, $(pagelist))
pageroots = $(pagelist)

pages = $(pageroots:%=gh-pages/%.html)
slides = $(pages:%.html=%.slides.html)
pscripts = $(scripts:%=gh-pages/%) $(bugs:%=gh-pages/%)
gh-pages/%.css: %.css
	$(copy)

gh-pages/%.bug: %.bug
	$(copy)

gh-pages/%.R: %.R
	$(copy)

gh-pages/figure: 
	$(mkdir)

Ignore += figure
figure:
	$(mkdir)
	cd $@ && touch null

######################################################################

# Figure out what the old pathway was (still used for straight md)
# and unify (if possible on rmarkdown/render with some sort of qmee css)

## 2019 Feb 22 (Fri) This seemed to work but is now creating figures elsewhere

Ignore += cache/ *_cache/ *_files/

gh-pages/%.html: %.rmd
	Rscript -e "library(\"rmarkdown\"); render(\"$<\")"
	mv -f $*.html $@
	- mv -f $*_files gh-pages

Ignore += dll_melt.rds

######################################################################
