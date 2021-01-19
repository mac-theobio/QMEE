
## Original docs directory made by hand in repo root directory and pushed

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
Sources += $(md) $(rmd)

mdhdocs = $(md:%.md=docs/%.html)
rmdnotes = $(rmd:%.rmd=docs/%.notes.html)
rmdslides = $(rmd:%.rmd=docs/%.slides.html)

update: $(mdhdocs) $(rmdnotes) $(rmdslides)

## Make products from a particular lecture
## I've been turning on and off the automake for .rmd
## If it's on we don't need this rule much

%.lecture: docs/%.notes.html docs/%.slides.html ;

######################################################################

## Make simple html from .md
site_header = html/header.html
site_footer = html/footer.html
site_css = html/qmee.css
site_args = --self-contained
mds = pandoc $< -o $@ --mathjax -s -B $(site_header) -A $(site_footer) --css $(site_css) $(site_args)
docs/%.html: %.md
	$(MAKE) html docs
	$(mds)

######################################################################

## Make products from .rmd

hpan = c("-B", "$(site_header)", "-A", "$(site_footer)")
noteargs = output_format=rmarkdown::html_document(pandoc_args=$(hpan), css="$(site_css)")
slideargs = output_format=rmarkdown::ioslides_presentation()
notesrule = echo 'rmarkdown::render($(io), $(noteargs))' | R --vanilla
slidesrule = echo 'rmarkdown::render($(io), $(slideargs))' | R --vanilla
io = input="$<", output_file="$(notdir $@)"
## renderthere = output_file="$(notdir $@)", output_dir="$(dir $@)"
mvrule = $(MVF) $(notdir $@) $@

.PRECIOUS: docs/%.notes.html
docs/%.notes.html: %.rmd
	$(MAKE) html docs
	$(notesrule)
	$(mvrule)

.PRECIOUS: docs/%.slides.html
docs/%.slides.html: %.rmd
	$(MAKE) html docs
	$(slidesrule)
	$(mvrule)

######################################################################

