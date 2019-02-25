# QMEE
# https://mac-theobio.github.io/QMEE/?version=123
# https://mac-theobio.github.io/QMEE/index.html

### Hooks for the editor to set the default target
current: target
-include target.mk

## push_local: 
## open_local: 
## push_site

pullup pull: pull_pages

##################################################################

msrepo = https://github.com/dushoff
ms = makestuff
-include $(ms)/os.mk

# -include $(ms)/perl.def

Ignore += $(ms)
## Sources += $(ms)
Makefile: $(ms)/Makefile
$(ms)/Makefile:
	git clone $(msrepo)/$(ms)

# make files

Sources = Makefile README.md LICENSE.md notes.txt TODO.md

-include $(ms)/git.def
-include $(ms)/perl.def

######################################################################

## Current

## gh-pages/permutation_examples.html: permutation_examples.rmd
## gh-pages/MultivariateIntro.html: MultivariateIntro.rmd

##################################################################

## Makefile: gh-pages

clonedirs += gh-pages
gh-pages:
	$(MAKE) $@.branchdir

##################################################################

## rmd stuff

### Right now building "notes" html like regular html (with this upstream rule)
### Could cause problems with figures or (less likely) mathjax
Sources += $(wildcard *.rmd)
Sources += $(wildcard *.csv)

Ignore += $(wildcard *.mkd)
### mkd for _made_ markdown; not to be repo-ed
%.mkd: %.rmd
	echo 'knitr::knit("$<")' | R --vanilla

%.io.html: %.rmd
	echo 'library(rmarkdown); render("$<",output_format=ioslides_presentation(), output_file="$@")' | R --vanilla

ioslides = echo 'library(rmarkdown); render("$<",output_format=ioslides_presentation(), output_file="$@")' | R --vanilla

%.slides.html: %.md
	$(ioslides)

gh-pages/%.slides.html: %.md
	$(ioslides)

## Does not work
## If requested again this year (2017), use print to file
%.slides.pdf: %.md
	echo 'library(rmarkdown); render("$<",output_format=presentation(), output_file="$@")' | R --vanilla

CA_homicide_pix.md: CA_homicide_pix.rmd
gh-pages/CA_homicide_pix.html: CA_homicide_pix.rmd

######################################################################

## Orphaned

# gammaPrior.rmd. I cannot figure out how things work with the standard improper prior. It should give a posterior surface with the same shape as the likelihood surface on the log scale -- but doesn't seem to. Probably just too fast and loose with the calcs.

######################################################################

## Editing pages
## It would be fun to figure out how to deal with the competing md streams

Sources += $(wildcard *.md)

######################################################################

## Formatting

Sources += qmee.css header.html footer.html
mds = pandoc --mathjax -s -c qmee.css -B header.html -A footer.html -o $@ $<
gh-pages/%.html: %.md qmee.css header.html footer.html
	$(mds)

## Did not chain properly (both figures and inputs)
gh-pages/%.pdf: %.md header.html footer.html
	pandoc --mathjax -s -o $@ $<

######################################################################

## Wrong place, wrong time!!!

## Can we use md ⇒ beamer to save cleaning slides?

######################################################################

## Exporting

md = $(wildcard *.md)
rmd = $(wildcard *.rmd)
scripts = $(wildcard *.R)
bugs = $(wildcard *.bug)

Sources += $(scripts) $(bugs)

pageroots = $(md:%.md=%) $(rmd:%.rmd=%)
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

## Need to update vim stuff before this works with C-F3
pullup: pull_pages

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

# Figure out what the old pathway was (still used for straight md)
# and unify (if possible on rmarkdown/render with some sort of qmee css)

## 2019 Feb 22 (Fri) This seemed to work but is now creating figures elsewhere

Ignore += cache/ *_cache/ *_files/

gh-pages/MultivariateIntro.html: MultivariateIntro.rmd
gh-pages/%.html: %.rmd
	Rscript -e "library(\"rmarkdown\"); render(\"$<\")"
	mv -f $*.html $@
	- mv -f $_files $@

######################################################################

## Experimenting with live jags-ing

jags.Rout: jags.bug jags.R

######################################################################

Ignore += facebook_logo.png
facebook_logo.png: figure/gam-1.png Makefile
	convert -crop 500x300+0+100 $< $@

### Makestuff

-include $(ms)/git.mk
-include $(ms)/visual.mk

# -include $(ms)/pandoc.mk
-include $(ms)/stepR.mk
