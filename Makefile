# QMEE
# https://mac-theobio.github.io/QMEE/index.html

### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: CA_homicide_pix.md 

##################################################################

# make files

Sources = Makefile .gitignore README.md stuff.mk LICENSE.md notes.txt TODO.md
Sources += $(wildcard *.local)

include stuff.mk
-include $(ms)/git.def
-include $(ms)/perl.def
-include local.mk

##################################################################

## Rmd stuff

### Right now building "notes" html like regular html (with this upstream rule)
### Could cause problems with figures or (less likely) mathjax
Sources += $(wildcard *.Rmd *.rmd)
Sources += $(wildcard *.csv)

intro_Lecture_notes.md: intro_Lecture_notes.rmd
### md for _made_ markdown; not to be repo-ed
%.md: %.rmd
	echo 'knitr::knit("$<")' | R --vanilla

intro_Lecture_notes.io.html: intro_Lecture_notes.rmd
%.io.html: %.rmd
	echo 'library(rmarkdown); render("$<",output_format=ioslides_presentation(), output_file="$@")' | R --vanilla

pages/%.slides.html: %.md
	echo 'library(rmarkdown); render("$<",output_format=ioslides_presentation(), output_file="$@")' | R --vanilla

CA_homicide_pix.md: CA_homicide_pix.rmd
pages/CA_homicide_pix.html: CA_homicide_pix.rmd

######################################################################

## Scraping

.PRECIOUS: intro_%.mediawiki
intro_%.mediawiki:
	wget -O $@ "http://lalashan.mcmaster.ca/theobio/bio_708/index.php?title=Introduction_to_R/$*&action=raw"

.PRECIOUS: Visualization_%.mediawiki
Visualization_%.mediawiki:
	wget -O $@ "http://lalashan.mcmaster.ca/theobio/bio_708/index.php?title=Visualization/$*&action=raw"

.PRECIOUS: Permutations_%.mediawiki
Permutations_%.mediawiki:
	wget -O $@ "http://lalashan.mcmaster.ca/theobio/bio_708/index.php?title=Permutations/$*&action=raw"

intro_Lecture_notes.mediawiki:

.PRECIOUS: %.mediawiki
%.mediawiki: 
	wget -O $@ "http://lalashan.mcmaster.ca/theobio/bio_708/index.php?title=$*&action=raw"

Data_management.mw.md:
Visualization.mw.md:

Evolutionary_analysis.mediawiki:

##################################################################

## Converting
%.mw: %.mediawiki
	pandoc -f mediawiki -t markdown -o $@ $<

Sources += $(wildcard *.pl)
Statistical_philosophy.new: Statistical_philosophy.mw mdtrim.pl
%.new: %.mw mdtrim.pl
	$(PUSH)
	cp $@ $*.md

Data_management.tmk: Data_management.md tmk.pl
%.tmk: %.md tmk.pl
	$(PUSH)

%.rmk:
	$(RM) $*
	$(MAKE) $*

# Introduction_to_R.md: Introduction_to_R.mw.md mdtrim.pl

######################################################################

## Editing pages

Sources += $(wildcard *.md)
pages/index.html: index.md
pages/Importing_data.html: Importing_data.md

local:

######################################################################

## Formatting

Sources += qmee.css header.html footer.html
mds = pandoc -s -S -c qmee.css -B header.html -A footer.html -o $@ $<
pages/%.html: %.md qmee.css header.html footer.html
	$(mds)

######################################################################

## Exporting

pages:
	git clone git@github.com:mac-theobio/QMEE.git $@
	cp local.mk pages
	cd pages && $(MAKE) gh-pages.branch

md = $(wildcard *.md)
rmd = $(wildcard *.rmd)
pageroots = $(md:%.md=%) $(rmd:%.rmd=%)
pages = $(pageroots:%=pages/%.html)
slides = $(pages:%.html=%.slides.html)
pages/%.css: %.css
	$(copy)

pages/figure: 
	$(mkdir)

figure:
	$(mkdir)

## Update the _local copy_ of the site (open to open the main page as well)
push_pages: pages/figure pages/qmee.css $(pages) $(slides) 
	rsync figure/* pages/figure

open_pages: 
	$(MAKE) push_pages
	$(MAKE) pages/index.html.go

## Push the site to github.io (all to simultaneously sync this repo)
push_site: 
	$(MAKE) push_pages
	cd pages && $(MAKE) remotesync
push_all: 
	$(MAKE) push_site
	$(MAKE) sync

######################################################################

### Makestuff

## Change this name to download a new version of the makestuff directory
# Makefile: start.makestuff

-include $(ms)/git.mk
-include $(ms)/visual.mk
-include $(ms)/linkdirs.mk

# -include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk
