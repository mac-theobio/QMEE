What is a package?
==================

Packages are supplements to R that increase what it can do. Packages are
not loaded automatically when you start R, and many are not installed
automatically when you install R.

To load a package
=================

Use `library(package_name)`. If this doesn't work, it probably means you
do not have the package installed. If you save your session, and reload
it, R will not reload packages automatically; you have to do it again.
Read the help for `library`. Do you understand why we prefer it to
`require`?

To install a package
====================

Use the `install.packages()` function. You will need to give it at least
one argument, I think. The help for this should be sufficiently
explanatory.

Try it right now!
=================

If you've never installed a package before, try it. `reshape` is a good
one to try. Then you can load it and try to figure out what "cast" and
"melt" do (using R help, or the internet).
