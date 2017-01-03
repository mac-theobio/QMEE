# QMEE
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

## This isn't recognizing title! Why not?
%.mediawiki: 
	wget -O $@ --post-data="title=$*&action=raw" "http://lalashan.mcmaster.ca/theobio/bio_708/index.php/"

## Converting
%.mw.md: %.mediawiki
	pandoc -f mediawiki -o $@ $<

MainPage.mw.md:
Outline.mw.md:

######################################################################

## Editing

Sources += $(wildcard *.md)
index.html: index.md

######################################################################

## Formatting

format = qmee.css header.html footer.html
Sources += $(format)
%.html: %.md qmee.css header.html footer.html
	pandoc -s -S -c qmee.css -B header.html -A footer.html -o $@ $<
pages/%.html: %.md qmee.css header.html footer.html
	pandoc -s -S -c qmee.css -B header.html -A footer.html -o $@ $<

######################################################################

## Exporting

pages:
	git clone git@github.com:mac-theobio/QMEE.git $@
	cp local.mk pages
	cd pages && $(MAKE) gh-pages.branch

md = $(wildcard *.md)
pages = $(md:%.md=pages/%.html)
pformat = $(format:%=pages/%)

push_site: $(format) $(pages)
	cd pages && $(MAKE) sync

######################################################################

### Makestuff

## Change this name to download a new version of the makestuff directory
# Makefile: start.makestuff

-include $(ms)/git.mk
-include $(ms)/visual.mk

# -include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk
