Data structure
==============

You will typically import data into `R` as a data frame. This is
basically a rectangle of data, with each column representing a different
variable. R will try to figure out the type of each variable by looking
at the values.

Your rectangle may additionally have "names" (equivalent to "colnames")
at the top, and "rownames" along the left (see [ Attributes and
Selection](intro_Lecture_notes#Attributes.html) from
the lecture notes for a *little* more information about names).

Plain data
==========

You may have a table in text format (with "fields" separated by spaces
or tabs. Or you may use a spreadsheet program to save the data you want
to import in "CSV" format. To import such data, you will use the R
function `read.table` or `read.csv` (the latter is really just a version
of the former). You will want to read about these in R help (e.g., type
`?read.table`, and give some attention to the various arguments,
particularly `header`.

Spreadsheet data
================

If you prefer to save a spreadsheet in a proprietary format and read it
in directly, this actually works quite well, if you give your
spreadsheet a rectangular shape that R can understand.

You will need to use a [package](package.html) to do this; JD uses
`gdata`. Once you have loaded `gdata`, you can read about `read.xls` in
the documentation.

Although this works fine, we tend to prefer the CSV route, since it
makes it absolutely easy to look at your data file and make sure that it
consists exactly of what you want it to (no hidden Microsoft magic).

Missing data
============

If your data set has any missing values, you will want R to "get" that
they are missing. You should be able to do this with the `na.strings`
argument, and to verify it by applying summary to your new data frame
(which is something you should do anyway).

An example
==========

A csv file
----------

11 5, 14 6, 10 </source-file>

read.csv("xy.csv") print(dat) dat\$ratio &lt;- dat\$y/dat\$x print(dat)

