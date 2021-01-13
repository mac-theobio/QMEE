
## docs directory should be made by hand in repo root directory and pushed
## Then it never needs to be made again

dname = $(notdir $(CURDIR))
docs:
	$(MAKE) ../docs/$(dname)
	ls -d ../docs/$(dname)
	ln -s ../docs/$(dname) $@

../docs/$(dname):
	$(mkdir)

## html directory likewise
## (pushed in repo root, this rule only applies in subdirectories)
Ignore += html
html:
	(ls -d ../$@ && ln -s ../$@ .)

######################################################################

md = $(wildcard *.md)
rmd = $(wildcard *.rmd)
mdh = $(md:.md=.html)
mdhdocs = $(md:%.md=docs/%.html)

update: $(mdhdocs)

######################################################################

mds = pandoc $< -o $@ --mathjax -s -B html/header.html -A html/footer.html --css html/qmee.css --self-contained
docs/%.html: %.md
	$(MAKE) html docs
	$(mds)

