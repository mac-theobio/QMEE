---
title: Assignments
---

Week 9
------

Course content

* Make a (possibly generalized) linear mixed model for one or more of your hypotheses. 
* Discuss what choices you made about mixed effects (both grouping variables and related effects; i.e., what did you put on each side of a pipe)
* Identify the maximal model that you could have used, and explain what you left out (if anything) and why
* Discuss your results

Final project

* Write some ideas about what data and questions you would pursue if your project were chosen as a final project for a group of 2 or 3 people
* This can be just a restatement of ideas you've already shared via README or assignments, but in a convenient form for us to look at
* make a file called projects.md in your _main_ repo directory. It should contain <200 words (plus a title of <10 words)

The assignment is due Fri 15 Mar. The project part is _really_ due Fri 15 mar

Week 8
------

Make a generalized linear model for one or more of your hypotheses. 

Discuss your results.

The assignment was due Fri 8 Mar


General
-------

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

For lots more opinions on R coding style, see [here](R_style.html)

## General principles gleaned from assignment review

### don't

- use spaces or other special characters (`&`, `#`, `$`) in file names (`_` and `.` are OK)
- leave interactive commands like `View()`, `head()`, `str()` in your code [unless commented out]
- leave `install.packages()` in your code [ditto]
- use names of built-in R objects (especially `data`, but also: `sd`, `t`, `dt`, `df`, `I`, ...) for your own variables. `fortunes::fortune(77)`

> Firstly, don't call your matrix 'matrix'. Would you call your dog 'dog'? Anyway, it might clash with the function 'matrix'. [Barry Rowlingson, R-help (October 2004)]

- include absolute path names
- include `rm(list=ls())` (see [Jenny Bryan's blog post on this topic](https://www.tidyverse.org/articles/2017/12/workflow-vs-script/)
- load your data straight from a URL (best to download and cache the file, in case your network connection is bad or the file disappears/changes)
- use "extreme tidyverse"; e.g. `dd %>% pull(x) %>% mean()` instead of `mean(dd$x)`

### do

- use `count()` instead of `group_by(..)+summarize(count=n())`, *or* use base-R `table` [which also spreads the results]: `with(your_data,table(var1,var2))`
- rename bad variable names (long, containing spaces or special characters) up front (with `dplyr::rename()`)
- use the `data=` argument whenever possible (e.g. `lm()`)
- use the `*_if()`, `*_at()`, `*_all()` versions of tidyverse functions (esp. `mutate` and `summarise`) to transform multiple columns
- use `stopifnot()` (or the `assertthat` package from the extended hadleyverse) to test conditions
- use log scales often, especially for morphometric measurements
- especially when using a linear scale, adjust units so the range can be expressed with small numbers (e.g. 1-5 instead of 1,000,000 to 5,000,000) [or use ggplot scaling/axis break stuff]
- use comma-separation to combine multiple `mutate()` steps

## MMV comments/questions

- why did your friend get tested? Was this part of a random screen or did they have a reason to be tested (which may raise the prior probability)?
- could one gather more information about your friend to either increase or decrease their prior probability (risk factors, status of relatives, etc.)?
- multiple tests *might* improve accuracy - depending on why the tests give false positives. Are multiple tests on the same person independent?

## permutation assignment

- what are good summary statistics when we want to comparing among more than two groups? (sum of squared differences among groups/between group means and overall mean; sum of abs value of differences between group median and overall median; $F$-statistic from `anova()`). See [lizards example](lizards_perm.R).

### extracting summary statistics:

```
fi_d3.aov<- aov(body_condition~Type, fi_d3)
summary(fi_d3.aov)[[1]]$`F value`[1]
## or
a2 <- anova(lm(body_condition~Type, fi_d3))
a2$`F value`[1]
```

### tibble problems:

```
mean(fi_d2[fi_d2$Type=="NM", "body_condition"])
```

works for data.frames (because of auto-collapse), but not for tibbles. Sorry!

A base R solution might be to explicitly "pull" the column first):

```
mean(fi_d2$body_condition[fi_d2$Type=="NM")
```

A tidy solution could deal with all types at once:

```
print(fi_d2
	%>% group_by(Type)
	%>% summarise(mean_cond = mean(body_condition))
)
```

This would be for viewing. To put this in an analysis pipeline, you would use pull (see [permutation examples](permutation_examples.html))
