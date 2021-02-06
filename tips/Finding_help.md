---
title: "R resources"
---

-   Basic help: `help("topic")`, `?"topic`
-   Search all packages that you have installed: `help.search()`
-   Find functions or objects containing a string: `apropos()`
-   Search all of CRAN (full-text): `library("sos");` `findFn(...)`
    useful**)
-   [Task views](https://cran.r-project.org/web/views/) (a cute alternative view [here](http://www.maths.lancs.ac.uk/~rowlings/R/TaskViews/))
    -   Functionality for specific areas
    -   See especially
        [Phylogenetics](http://cran.r-project.org/web/views/Phylogenetics.html),
        [Environmetrics](http://cran.r-project.org/web/views/Environmetrics.html) ("Analysis of Ecological and Environmental Data")
    -   `ctv` package (installs all packages associated with a
        Task View)
-   The [UCLA R FAQ](http://www.ats.ucla.edu/stat/r/faq/) is very good
-   Mailing lists and forums:
    -   general ground rules for mailing lists etc.
        -   browse/lurk before posting
        -   be clear about the focus of your question (e.g. r-help is
            not for stats questions)
        -   read the documentation as carefully as you can first;
            indicate what you've read
        -   "what have you tried?"
        -   provide a **minimal workable example** (e.g. see
            [here](http://tinyurl.com/reproducible-000))
    -   [R mailing lists](https://www.r-project.org/mail.html) will answer questions, have searchable archives
	     - main list [r-help@r-project.org](https://stat.ethz.ch/mailman/listinfo/r-help)
         - also "SIG" (special interest groups), especially [r-sig-phylo](https://stat.ethz.ch/mailman/listinfo/r-sig-phylo), [r-sig-ecology](https://stat.ethz.ch/mailman/listinfo/r-sig-ecology)
		 - in Google you can add `site:` qualifiers, e.g. `"site:stat.ethz.ch/pipermail/r-sig-ecology NMDS"`
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

-  Install the `BiocManager` package from CRAN, then `BiocManager::install()`
-   Use `setRepositories()` to easily add
    [Bioconductor](http://www.bioconductor.org/) to your list of package
    repositories
-   `ape` package (CRAN) for most basic phylogenetic/sequence stuff
    -   `ape::read.GenBank`
    -   `DNAbin` data type
-   `brranching`, `taxize`, `traits` packages for retrieving trees and species traits

