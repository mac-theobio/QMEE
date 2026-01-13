---
title: "Topic: Data management"
---

Goals
=====

-   We will discuss some principles of data management, data flow and
    reproducible research
-   Participants will continue to practice with R, and will examine
    their data and make some products

Resources
=========

- [Lecture notes](../lectures/cleaning.notes.html); [slides](../lectures/cleaning.slides.html)
-   [Managing data in R](../tips/Managing_data_in_R.html)
-   [Managing projects in R](../tips/Managing_projects_in_R.html)
-   [Ways to find help](../tips/Finding_help.html)
<!-- COMMENT
-   [Summarise and text tables](../tips/summarise_and_text_tables.R)
-->


Also: [OpenRefine](http://openrefine.org)  ([Data Carpentry lesson](https://datacarpentry.org/OpenRefine-ecology-lesson/))

Exercise
========

_See the [assignment instructions](../admin/assignments.html)_

### feedback from assignment 1
* If you used a simplified/domesticated data set for assignment 1, please find a 'real'/wild-caught data set for this assignment.
* If you are using code you've developed for a previous project, please streamline it as much as possible! Update/improve your code to take our [R style recommendations](../tips/R_style.notes.html) into account, repeat yourself less, etc.. (We prefer that you write new code for these assignments ...)

### assignment 2 tasks

* Examine the structure of the data you imported 
* Examine the data for problems, and to make sure you understand the R classes
* Make one or two plots that might help you see whether your data have any errors or anomalies
	* Report your results; fix any problems that you conveniently can
* Use the `saveRDS` function in R to save a clean (or clean-ish) version of your data
	* Use the `.gitignore` functionality in git -- do not in general put “made” objects into your repo
* Write a separate script that reads in your `.rds` file and does something with it: either a calculation or a plot
* In your `README.md` file:
	* Describe your two scripts -- what they do, where they are, what directory they should be run from.
	* Discuss what sort of investigations you are thinking you might do with your data, and how you might break your project into replicable components
