# QMEE pages branch
# https://mac-theobio.github.io/QMEE/index.html

### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: index.html

##################################################################

# make files

Sources = Makefile .gitignore README.md stuff.mk LICENSE.md
include stuff.mk
-include $(ms)/git.def

Sources += $(wildcard *.html *.css *.R)

Sources += $(wildcard figure/*.*)

##################################################################

-include $(ms)/git.mk
-include $(ms)/visual.mk

# -include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk
