# TODO

## Content

BB:

* A whole bunch of stuff (rmds if you want them, cleaning the notes, lecture prep)

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

## Admin

######################################################################

## Optional/prettification

- put stuff in subdirectories
- don't make HTML/slides from all `.md` files (e.g. `TODO.md`)
- Add code in an appropriate place (possibly a header/footer file?) to [make ioslides use scroll bars](http://stackoverflow.com/questions/33287556/rmarkdown-ioslides-allowframebreaks-alternative) but not break: specifically (from that link) we need to incorporate
```
<style>
slides > slide { overflow: scroll; }
</style>
```
at an appropriate point in the slide files themselves, or in a CSS file they refer to
- Prettify CSS? https://www.stat.ubc.ca/~jenny/STAT545A/topic10_tablesCSS.html
