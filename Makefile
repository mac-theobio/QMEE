# QMEE
## 2019 Apr 02 (Tue) JD _promises_ to simplify "radically" for 2021
# https://mac-theobio.github.io/QMEE/?version=123
# https://mac-theobio.github.io/QMEE/index.html

### Hooks for the editor to set the default target
current: target
-include target.mk

## push_local: 
## open_local: 
## push_site:

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

Sources += $(wildcard docs/*.md)
Sources += $(wildcard docs/*.html)

######################################################################

## Current

## gh-pages/permutation_examples.html: permutation_examples.rmd
## gh-pages/MultivariateMixed.html: MultivariateMixed.rmd
## gh-pages/Mixed_models.html: Mixed_models.md
## gh-pages/Mixed_models.slides.html: Mixed_models.md
## gh-pages/assignmentsMixed_models.md.html: assignments.md
## gh-pages/Mixed_models_examples.html: Mixed_models_examples.rmd

##################################################################

## Makefile: gh-pages

clonedirs += gh-pages
gh-pages:
	$(MAKE) $@.branchdir

##################################################################

## Root content

%.docs: %
	$(CP) $< docs

######################################################################

## A bunch of confusing rmd rules
Sources += pages.mk

######################################################################

## Orphaned

# gammaPrior.rmd. I cannot figure out how things work with the standard improper prior. It should give a posterior surface with the same shape as the likelihood surface on the log scale -- but doesn't seem to. Probably just too fast and loose with the calcs.

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
mddown = $(rmd:rmd=md)
mdsource = $(filter-out $(mddown), $(md))

Sources += $(scripts) $(rmd) $(mdsource) $(bugs)
Ignore += $(mddown)

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

gh-pages/%.html: %.rmd
	Rscript -e "library(\"rmarkdown\"); render(\"$<\")"
	mv -f $*.html $@
	- mv -f $*_files gh-pages

Ignore += dll_melt.rds

######################################################################

## Experimenting with live jags-ing

jags.Rout: jags.bug jags.R
fev.Rout: fev.bug fev.R

## Live power

power.Rout: power.R

######################################################################

Ignore += facebook_logo.png
facebook_logo.png: figure/gam-1.png Makefile
	convert -crop 500x300+0+100 $< $@

### Makestuff

-include $(ms)/git.mk
-include $(ms)/visual.mk

# -include $(ms)/pandoc.mk
-include $(ms)/stepR.mk

