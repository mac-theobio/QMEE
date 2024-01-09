---
title: "Biology 708/QMEE"
---

The web site for Biology 708. The user-friendly view is [here](https://mac-theobio.github.io/QMEE/index.html).

## Workflow

__Under construction__

Directories with course content:
* <repo>/ contains the index document for the website
* admin contains administrative materials
* topics contains an overview page for each topic (roughly a week (or optional week) of the course
* lectures contains lecture material
* tips contains additional material from us

All of these directories follow the same rules to farm out material to corresponding subdirectories of docs/ which is where the github.io pages are served.

Some make rules:
* syncup: I now use this when I start to work. It's supposed to merge work (including rendered products) without doing rendering unnecessarily.  Do this _instead_ of pull.
	* If you've pulled already, it might be OK to do dateup instead
* update_all: remake the site
* pushup: remake the site; push the main directory and all of the active subdirectories (sometimes with separate commits)
* local_site: remake the site and open a local-file-based version
* old_site: open a local-file-based version of the 2019 site from the gh-pages directory
* NOTE that rules which commit will open an editor for you (set variable MSEDITOR to control editor identity)

Consider using `make dateup` after pulling but before working; this will deal with time-stamp ambiguity and avoid attempts to remake things that you haven't worked on

## Data directory

data is version-controlled at docs/data. Avoid adding vc stuff to data/ directly. This can work for a while, but will definitely confuse new clones.

You are meant to edit the file data.md. It will also edit itself, as follows.

* If you refer to a file in the data directory (data/<fn.ext>) _before other words on a line_, it will take note of it and mark it MISSING if missing (only once; it can also remove the MISSING tag automatically)
* If you fail to refer to a file in the data directory, it will be added under Untracked files

From the weird hybrid file, the pipeline makes data_index.md (an intermediate) and then data/index.html (which is linked to docs). The index.html
* makes _all_ of the `data/<fn.ext>` instances into _local_ links (since the index file is itself in data)
	* this includes links to (recognized or unrecognized) MISSING files and links to Untracked files

You can update the data.md page through most kinds of auto-update (e.g., make update, make update_all, make sync), or just by saying make data_index.md (but there's no obvious reason to look at data_index.md, it is an intermediate towards data/index.html)

The usual style is to _keep_ the files identified as Untracked when the script is run, but delete the word Untracked (so you can notice if new Untracked files show up)

Here are some other directories that we currently have:

* `pix/`  miscellaneous non-workflow-generated images
* `oldSource/` 
* `makestuff/` machinery
* `html/` machinery

