# QMEE
# https://mac-theobio.github.io/QMEE/index.html
### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: push_site 

##################################################################

# make files

Sources = Makefile .gitignore README.md stuff.mk LICENSE.md
include stuff.mk
# include $(ms)/perl.def

##################################################################

## Scraping

Evolutionary_analysis.new: %.new: Makefile
	wget -O $@ "http://lalashan.mcmaster.ca/theobio/bio_708/index.php?title=$*&action=raw"

## This isn't recognizing title! Why not?
%.mediawiki: Makefile
	wget -O $@ "http://lalashan.mcmaster.ca/theobio/bio_708/index.php?title=$*&action=raw"

%.arc:
	wget -O $@ --post-data="title=$*&action=raw" "http://lalashan.mcmaster.ca/theobio/bio_708/index.php/"

Evolutionary_analysis.mediawiki:

## Converting
%.mw.md: 
	pandoc -f mediawiki -o $@ $*.mediawiki

######################################################################

## Editing

Sources += $(wildcard *.md)
index.html: index.md
topics.html: topics.md

######################################################################

## Formatting

format = qmee.css header.html footer.html
Sources += $(format)
mds = pandoc -s -S -c qmee.css -B header.html -A footer.html -o $@ $<
%.html: %.md qmee.css header.html footer.html
	$(mds)
pages/%.html: %.md qmee.css header.html footer.html
	$(mds)

######################################################################

## Exporting

pages:
	git clone git@github.com:mac-theobio/QMEE.git $@
	cp local.mk pages
	cd pages && $(MAKE) gh-pages.branch

md = $(wildcard *.md)
pages = $(md:%.md=pages/%.html)
pages/%.css: %.css
	$(copy)

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

# -include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk
