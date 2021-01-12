# QMEE
## 2019 Apr 02 (Tue) JD _promises_ to simplify "radically" for 2021
# https://mac-theobio.github.io/QMEE/?version=123
# https://mac-theobio.github.io/QMEE/index.html

### Hooks for the editor to set the default target
current: target
-include target.mk

##################################################################

Sources += $(wildcard docs/*.html)

######################################################################

gh-pages:
	$(MAKE) $@.branchdir

##################################################################

## Root content

update: index.html.docs
## index.html: index.md

%.docs: %
	$(CP) $< docs

######################################################################

## A bunch of confusing rmd rules
Sources += pages.mk

######################################################################
## Formatting

mds = pandoc --mathjax -s -c html/qmee.css -B html/header.html -A html/footer.html -o $@ $<
%.html: %.md $(wildcard html/*.*)
	$(mds)

######################################################################

## Exporting

md = $(wildcard *.md)
rmd = $(wildcard *.rmd)
scripts = $(wildcard *.R)
bugs = $(wildcard *.bug)
mddown = $(rmd:rmd=md)
mdsource = $(filter-out $(mddown), $(md))

Sources += $(scripts) $(rmd) $(mdsource) $(bugs)
Ignore += $(mddown)
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

## Live sessions

Sources += live.mk

## Weird stuff

Sources += orphans.mk

######################################################################

### Makestuff

Sources = Makefile README.md LICENSE.md notes.txt TODO.md

msrepo = https://github.com/dushoff
ms = makestuff

# -include $(ms)/perl.def

Ignore += $(ms)
## Sources += $(ms)
Makefile: $(ms)/Makefile
$(ms)/Makefile:
	git clone $(msrepo)/$(ms)

-include $(ms)/os.mk

-include makestuff/git.mk
-include makestuff/visual.mk

