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

- E-mail your GitHub user name to `bio708qmee@gmail.com`, if you haven't already done so.
- Input your data into `R`.
- Examine your data for mistakes, and to make sure you understand the R classes
- Describe what sort of investigations you might do with your data, and how you might break it into replicable components: save this (somewhere) as a file called `README.md`
-   Make sure you know how to use `source`, `save` and `load` in R: finish a task, and then close R without saving your workspace and efficiently redo the task.
- Make a directory on the github repo named after yourself; add your data, a script that does something with the data, and the `README.md` file you created above to this directory
    - *more detailed instructions on this to follow, but approximately ...*
    - (all subsequent steps are in RStudio)
	- in the menus, go to `File > New Project > Version Control > Git`
	- enter `https://github.com/mac-theobio/QMEE_2017.git` as the repository URL (or the equivalent `git@...` URL if you have set up SSH keys). You can also find this string by clicking on the `Clone` button on the [front page of the QMEE_2017 repo](https://github.com/mac-theobio/QMEE_2017).
	- click on the `New Folder` button in the files panel. **Use your GitHub ID for the folder name**, and don't let RStudio autocorrect it!
	- copy your CSV file to this directory (using the file browser in your operating system)
	- either press the `New File` button in RStudio to create your R script (when you save it, *make sure you click on your personal subdirectory/folder to save it there*), or copy an R script you created somewhere else to your personal subdirectory
	- **still working on how to tell RStudio/git to add the file to the git repository ...**
	- Click on the Git icon (should appear on your menu bar)
	    - make sure your files are 'staged' (check boxes)
		- click `Commit` and enter a commit message
		- click `Push`
- E-mail us to say that your assignment is ready to be seen.
  - The R script should run and work independently when started in the correct directory (avoid absolute directory names in your script, and make sure you can restart your R session and run it correctly) 
