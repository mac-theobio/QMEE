---
title: Assignments
---

For the first few weeks of the course, there will be a short assignment every week. You are advised to start on these on Monday (whether we've said exactly what the assignment is by then or not). We will typically work on them or talk about them in class on Wednesday They are technically due Friday at noon. This is to encourage you to finish quickly if you can, and move on with your life, not to give you pressure. 

If your assignment will be late, please email us by Friday noon to let us know when you will hand it in. This should be before 2PM on Monday, unless we give permission for special circumstances.

_Submit your assignment by email_ to [bio708qmee@gmail.com](mailto:bio708qmee@gmail.com). Your assignment is not done until you do this. To submit an assignment:

* Tell us the main file we should be looking at, including the _relative path_ from the main repo directory, e.g, `dushoff/add.R`
Other files that are relevant can simply be mentioned in the script:
``` r
read.csv("eggplant_survey.csv")
## Plot the histotypes (see README.md)
```

* Make sure that your script runs, from beginning to end, _without absolute path names_ (just in case one of us doesn't have a directory called `E://From Oshawa Computer/Research Files/My Thesis/Data for 708/` already available)
* Put package names at the top, and use `library` instead of `require`, in case we don't have the packages you are using.

## General principles gleaned from assignment review

### don't

- use spaces or other special characters (`&`, `#`, `$`) in file names (`_` and `.` are OK)
- leave interactive commands like `View()`, `head()`, `str()` in your code [unless commented out]
- leave `install.packages()` in your code [ditto]
- use names of built-in R objects (especially `data`, but also: `sd`, `t`, `dt`, `df`, `I`, ...) for your own variables
- include absolute path names
- include `rm(list=ls())` (see [Jenny Bryan's blog post on this topic](https://www.tidyverse.org/articles/2017/12/workflow-vs-script/)
- load your data straight from a URL (best to download and cache the file, in case your network connection is bad or the file disappears/changes)
- use "extreme tidyverse"; e.g. `dd %>% pull(x) %>% mean()` instead of `mean(dd$x)`

### do

- use `count()` instead of `group_by(..)+summarize(count=n())`, *or* use base-R `table` [which also spreads the results]
- rename bad variable names (long, containing spaces or special characters) up front (with `dplyr::rename()`)
- use the `data=` argument whenever possible (e.g. `lm()`)
- use the `*_if()`, `*_at()`, `*_all()` versions of tidyverse functions (esp. `mutate` and `summarise`) to transform multiple columns
- use `stopifnot()` (or the `assertthat` package from the extended hadleyverse) to test conditions
