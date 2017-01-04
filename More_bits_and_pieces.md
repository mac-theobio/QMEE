R resources
-----------

-   Basic help: `help("topic")`, `?"topic`
-   Search all installed packages: `help.search()`
-   Find functions or objects containing a string: `apropos()`
-   Search all of CRAN: `library("sos");` `findFn(...)` (**amazingly
    useful**)
-   [Task views](http://www.maths.lancs.ac.uk/~rowlings/R/TaskViews/)
    -   Functionality for specific areas
    -   See especially
        [Phylogenetics](http://cran.r-project.org/web/views/Phylogenetics.html),
        [Environmetrics](http://cran.r-project.org/web/views/Environmetrics.html)
        (ignore the silly name)
    -   `ctv` package (installs all packages associated with a
        Task View)
-   The [UCLA R FAQ](http://www.ats.ucla.edu/stat/r/faq/) is very good
-   Mailing lists and forums:
    -   general ground rules
        -   browse/lurk before posting
        -   be clear about the focus of your question (e.g. r-help is
            not for stats questions)
        -   read the documentation as carefully as you can first;
            indicate what you've read
        -   "what have you tried?"
        -   provide a **minimal workable example** (e.g. see
            [here](http://tinyurl.com/reproducible-000))
    -   `r-help@r-project.org` (also via [Gmane
        interface](http://news.gmane.org/gmane.comp.lang.r.general))
    -   also "SIG" (special interest groups), especially r-sig-phylo,
        r-sig-ecology
    -   [StackOverflow
        (\[r](http://stackoverflow.com/questions/tagged/r) tag)\],
        [CrossValidated](http://stats.stackexchange.com)
    -   [Bioconductor support forum](https://support.bioconductor.org/)
    -   [\#rstats](https://twitter.com/search?q=%23rstats&src=typd) on
        Twitter
    -   [R-bloggers](http://www.r-bloggers.com/)
    -   `d-r-users@mcmaster.ca`

Phylogenetic/bioinformatic stuff
--------------------------------

-   Use `setRepositories()` to easily add
    [Bioconductor](http://www.bioconductor.org/) to your list of package
    repositories
-   `ape` package for most basic phylogenetic/sequence stuff
    -   `ape::read.GenBank`
    -   `DNAbin` data type
-   `taxize` and `traits` package for retrieving trees via Phylomatic
    -   `install.packages("devtools");` `install_github("traits")` (may
        need compilation tools;
        X[Rtools](http://cran.r-project.org/bin/windows/Rtools/) for
        Windows, [developer tools](http://r.research.att.com/tools/)
        for MacOS)
    -   then `library("phylomatic");` `?phylomatic`

