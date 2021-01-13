# QMEE
# https://mac-theobio.github.io/QMEE/?version=123

### Hooks for the editor to set the default target
current: target
-include target.mk

vim_session:
	bash -cl "vmt"

##################################################################

Sources += $(wildcard docs/*.html) $(wildcard docs/*/*.html)
Sources += $(wildcard docs/html/*.*)

######################################################################

## Root content

## docs/index.html: index.md

Sources += index.md
Ignore += index.html

docs/index.html: index.md
	pandoc $< -o $@ --mathjax -s -B html/header.html -A html/mainfooter.html --css html/qmee.css --self-contained

Sources += rweb.mk
-include rweb.mk

######################################################################

## Subdirectories

%.update:
	cd $* && $(MAKE) update

## admin
## admin.update:
subdirs += admin

## topics
## topics.update:
subdirs += topics

alldirs += $(subdirs)

update_all: makestuff $(subdirs:%=%.makestuff) $(subdirs:%=%.update) update

local_site: update_all
	$(MAKE) docs/index.html.go

## all.time:

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

Sources += Makefile README.md notes.txt TODO.md .gitignore

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

