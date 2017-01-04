Pipelines
=========

One of the main concepts of this course is **pipelines**. This means
that the various steps of your project are all carefully recorded and
systematized. The basic idea is that you should be able to delete any
results of computer calculations at any time, and then quickly re-do it.

Ideally, your project should depend on:

-   Some data files
-   Some scripts
-   A [co-ordination tool](co-ordination_tool "wikilink") (a document,
    master script, or Makefile that describes all of the steps involved
    in all of your calculations)

... and nothing else

Advantages of pipelines
-----------------------

-   Clarity
    -   Colleagues and collaborators can see exactly what you've done
    -   You can figure out exactly what you've done

<!-- -->

-   [Reproducibility](http://reproducibleresearch.net/index.php/RR_links)
    -   It's easy for others to confirm your work
    -   Or modify or extend it
    -   [A scary story about why we should practice and push for
        reproducible research](http://www.economist.com/node/21528593)

<!-- -->

-   Flexibility
    -   You are less likely to be trapped by choices that you've made

Automation
----------

A corollary of the flexibility idea is that you should *automate*
whenever possible. Cutting and pasting, or editing by hand, is not only
tedious, error-prone and hard to replicate, it also traps you into
depending on certain data sets. **DRY** ("don't repeat yourself") is a
programming maxim.

Some examples:

-   You can do most of your quality-control and correction with clever
    scripts; even when you can't be clever, it's still probably worth
    coding your corrections in a script (rather than, for example,
    changing an Excel file that came out of the lab).
-   As you develop your scripts, you will find yourself wanting to do
    various tasks in a repetitive way. You should get in the habitat of
    writing **functions** in R as you rework your script and realize
    that you are doing the same task (or nearly the same task)
    multiple times.
-   You should use computer scripts to download data from the web
    when possible. This is possibly beyond the scope of this course (or
    maybe it could be added as an advanced topic).
    -   R has tools for this, you can also check Perl and Python (5
        years from now, we may be teaching this whole course in python).

R tools for managing projects
=============================

Spreadsheets
------------

R can read and write in spreadsheet form. Usually the best way to do
this is with `read.csv` and `write.csv`. A good model for working in R
is to read in raw data from spreadsheets and manipulate it in R.

-   If somebody has done a trivial calculation in the spreadsheet, it's
    usually better to redo it than to copy the answer
-   If somebody has done a *non-trivial* calculation in the spreadsheet,
    it's usually better to redo it than to copy the answer
    -   It's probably easier in R.
    -   Even if it's harder in R this time, doing it once will enable
        you to do it in the future and save time (but see
        [this](http://xkcd.com/1319/)).
    -   It's usually better to do non-trivial calculations twice and
        make sure you get the same answer
    -   It's very easy to mess things up in spreadsheets
    -   It *should* be harder to make silly mistakes in R -- but in
        practice it doesn't seem to be.
-   ["spreadsheet
    addiction"](http://www.burns-stat.com/documents/tutorials/spreadsheet-addiction/)

Your goal in many cases should be to take raw data from a spreadsheet
and manipulate entirely using scripts. The only time to put it back in a
spreadsheet would be to share it with colleagues who want to play with
your results

-   Another option is to force these colleagues to learn R

Metadata
--------

-   Data about the data
-   Big topic
-   Often saved in spreadsheet/lost in translation
-   [ecological metadata language](https://github.com/ropensci/EML)
-   Discuss ...

Data bases
----------

Large, or evolving data sets may need to use database tools. As of 2015,

-   "small" means "fewer than 1000 observations/10 or 20 variables". As
    long as you write reasonably efficient R programs, you shouldn't
    have to worry about speed or memory at all.
-   "medium" means "1000 to 100,000 observations/10-50 variables". You
    may want to look into efficient data handling packages such as
    **dplyr** or **data.table**
-   "large" means millions of observations/1000s of variables. You may
    need to store your database in an external database application (R
    is very good at communicating with external databases). This means
    using [ SQL](Wikipedia:SQL "wikilink") (a standard language for
    database queries) and a database server. Many free servers are
    available, including [ MySQL](Wikipedia:MySQL "wikilink").

*This is a possible advanced topic*

R
-

If you are following the pipeline philosophy, it will be useful to make
scripts that do discrete tasks, and depend on each others' outputs.

You can do this by using the R commands `load` and `save`: if you have
an R script that you are happy with and is producing some nice
variables, you can write `save(var1,` `var2,` `vars,`
`file="happy.RData"`, at the end of that script, and then
`load("happy.RData")` at the beginning of some other scripts.

*How should you get more information about these commands?*
