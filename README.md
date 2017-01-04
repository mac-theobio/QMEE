The web site for Biology 708 https://mac-theobio.github.io/QMEE/index.html

To install the backend:


* Clone this repo

* you need JD's `makestuff` machinery
    * Clone https://github.com/dushoff/makestuff.git into $HOME/git (or anywhere, as long as it matches what's in the `$gitroot` variable in `local.mk`


* Examine standard.local
* Either
  * type `ln standard.local local.mk`
  * create `bb.local` and link that
* Type `make pages`

Then:

* From `pages` directory
  * <open> index.html shows you the local version

* From main directory
* `make push_pages` to update the pages/ directory. 
* `make sync` to sync _your work_
* `make push_site` to update the pages/ directory and sync _the site_.

