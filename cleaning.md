---
title: Data management and cleaning
author: Jonathan Dushoff
date: MMED 2017
---

## Goals

* Introduce some principles of data management

* Introduce some practical, modern tools 

* Show some examples

## Data analysis

Data must be:

* Organized

* Cleaned

* Manipulated

* Analyzed

The first three often take the most time, and this is often because researchers undervalue them.

There's never time to do it right ... but there's always time to do it over!

## Structured tools for dealing with data

* dplyr
* tidyr
* readr


```r
library(tidyverse)
```

```
## Loading tidyverse: ggplot2
## Loading tidyverse: tibble
## Loading tidyverse: tidyr
## Loading tidyverse: readr
## Loading tidyverse: purrr
## Loading tidyverse: dplyr
```

```
## Conflicts with tidy packages ----------------------------------------------
```

```
## filter(): dplyr, stats
## lag():    dplyr, stats
```

## A sample data set


```r
villageTable <- read.csv("~/git/Malaria/village.csv")
```

```
## Warning in file(file, "rt"): cannot open file '/home/dushoff/git/Malaria/
## village.csv': No such file or directory
```

```
## Error in file(file, "rt"): cannot open the connection
```

```r
summary(villageTable)
```

```
## Error in summary(villageTable): object 'villageTable' not found
```
## A sample data set


```r
parasiteTable <- read.csv("~/git/Malaria/parademo.csv")
```

```
## Warning in file(file, "rt"): cannot open file '/home/dushoff/git/Malaria/
## parademo.csv': No such file or directory
```

```
## Error in file(file, "rt"): cannot open the connection
```

```r
summary(parasiteTable)
```

```
## Error in summary(parasiteTable): object 'parasiteTable' not found
```

## Entering, maintaining and using data

* These are different functions, and often call for different ways of formatting data

* This is why we have computers

## Data entry 

* Convenient for users

* Some amount of redundancy is good (to catch errors)

* Often a "wide" format (related information on the same row)

## Data use 

* Scanning for patterns and problems

* Making tables for publication

* Making data frames for statistical analysis

## Data maintenance

* Your database is
	* a logical construct
		* The core of the data that we maintain and validate
	* maybe also a software construct
		* If you are using a database program

* Data in the database is:
	* Non-redundant
	* Relational
	* "Long"

## Redundancy

You don't want any redundancy in your database (although you might for entry or analysis)

* Removing redundancies is a great way to check data integrity

* Non-redundant information can be updated conveniently
	* and without introducing new errors

## Example


```r
head(parasiteTable)
```

```
## Error in head(parasiteTable): object 'parasiteTable' not found
```

## Tidy data

* No redundancy

* Break data into separate tables following the logic of the data

* Clear "keys" to describe the information in each row
	* Non-redundant, unique identifiers
	* Village table has village (number) as the key
	* Measurement table has id, survey as the key'

## Relational

Break data into logical tables

* Information at the level where it belongs:
	* Sampling event
	* Individual
	* Household
	* Village
	* Village group

## Tidy example


```
## Warning in readChar(con, 5L, useBytes = TRUE): cannot open compressed file
## '/home/dushoff/git/Workshops/disease_model_talks/.live.RData', probable
## reason 'No such file or directory'
```

```
## Error in readChar(con, 5L, useBytes = TRUE): cannot open the connection
```


```r
print(sim)
```

```
## Error in print(sim): object 'sim' not found
```
## Gathering makes things tidy

* Use long structure to mark things that are comparable, or have the same units


```r
print(gather(sim, class, people, S:R))
```

```
## Error in is.data.frame(x): object 'sim' not found
```

## Flow

* Put input data into a tidy, relational form
	* Clean on the way
	* This is your database, whether you use database software or not

* Clean, maintain and merge data in the database

* Export files for analysis, presentation, etc.
	* You may wind up rebuilding files like the ones you started with
	* They are now quality-checked, and may also be easier to update

# Importing

## Summarize

* Check that numbers are numbers, dates are dates, etc.


```r
villageTable <- (villageTable
	%>% transform(village=as.factor(village))
)
```

```
## Error in eval(expr, envir, enclos): object 'villageTable' not found
```

```r
summary(villageTable)
```

```
## Error in summary(villageTable): object 'villageTable' not found
```

## List

* Make lists of what occurs with what (and how many times)


```r
print(villageTable
	%>% group_by(vname, vu)
	%>% summarize(count = n())
)
```

```
## Error in eval(expr, envir, enclos): object 'villageTable' not found
```

## ...

* The computer is your friend


```r
print(villageTable
	%>% group_by(vname, vu)
	%>% summarize(count = n())
	%>% filter(count>1)
)
```

```
## Error in eval(expr, envir, enclos): object 'villageTable' not found
```

## ...

* and you always want to check yourself


```r
print(villageTable
	%>% group_by(vname)
	%>% summarize(count = n())
	%>% filter(count>1)
)
```

```
## Error in eval(expr, envir, enclos): object 'villageTable' not found
```

## Making relational tables

If we had data like the parasite Table, we would want to break it into

* A table at the level of people

* A table at the level of sampling events

* A table at the level of measurements

This process leads to improved clarity, __and improved cleaning__

## Parasite table


```r
print(parasiteTable
	%>% group_by(id, village, compound)
	%>% summarize(count=n())
)
```

```
## Error in eval(expr, envir, enclos): object 'parasiteTable' not found
```


