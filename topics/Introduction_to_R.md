---
title: "Topic: Introduction to R"
date: Jan 2024
bibliography: "../qmee.bib"
---

If you have trouble with any of the steps below you can get help in class, or you can ask in (venue TBA)


Before Tuesday
----------------

*   Install and run the free (and open-source) program `R` from the links at the top of [the Comprehensive R Archive Network](http://cran.r-project.org/).
	 * If you have an older version of R (< 4.3.2), *please update to the latest version*.

* Install and run the free and open-source R
    development environment `RStudio` from the Download button at the
    [RStudio web site](http://www.rstudio.com/ide/). You should get the
    "desktop" version. (If you already have a preferred R coding environment you're
	welcome to use it instead.)

* install the `tidyverse` suite of R packages: 
  * within an R session, type `install.packages("tidyverse")`
  * (*or* use the package manager window in RStudio).
* Unless you already have one, [sign up for a github account](https://github.com) (click the big green "Sign up for GitHub" button)
	* You may want to read [this advice on picking a GitHub user name](http://happygitwithr.com/github-acct.html) first.
* If you're on MacOS, try to install XCode (following the instructions [here](https://happygitwithr.com/install-git.html#macos) or starting [here](https://developer.apple.com/download/)).
* e-mail your GitHub account name to <bio708qmee@gmail.com>

Before Thursday
----------------

* Get as far as you can through the following steps:
    * Read and follow the directions in chapters 1-7 (most of them are short!) in Jenny Bryan's [Happy Git with R](https://happygitwithr.com/)
* Read @wilson_good_2017
	
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
    *   Lecture notes ([slides](../lectures/intro_R.slides.html), [notes](../lectures/intro_R.notes.html))
    *   tidyverse  ([slides](../lectures/intro_tidyverse.slides.html), [notes](../lectures/intro_tidyverse.notes.html))
    *   [Importing data](../tips/Importing_data.html)
    *   [Running R](../tips/Running_R.html)

Thursday
=========

Our goal for Thursday's class is to set up repos, experiment with committing, pushing and pulling, and share with the instructors.

* E-mail your GitHub user name to `bio708qmee@gmail.com`, if you haven't already done so.
* Work through chapters 9 and 12 in [Happy Git with R](https://happygitwithr.com/)
* Make a directory on the github repo called `QMEE`
	* Be aware that your repo is publicly readable by default (you can make it private if you want)
* add Jonathan Dushoff (`@dushoff`) and Ben Bolker (`@bbolker`) as collaborators (`Settings` > `Collaborators` (left margin) > `Add collaborator`)

<!--- COMMENT
COMMENT -->

Assignment
==========

* Choose a data set that might be fun for you to explore for examples in this class (and possibly for the class project). Acquire the data (or make a plan to acquire it), and add a paragraph to the `README.md` file in your course repo describing it. Please give us some context for the data and describe the **biological** questions you would hope to answer (if you also want to translate your biological questions into statistical questions that's fine, but you should always start by framing the biological questions; the translation from biological to statistical questions is one of the hardest parts of data analysis).

Input some piece of this data (use some public data set if your real data set is not quickly available) into `R`, and do a substantive calculation using the data. You should upload a text file or spreadsheet, and an R script that reads it and does the calculation. You should confirm that these work by running them from beginning to end in a **clean R session** (in RStudio you can "Restart R", then "Run All" from the "Run" icon above the script window) before submitting by emailing the name of your main script to us at <bio708qmee@gmail.com>.

* See the [assignment instructions](../admin/assignments.html)

References
=========


