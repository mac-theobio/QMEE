The web site for Biology 708 https://mac-theobio.github.io/QMEE/index.html

To install the backend:

* Clone this repo
* Examine standard.local
* Either
  * type `ln standard.local local.mk`
  * create bb.local and link that
* Type `make pages`

Then:

* From pages directory
  * <open> index.html shows you the local version

* From main directory
* `make push_pages` to update the pages/ directory. 
* sync however you want (I like `make sync` but it may have the same problem; there's probably also a simple workaround).
  * You can try to update the real site yourself, or just leave it to me if the following doesn't work.
* `make push_site` to update the pages/ directory and sync automatically (probably requires gvim). 

__Actually, right now I'm not sure you can do anything without gvim, which seems really stupid, but I'll push in case you have it__

