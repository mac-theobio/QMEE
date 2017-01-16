---
title: "Week 2: Data management"
---

Goals
=====

-   We will discuss some principles of data management, data flow and
    reproducible research
-   Participants will continue to practice with R, and will examine
    their data and make some products

Resources
=========

-   [Managing data in R](Managing_data_in_R.html)
-   [Managing projects in R](Managing_projects_in_R.html)
-   [More bits and pieces](More_bits_and_pieces.html)

Preparation
-----------

In the second hour of Monday's class we will be working to get you set up with Git and Github, following [Happy Git and GitHub for the useR](http://happygitwithr.com/). 

If possible, before Monday's class:

- Register a GitHub account: you can just go straight to https://github.com to do this (by clicking on either of the green "Sign up" buttons). The one thing you may want to read first is [this advice on picking a GitHub user name](http://happygitwithr.com/github-acct.html).
- if you're on MacOS, it would be helpful to install XCode ahead of time (https://developer.apple.com/download/).
- it will also be helpful to install the `tidyverse` suite of R packages: 
  * within an R session, type `install.packages("tidyverse")`
  * (*or* you can do this via the package manager window in RStudio).

Exercise
========

<!---
Exercise supplemented this year because of awkward start
Old version:
Continue working on your data
-->

- Input your data into `R`.
- Examine your data for mistakes, and to make sure you understand the R classes
- Describe what sort of investigations you might do with your data, and how you might break it into replicable components
-   Make sure you know how to use `source`, `save` and `load` in R: finish a task, and then close R without saving your workspace and efficiently redo the task.

- Make a directory on the github repo named after yourself
- Upload your data and a script that reads them and does at least one thing with them
- Make a file _in your directory on the repo_ called README.md and put the description (bullet two above), in there
- Email us to say that your assignment is ready to be seen.
  * The R script should run and work independently when started in the correct directory (avoid absolute directory names in your script, and make sure you can restart your R session and run it correctly) 
