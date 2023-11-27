# TODO

## Meta

Clean up TODO file (delete resolved/no-longer-relevant items: most entries here are very old)

Decide on appropriate venue for TODO items

Don't forget to cross-check with `TODO.md` in the private repo

## Miscellaneous

Garden of forking (¿¿ what does this mean ?? add material on Gelman and Loken 2014 "garden of forking paths" paper ??)

Find and link assignment guidelines

## Content

* perm example tweaks
    * size/area issues in ggplot?
    * split hist into separate chunk
    * add obs to vector of perm results
    * use nsim <- 1000

## Github

* Tell them:
	* to not "amend"
	* include the commit ID which pops up next to the word "master" when you commit.
	* to not stage files that are stupid, and to not stage files that are not in their own directory

* Ongoing problems
  * spawning "sh"
  * somebody says they can't click

## Assignments

- read & respond to student assignments (how are we coordinating this?)
  - JD will do a task script

## JD

* QMEE_private repo on bitbucket to bbolker

## Notes

* `which` doesn't always work on Windows, even if git does!
* `where` sometimes works where `which` doesn't

* parentheses for spanning and print for printing in tidyverse intro

## Admin/makestuff

Resolve `[WARNING] Deprecated: --self-contained. use --embed-resources --standalone` warning


######################################################################

## Optional/prettification

- put stuff in subdirectories
- render HTML with rmarkdown::render rather than pandoc, to get self-contained HTMLs
- don't make HTML/slides from all `.md` files (e.g. `TODO.md`)
- Add code in an appropriate place (possibly a header/footer file?) to [make ioslides use scroll bars](http://stackoverflow.com/questions/33287556/rmarkdown-ioslides-allowframebreaks-alternative) but not break: specifically (from that link) we need to incorporate
```
<style>
slides > slide { overflow: scroll; }
</style>
```
at an appropriate point in the slide files themselves, or in a CSS file they refer to
- Prettify CSS? https://www.stat.ubc.ca/~jenny/STAT545A/topic10_tablesCSS.html

######################################################################

Consolidating: 

* Import the rest of the wiki stuff that looks useful.
* Clean up and consolidate the structure here
	* Don't call .md from .Rmd the same extension as edited .md
	* How to specify what gets made on the pages side?
