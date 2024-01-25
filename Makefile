# QMEE
# https://mac-theobio.github.io/QMEE/?version=123

### Hooks for the editor to set the default target
current: target
-include target.mk

vim_session:
	bash -cl "vmt index.md rweb.mk"

##################################################################

Sources += $(wildcard docs/*.html) $(wildcard docs/*/*.html)
Sources += $(wildcard html/*.*)

######################################################################

## Root content

## docs/index.html: index.md

## current.md is for stashing stuff that's not current now, but was current before
Sources += index.md current.md
Ignore += index.html

docs/index.html: index.md
	pandoc $< -o $@ --mathjax -s -B html/mainheader.html -A html/mainfooter.html --css html/qmee.css --embed-resources --standalone

## Try suppressing rweb in main directory 2021 Jan 21 (Thu)
Sources += rweb.mk
## -include rweb.mk

######################################################################

## Manual visualizations
## Not clear why we have wildcards here

lectures/subdocs/%.html: $(wildcard lectures/*.rmd)
	cd lectures && $(MAKE) subdocs/$*.html
tips/subdocs/%.html: $(wildcard tips/*.rmd)
	cd tips && $(MAKE) subdocs/$*.html
assignments/subdocs/%.html: $(wildcard assignments/*.md)
	cd assignments && $(MAKE) subdocs/$*.html
topics/subdocs/%.html: $(wildcard topics/*.md)
	cd topics && $(MAKE) subdocs/$*.html

## lectures/subdocs/intro_R.slides.html: lectures/intro_R.rmd

## tips/subdocs/R_style.notes.html: tips/R_style.rmd

## topics/subdocs/Introduction_to_R.html: topics/Introduction_to_R.md

######################################################################

## Main update

update: docs/index.html data/index.html

## Subdirectories

%.update:
	cd $* && $(MAKE) update

subdirs += admin topics
subdirs += lectures tips assignments

######################################################################

Ignore += $(subdirs)
alldirs += $(subdirs)

update_all: $(subdirs:%=%.update) update

local_site: update_all
	$(MAKE) docs/index.html.go

old_site: gh-pages
	$(MAKE) gh-pages/index.html.go

pushup: update_all

dateup:
	touch docs/*.html docs/*/*.html

syncup: update_all pull dateup all.time

######################################################################

## Data index
## data/ lives in docs/ so that it's part of the pages

Makefile: | data code

Ignore += data
data: dir=docs
data:
	$(linkdir)

Sources += $(wildcard docs/data/*.*)

Sources += $(wildcard *.pl)
Sources += data.md
Ignore += data_index.md

## Edit data.md page; it's also supposed to edit itself
## To mark MISSING files and append UNTRACKED ones
data.md: $(wildcard data/*.*sv data/*.rd* data/*.RData)
	$(touch)
## Don't edit (might be read-only to remind you)
data_index.md: data.md dataindex.pl
	- $(MAKE) data data.filemerge
	$(PUSHRO)

## data/index.html: data.md
## data_index.md: data.md
data/index.html: data_index.md
	pandoc $< -o $@ --mathjax -s -f gfm -B html/header.html -A html/footer.html --css html/qmee.css --self-contained

######################################################################

## code is on the front side now (like data) 2021 Mar 19 (Fri)

Ignore += code
code: dir=docs
code:
	$(linkdir)
Sources += $(wildcard docs/code/*.*)

######################################################################

parademo_clean.Rout: code/parademo_clean.R 
	$(pipeR)

village_clean.Rout: code/village_clean.R 
	$(pipeR)

cars.Rout: code/cars.R
	$(pipeR)

######################################################################

hom1.Rout: hom1.R
	$(pipeR)

hom2.Rout: hom2.R hom1.Rout
	$(pipeR)

hom3.Rout: hom3.R hom2.Rout
	$(pipeR)

hom4.Rout: hom4.R hom2.Rout
	$(pipeR)

######################################################################

## Dushoff lectures that live elsewhere

Ignore += docs/legacy

######################################################################

## Old content

## git mv source stuff from oldSource to where it's wanted
## arcScript: ; git mv $(oldscripts) oldSource ##

## Look around, or emergency rescue
Ignore += gh-pages
gh-pages:
	$(MAKE) $@.branchdir

##################################################################

## A bunch of confusing rmd rules
Sources += pages.mk

## Live sessions

Sources += live.mk

## Weird stuff

Sources += orphans.mk

######################################################################

### Makestuff

Sources += Makefile README.md notes.txt

## TODO.md moved to private repo

msrepo = https://github.com/dushoff
ms = makestuff

-include makestuff/perl.def

Ignore += makestuff
Makefile: makestuff/Makefile
makestuff/Makefile:
	git clone $(msrepo)/makestuff

-include makestuff/os.mk

-include makestuff/pipeR.mk

-include makestuff/git.mk
-include makestuff/visual.mk

