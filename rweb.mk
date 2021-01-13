
## docs directory should be made by hand in repo root directory and pushed
## Then it never needs to be made again

dname = $(notdir $(CURDIR))
docs:
	$(MAKE) ../docs/$(dname)
	ls -d ../docs/$(dname)
	ln -s ../docs/$(dname) $@

../docs/$(dname):
	$(mkdir)

Ignore += html
html:
	(ls -d docs/$@ && ln -s docs/$@ .) \
	|| ((cd .. && $(MAKE) $@) && (ln -s ../$@ .))

######################################################################

md = $(wildcard *.md)
rmd = $(wildcard *.rmd)
mdh = $(md:.md=.html)
mdhdocs = $(md:%.md=docs/%.html)

update: $(mdhdocs)

######################################################################

mds = pandoc --mathjax -s -c html/qmee.css -B html/header.html -A html/footer.html -o $@ $<
docs/%.html: %.md
	$(MAKE) html
	$(mds)

