# QMEE
### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: pages 

##################################################################


# make files

Sources = Makefile .gitignore README.md stuff.mk LICENSE.md
include stuff.mk
# include $(ms)/perl.def

##################################################################

## Scraping

%.mediawiki: 
	wget -O $@ --post-data="title=$*&action=raw" "http://lalashan.mcmaster.ca/theobio/bio_708/index.php/"

## Converting
%.mw.md: %.mediawiki
	pandoc -f mediawiki -o $@ $<

MainPage.mw.md:

######################################################################

## Editing

pages:
	git clone git@github.com:mac-theobio/QMEE.git $@

######################################################################

### Makestuff

## Change this name to download a new version of the makestuff directory
# Makefile: start.makestuff

-include $(ms)/git.mk
-include $(ms)/visual.mk

# -include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk
