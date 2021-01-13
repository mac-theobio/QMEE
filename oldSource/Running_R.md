Reproducibility
===============

Once you get something to work, save a copy of the commands you are
using in a file. When you are done, start R from scratch (you should
avoid *ever* saving an R session from the interactive prompt when you
type `q()`), and make sure that the commands you have saved do what you
think.

You may try running R in "vanilla" mode. This will stop it from trying
to save its state to a default file, and also from automatically reading
a default state.

*More on this subject later.*

Locality
========

Your R scripts are most portable and flexible if they don't need paths
to data files. The easiest way to do this is to put your R scripts and
data in the same directory, and start R from this directory. Let us help
you figure out how to do this on your machine.
