## This is 708/admin

current: target
-include target.mk

# -include makestuff/perl.def

vim_session:
	bash -cl "vmt"

######################################################################

Sources += $(wildcard *.rmd)

## make should make a docs/ subdirectory here which maps to 
## an subdirectory in docs
## make update should make html from the md files it finds here

Ignore += docs
include ../rweb.mk

######################################################################

update: intro_Lecture_notes.lecture intro_tidyverse.lecture

######################################################################

### Makestuff

Sources += Makefile

## Sources += content.mk
## include content.mk

Ignore += makestuff
msrepo = https://github.com/dushoff

## Want to chain and make makestuff if it doesn't exist
## Compress this ¶ to choose default makestuff route
Makefile: makestuff/Makefile
makestuff/Makefile:
	cd .. && $(MAKE) makestuff
	ln -s ../makestuff .
	ls $@

-include makestuff/os.mk

## -include makestuff/makeR.mk

-include makestuff/git.mk
-include makestuff/visual.mk
