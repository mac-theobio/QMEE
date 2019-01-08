---
title: "Week 1: Introduction to R"
---

Preparation
===========

-   Ideally, you should bring a laptop to class. If you can't, we'll
    work something out, but you definitely need access to a computer on
    which you can install and run the software that we will be using for
    the class

Before Monday
----------------

*   Install and run the free (and open-source) program `R` from the links at the top of [the Comprehensive R Archive Network](http://cran.r-project.org/).
	 * If you have an older version of R (< 3.5.2), *please update to the latest version*.

* Install and run the free (and open-source) R
    development environment `RStudio` from the Download button at the
    [RStudio web site](http://www.rstudio.com/ide/). You want the
    "desktop" version.

* install the `tidyverse` suite of R packages: 
  * within an R session, type `install.packages("tidyverse")`
  * (*or* use the package manager window in RStudio).

Before Wednesday
----------------

* [Sign up for a github account](https://github.com) (click the big green "Sign up for GitHub" button)
	* You may want to read [this advice on picking a GitHub user name](http://happygitwithr.com/github-acct.html) first.
* If you're on MacOS, try to [install XCode](https://developer.apple.com/download/).
* e-mail your GitHub account name to <bio708qmee@gmail.com>
* Get as far as you can through the following steps:
    * Read and follow the directions in chapters 1-7 (most of them are short!) in Jenny Bryan's [Happy Git with R](https://happygitwithr.com/)
* If you have trouble with any of this, you can get help on Wednesday
	
Goals
=====

*   An introduction to the R environment, and some basic principles of
    scripting and programming

*   Participants will install and run R, write a script, and read some
    data

Resources
=========

*   The official Introduction to R on the [R manuals
    page](http://cran.r-project.org/manuals.html)

*   Course material
    *   [Lecture notes](intro_Lecture_notes.html)
    *   [tidyverse](intro_tidyverse.html)
    *   [Importing data](Importing_data.html)
    *   [Running R](Running_R.html)

Wednesday
=========

Our goal for the second part of the session is to set up repos, experiment with commiting, pushing and pulling, and share with the instructors.

The repo that you intend to share with us should be called QMEE. It will be publicly readable by default.

<!--- COMMENT
COMMENT -->


Assignment
==========

* Choose a data set that might be fun for you to explore for examples in this class (and possibly for the class project). Acquire the data (or make a plan to acquire it), and add a paragraph to the README.md file in your course repo describing it. Please give us some context for the data and describe the **biological** questions you would hope to answer (if you also want to translate your biological questions into statistical questions that's fine, but you should always start by framing the biological questions; the translation from biological to statistical questions is one of the hardest parts of data analysis).

* Input some piece of this data (use some public data set if your real one is not quickly available) into `R`, and do a substantive calculation using the data. You should upload a text file or spreadsheet, and an R script that reads it and does the calculation. You should confirm that these work "independently" before submitting by emailing the name of your main script to us at <bio708qmee@gmail.com>.

