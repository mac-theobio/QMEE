msrepo = https://github.com/dushoff
gitroot = ./gitroot
export ms = $(gitroot)/makestuff
Drop = ./Dropbox

include local.mk
-include $(gitroot)/local.mk
export ms = $(gitroot)/makestuff
-include $(ms)/os.mk

local.mk:
	@echo \#\# You need local.mk
	@echo \#\# You could try linking standard.local
	@echo \#\# But look at it first
	@echo \#\# I need more explanations here
	exit 1 

standard_local:
	/bin/ln -s standard.local local.mk

Makefile: $(ms) $(subdirs)

$(ms):
	- mkdir $(gitroot)
	cd $(dir $(ms)) && git clone $(msrepo)/$(notdir $(ms)).git
