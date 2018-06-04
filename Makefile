# QMEE pages branch
# https://mac-theobio.github.io/QMEE/index.html

### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: index.html

##################################################################

# make files

Sources = Makefile .ignore README.md LICENSE.md
Ignore = .gitignore
-include $(ms)/git.def

msrepo = https://github.com/dushoff
ms = makestuff
Ignore += local.mk
-include local.mk
-include $(ms)/os.mk

Ignore += $(ms)
Makefile: $(ms) $(ms)/Makefile
$(ms):
	git clone $(msrepo)/$(ms)

######################################################################

Sources += $(wildcard *.html *.css *.R)
Sources += $(wildcard figure/*.*)

##################################################################

-include $(ms)/git.mk
-include $(ms)/visual.mk

# -include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk
