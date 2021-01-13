## This is 708/topics

current: target
-include target.mk

# -include makestuff/perl.def

vim_session:
	bash -cl "vmt"

######################################################################

Sources += $(wildcard *.md)

## make should make a docs/ subdirectory here which maps to 
## a subdirectory in docs
## make update should make html from the md files it finds here

Ignore += docs
include ../rweb.mk

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
