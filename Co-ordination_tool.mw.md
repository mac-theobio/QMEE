You should try to have a pipeline-driven project where as many steps as
possible are clearly documented and easily replicable.

There are many, many techniques for this, and we will try not to get too
deeply into it in the course (unless it's a Requested Topic).

Some of the tools that we like include:

Make
----

[ make](Wikipedia:Make_(software) "wikilink") is a system for
controlling how files are made from other files. It is useful for making
your project self-documenting: you write down the steps of your pipeline
in a permanent fashion, in order to make them work.

There is an [ introduction to make on the Working
Wiki](Projects:Introduction_to_make "wikilink") on the projects wiki,
which means you are welcome to edit it as well as learn from it.

The [gnu make
documentation](http://www.gnu.org/software/make/manual/make.html) is
very useful, but not necessarily easy to attack.

*If you find useful resources for learning about make (especially
general uses), please post them on the participant wiki*

### Working wiki

[ Working wiki](Projects:Main_Page "wikilink") allows you to incorporate
projects driven by make into wiki pages, which has advantages in terms
of co-operative editing, versioning and so forth. It also has special
scripts designed to make it easier to run R on the wiki (it understands
how to save and read outputs and inputs without being told).

Working wiki is the tool that we use to embed working R scripts in this
wiki and the participant wiki, for example. All the information that the
wiki requires to run these scripts is on the wiki pages, and the
associated "Projects" pages (see `projects` box on the left).

R markdown
----------

R markdown is a format that allows you to incorporate R code into your
documents. This allows you (like the wiki) to develop and document your
project at the same time, and (better than the wiki) to allow your
documentation to evolve directly into a document that can be submitted
to a supervisory committee or a journal (the wiki can do this too, but
extra steps are involved).

RStudio makes a great platform for composing R markdown files, and
there's really good documentation on this format at the [RStudio web
site](http://rmarkdown.rstudio.com/). To recap some of the most
important features of R Markdown:

-   relatively natural/easy formatting rules
-   flexible output: HTML, PDF (even MS Word)
-   automatically incorporate figures
-   incorporate LaTeX equations
-   caching for long computations

