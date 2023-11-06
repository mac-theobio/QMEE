
## Original docs directory made by hand in repo root directory and pushed

## Make things into subdocs, which should be a link to docs/dirname 
dname = $(notdir $(CURDIR))
subdocs: | ../docs/$(dname)
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

mdhdocs = $(md:%.md=subdocs/%.html)
rmdnotes = $(rmd:%.rmd=subdocs/%.notes.html)
rmdslides = $(rmd:%.rmd=subdocs/%.slides.html)

update: $(mdhdocs) $(rmdnotes) $(rmdslides)

## Make products from a particular lecture
## I've been turning on and off the automake for .rmd
## If it's on we don't need this rule much

%.lecture: subdocs/%.notes.html subdocs/%.slides.html ;

######################################################################

## Make simple html from .md 
site_header = html/header.html
site_footer = html/footer.html
site_css = html/qmee.css
site_bib = ../qmee.bib
site_args = --self-contained
## mds = pandoc $< -o $@ --mathjax -s -B $(site_header) -A $(site_footer) --css $(site_css) $(site_args)
mds = pandoc $< -o $@ --mathjax -s -B $(site_header) -A $(site_footer) $(site_args) --bibliography=$(site_bib)
subdocs/%.html: %.md | html subdocs
	$(mds)

######################################################################

## Make products from .rmd

hpan = c("-B", "$(site_header)", "-A", "$(site_footer)")
noteargs = output_format=rmarkdown::html_document()
noteargs = output_format=rmarkdown::html_document(pandoc_args=$(hpan), css="$(site_css)")
slideargs = output_format=rmarkdown::ioslides_presentation()
notesrule = echo 'rmarkdown::render($(io), $(noteargs))' | R --vanilla
notesrule = echo 'rmarkdown::render($(io))' | R --vanilla
slidesrule = echo 'rmarkdown::render($(io), $(slideargs))' | R --vanilla
io = input="$<", output_file="$(notdir $@)"
## renderthere = output_file="$(notdir $@)", output_dir="$(dir $@)"
mvrule = $(MVF) $(notdir $@) $@

.PRECIOUS: subdocs/%.notes.html
subdocs/%.notes.html: %.rmd | html subdocs
	$(notesrule)
	$(mvrule)

.PRECIOUS: subdocs/%.slides.html
subdocs/%.slides.html: %.rmd | html subdocs
	$(slidesrule)
	$(mvrule)

######################################################################

