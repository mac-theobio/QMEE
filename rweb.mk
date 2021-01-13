
## docs directory should be made by hand in repo root directory and pushed
## Then it never needs to be made again

dname = $(notdir $(CURDIR))
Ignore += docs
docs:
	$(MAKE) ../docs/$(dname)
	ls -d ../docs/$(dname)
	ln -s ../docs/$(dname) $@

../docs/$(dname):
	$(mkdir)

html:
	(ls -d docs/$@ && ln -s docs/$@ .) \
	|| (cd .. && $(MAKE) $@ && ln -s ../$@ .)

######################################################################

md = $(wildcard *.md)
rmd = $(wildcard *.rmd)
mdh = $(md:.md=.html)
mdhdocs = $(md:.md=.html.docs)

update: $(mdhdocs)

######################################################################

mds = pandoc --mathjax -s -c html/qmee.css -B html/header.html -A html/footer.html -o $@ $<
%.html: %.md $(wildcard html/*.*)
	$(MAKE) html
	$(mds)

%.docs: %
	$(MAKE) docs
	$(CP) $< docs

