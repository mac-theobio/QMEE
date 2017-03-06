## Biology 708

The web site for Biology 708. The user-friendly view is [here](https://mac-theobio.github.io/QMEE/index.html).

##  Installing the backend

You can view any of the files for the course on this web site as well as in the user-friendly view.

If you want to work on this repository, you will have to take some extra steps. (If the instructions below look like gobbledygook, you should probably stay away ...)

* Clone this repo
* you need JD's `makestuff` machinery
    * Clone `https://github.com/dushoff/makestuff.git` into `$HOME/git` (or anywhere, as long as it matches what's in the `$gitroot` variable in `local.mk`
* Examine standard.local
* Either
  * type `ln standard.local local.mk`
  * create `<yourname>.local` and link that
* Type `make pages`

Then:

* From `pages` directory
  * <open> index.html shows you the local version

* From main directory
* `make push_pages` to update the pages/ directory. 
* `make sync` to sync _your work_
* `make push_site` to update the pages/ directory and sync _the site_.
* `make push_all` to update the pages/, sync the site and sync the repo..

