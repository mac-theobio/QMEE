# QMEE
# https://mac-theobio.github.io/QMEE/index.html
# https://docs.google.com/spreadsheets/d/1J1Zus295rPJADVXIt6GwomSxisgDurhjzskhUtsMbr4/edit#gid=2011507906

### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: open_pages 

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

intro_Lecture_notes.md: intro_Lecture_notes.rmd
### md for _made_ markdown; not to be repo-ed
%.md: %.rmd
	echo 'knitr::knit("$<")' | R --vanilla 

intro_Lecture_notes.io.html: intro_Lecture_notes.rmd
%.io.html: %.rmd
	echo 'library(rmarkdown); render("$<",output_format=ioslides_presentation(), output_file="$@")' | R --vanilla

pages/%.slides.html: %.md
	echo 'library(rmarkdown); render("$<",output_format=ioslides_presentation(), output_file="$@")' | R --vanilla

######################################################################

# Dushoff learns patch!

intro_Lecture_notes.diff: intro_Lecture_notes.md intro_Lecture_notes.rmd
	- diff $^ > $@

intro_Lecture_notes.test: intro_Lecture_notes.md intro_Lecture_notes.diff
	patch -o $@ $^

##################################################################

## Scraping

intro_%.mediawiki:
	wget -O $@ "http://lalashan.mcmaster.ca/theobio/bio_708/index.php?title=Introduction_to_R/$*&action=raw"

intro_Lecture_notes.mediawiki:

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
	cp -n $@ $*.md

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
pages = $(md:%.md=pages/%.html) $(rmd:%.rmd=pages/%.html)
slides = $(md:%.md=pages/%.slides.html)
pages/%.css: %.css
	$(copy)

push_pages: pages/qmee.css $(pages) $(slides) 
	$(MAKE) pages/index.html.go

open_pages: 
	$(MAKE) push_pages
	$(MAKE) pages/index.html.go

push_site: pages/qmee.css $(pages)
	cd pages && $(MAKE) sync

check:
	@echo $(pages)

######################################################################

### Makestuff

## Change this name to download a new version of the makestuff directory
# Makefile: start.makestuff

-include $(ms)/git.mk
-include $(ms)/visual.mk
-include $(ms)/linkdirs.mk

# -include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk
