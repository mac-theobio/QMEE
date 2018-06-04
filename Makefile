# QMEE
# https://mac-theobio.github.io/QMEE/index.html

### Making slides locally now 
### Rethink pages paradigm for next time!

### Hooks for the editor to set the default target
current: target
-include target.mk

push_pages: Generalized_linear_models.rmd

##################################################################

msrepo = https://github.com/dushoff
ms = makestuff
Ignore += local.mk
-include local.mk
-include $(ms)/os.mk

# -include $(ms)/perl.def

Ignore += $(ms)
## Sources += $(ms)
Makefile: $(ms) $(ms)/Makefile
$(ms):
	git clone $(msrepo)/$(ms)

# make files

Sources = Makefile .gitignore .ignore README.md LICENSE.md notes.txt TODO.md

-include $(ms)/git.def
-include $(ms)/perl.def
-include local.mk

######################################################################

## Current

gh-pages/cleaning.slides.html: cleaning.rmd

##################################################################

Makefile: gh-pages

clonedirs += gh-pages
gh-pages:
	$(MAKE) $@.branchdir

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

## Real WW transformation?

Sources += bayes.bug

Generalized_linear_models.rmd:
Generalized_linear_models.autormd:

%.autormd: %.mediawiki wwrmd.pl
	$(PUSH)

######################################################################

## Scraping

.PRECIOUS: intro_%.mediawiki
intro_%.mediawiki:
	wget -O $@ "http://lalashan.mcmaster.ca/theobio/bio_708/index.php?title=Introduction_to_R/$*&action=raw"

.PRECIOUS: Visualization_%.mediawiki
Visualization_%.mediawiki:
	wget -O $@ "http://lalashan.mcmaster.ca/theobio/bio_708/index.php?title=Visualization/$*&action=raw"

.PRECIOUS: Bayesian_statistics_%.mediawiki
Bayesian_statistics_%.mediawiki:
	wget -O $@ "http://lalashan.mcmaster.ca/theobio/bio_708/index.php?title=Bayesian_statistics/$*&action=raw"

.PRECIOUS: Multiple_comparisons_%.mediawiki
Multiple_comparisons_%.mediawiki:
	wget -O $@ "http://lalashan.mcmaster.ca/theobio/bio_708/index.php?title=Multiple_comparisons/$*&action=raw"

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

%.tmk: %.md tmk.pl
	$(PUSH)

%.rmk:
	$(RM) $*
	$(MAKE) $*

# Introduction_to_R.md: Introduction_to_R.mw.md mdtrim.pl

######################################################################

## Editing pages

Sources += $(wildcard *.md)
gh-pages/index.html: index.md
gh-pages/Importing_data.html: Importing_data.md

local:

######################################################################

## Formatting

Sources += qmee.css header.html footer.html
mds = pandoc --mathjax -s -S -c qmee.css -B header.html -A footer.html -o $@ $<
gh-pages/%.html: %.md qmee.css header.html footer.html
	$(mds)

## Did not chain properly (both figures and inputs)
gh-pages/%.pdf: %.md header.html footer.html
	pandoc --mathjax -s -S -o $@ $<

######################################################################

## Wrong place, wrong time!!!

## Can we use md ⇒ beamer to save cleaning slides?

######################################################################

## Exporting

md = $(wildcard *.md)
rmd = $(wildcard *.rmd)
pageroots = $(md:%.md=%) $(rmd:%.rmd=%)
pages = $(pageroots:%=gh-pages/%.html)
slides = $(pages:%.html=%.slides.html)
scripts = $(wildcard *.R)
pscripts = $(scripts:%=gh-pages/%)
gh-pages/%.css: %.css
	$(copy)

gh-pages/%.R: %.R
	$(copy)

gh-pages/figure: 
	$(mkdir)

Ignore += figure
figure:
	$(mkdir)

## Update the _local copy_ of the site (open to open the main page as well)
push_pages: gh-pages/figure gh-pages/qmee.css $(pages) $(slides) $(pscripts)
	rsync figure/* gh-pages/figure

open_pages: 
	$(MAKE) push_pages
	$(MAKE) gh-pages/cleaning.slides.html.go

## Push the site to github.io (all to simultaneously sync this repo)
push_site: 
	$(MAKE) push_pages
	cd pages && $(MAKE) remotesync
push_all: 
	$(MAKE) push_site
	$(MAKE) sync

######################################################################

### Makestuff

-include $(ms)/git.mk
-include $(ms)/visual.mk
-include $(ms)/linkdirs.mk

# -include $(ms)/wrapR.mk