## Parasite table


```r
print(parasiteTable
	%>% group_by(id, village, compound)
	%>% summarize(count=n())
	%>% group_by(id)
	%>% summarize(count=n())
	%>% filter(count>1)
)
```

```
## Error in eval(expr, envir, enclos): object 'parasiteTable' not found
```

## Explore ranges


```r
print(ggplot(villageTable, aes(x=population))
	+ geom_histogram()
)
```

```
## Error in ggplot(villageTable, aes(x = population)): object 'villageTable' not found
```

## Explore ranges

![Population histogram](figure/pophist.R-1.png)

# Correction tables

## Mistakes
Let's say you find an obvious error in your data


```
##   country continent count
## 1   Kenya    Africa    23
## 2  Uganda    Africa    31
## 3  Ungada    Africa     1
## 4 Vietnam      Asia    16
```

How should you fix it?

## A table

A table:

* respects the original data
* records your decision
* is transparent to yourself and others
* __fixes the mistake again, if it happens again__


```
##   country patchcountry
## 1  Ungada       Uganda
```

* Make a csv with an editor or spreadsheet program

## Awkward example

* We should fix the real table, not the summary table

* But I don't have access to the real table in this case


```r
patchtab <- (ctab
	%>% left_join(cortab)
)
```

```
## Joining, by = "country"
```

```
## Warning in left_join_impl(x, y, by$x, by$y, suffix$x, suffix$y): joining
## factors with different levels, coercing to character vector
```

```r
print(patchtab)
```

```
##   country continent count patchcountry
## 1   Kenya    Africa    23         <NA>
## 2  Uganda    Africa    31         <NA>
## 3  Ungada    Africa     1       Uganda
## 4 Vietnam      Asia    16         <NA>
```

## ...


```
##   country continent count patchcountry
## 1   Kenya    Africa    23         <NA>
## 2  Uganda    Africa    31         <NA>
## 3  Ungada    Africa     1       Uganda
## 4 Vietnam      Asia    16         <NA>
```

## NA logic is scary

NA means "Something I don't know". You don't get the answers you expect if you compare things to NA:



```r
"Jonathan" == NA
```

```
## [1] NA
```

## Finish the patch, being careful



```r
ctab <- (patchtab
	%>% mutate(country=ifelse(is.na(patchcountry), country, patchcountry))
	%>% select(-patchcountry)
)
print(ctab)
```

```
##   country continent count
## 1   Kenya    Africa    23
## 2  Uganda    Africa    31
## 3       1    Africa     1
## 4 Vietnam      Asia    16
```

## Be careful-er


```r
ctab <- (patchtab
	%>% mutate(country=ifelse(is.na(patchcountry), country, 
		as.character(patchcountry)))
	%>% select(-patchcountry)
)
print(ctab)
```

```
##   country continent count
## 1   Kenya    Africa    23
## 2  Uganda    Africa    31
## 3  Uganda    Africa     1
## 4 Vietnam      Asia    16
```

* Never be afraid to break pipes up or put them back together.

## Factors

* R likes to convert characters to factors

* Factors can be useful, but they're more often weird

* Be aware of this as a possible problem

* The more you use tools the tidy family, the less this will happen

## Dictionary tables

* You might want to summarize a factor variable into categories that you define

* In this case you could use a similar table (Ungada $\to$ Uganda), but different logic
	* You only want to keep the new version
	* ... and check for cases where the original is not matched

## Making dictionaries


```
## Warning in file(file, "rt"): cannot open file '/home/dushoff/git/
## Circumcision_and_behaviour/religion_basic.ccsv': No such file or directory
```

```
## Error in file(file, "rt"): cannot open the connection
```

```
## Error in eval(expr, envir, enclos): object 'survey' not found
```
Print out all the codes for a particular variable, and see what you think of them


```r
print(survey
	%>% select(code)
	%>% distinct()
)
```

```
## Error in eval(expr, envir, enclos): object 'survey' not found
```

## Coders can be funny

```r
print(survey
	%>% select(code)
	%>% distinct()
	%>% filter(grepl("^M", code))
)
```

```
## Error in eval(expr, envir, enclos): object 'survey' not found
```

## Build a dictionary

You should start by editing the output from your previous step


```r
print(religTab)
```

```
## Error in print(religTab): object 'religTab' not found
```

## Using a dictionary

Start the same way as before.


```r
print(patchtab)
```

```
##   country continent count patchcountry
## 1   Kenya    Africa    23         <NA>
## 2  Uganda    Africa    31         <NA>
## 3  Ungada    Africa     1       Uganda
## 4 Vietnam      Asia    16         <NA>
```

## Dictionary replacement

But use different logic for replacement


```r
dtab <- (patchtab
	%>% mutate(country=patchcountry)
	%>% select(-patchcountry)
)
print(dtab)
```

```
##   country continent count
## 1    <NA>    Africa    23
## 2    <NA>    Africa    31
## 3  Uganda    Africa     1
## 4    <NA>      Asia    16
```

## Play with your data

* Don't touch the original data
* Make scripts and make sure that they are replicable
* Don't be afraid to play, experiment, probe
* You want to like your data-manipulation tools, and get your data as clean as possible

## Summary

* Let the computer serve you
	* Input in the form that you want to input
	* Manage in the tidy form that is efficient and logical
	* Output in the way you want to output

* Be aggressive about exploring, questioning and cleaning
