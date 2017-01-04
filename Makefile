# QMEE
# https://mac-theobio.github.io/QMEE/index.html
### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: Statistical_philosophy.new 

##################################################################

# make files

Sources = Makefile .gitignore README.md stuff.mk LICENSE.md notes.txt
include stuff.mk
include $(ms)/git.def
include $(ms)/perl.def

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

## Editing

Sources += $(wildcard *.md)
index.html: index.md
topics.html: topics.md

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
pages = $(md:%.md=pages/%.html)
pages/%.css: %.css
	$(copy)

push_pages: pages/qmee.css $(pages)
	cd pages

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
