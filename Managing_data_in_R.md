# Intro

## Goals

You should be able to

-  read data into R
- understand and control how R represents those data
    - numbers, characters, factors, missing values
- examine the data visually, numerically, textually, etc.

## Representations

Numeric and character types are fairly straightforward, and you rarely
have to worry about when and whether R represents things as integers or *floating point*.
*Very occasionally* you will need to know that R is limited in its
capacity to represent numbers of extremely large or small magnitude, and
that floating-point computations are always approximate.

You do need to know about **factors**, and to be aware when your
variables are being treated as such.

## Missing values

When you input data, you need to be aware of `NA` ("not available"). Your
read function has an option called `na.strings` which you can use to
communicate between R and your CSV files, for example. You need to know
that

- `NA==x` is always `NA`
- use `is.na()` to test for `NA` values, `na.omit()` to drop them, and the optional `na.rm` argument in some functions (`mean`, `sum`, `median` ...)

## Changing representations

R has a big suite of functions for creating, testing and changing
representations. These have names like `factor()`, `as.numeric()` and
`is.character()`.

### Factors

Factors are logically variables with a fixed number of categories. In R
they are represented as integer variables that have a "levels"
attribute. In other words, each possible value of the factor is given an
integer, and the variable carries around the code that allows
translation from this integer to its meaning.

This system has advantages:

-   You can put the levels in an appropriate order (R also has "ordered" levels, which assume this order has meaning); these govern the order in which the categories are presented when summarizing the data, plotting graphs, or printing the output of statistical models
-   You can specify the *contrasts* that R will use when building statistical models (i.e. which levels or comparisons of levels to compare)

... and disadvantages:

- It is potentially confusing
    - `as.numeric(f)` does not do the same thing as
        `as.numeric(as.character(f))`
- Similar variables can have different sets of levels

There has been [much discussion](https://stat.ethz.ch/pipermail/r-help//2012-August/321913.html) of the pros and cons of factors. You can set
`options(stringsAsFactors=FALSE)` to disable R's default behaviour of
converting character data to factors when you use `read.table()` or
`read.csv()` to read in data. The [tidyverse](http://tidyverse.org/) (more later on this) abandons automatic conversion as well.

## Examination

You should think creatively, and early on, about how to check your data.
Is it internally consistent? Are there extreme outliers? Are there
typos? Are there certain values that really mean something else?

An American Airlines memo about fuel reporting from the 1980s complained of multiple cases of:

-   Reported departure fuel greater than aircraft capacity
-   Reported departure fuel less than minimum required for trip
-   Reported arrival fuel greater than reported departure fuel
-   Difference between reported departure fuel and reported arrival fuel not within reasonable min/max bounds

You should think about what you can test, and what you can fix if it's
broken.

See [The MMED data management lecture](http://lalashan.mcmaster.ca/theobio/mmed/index.php/Introduction_to_data_management_and_cleaning).

Graphical approaches are really useful for data cleaning; we will
discuss this more later on.

What R functions do you know that are useful for examination? What are
your strategies?

## Manipulation

Even once your data are clean, there can still be a lot of work getting
it into a format you want to use. "Data manipulation", "munging", or
"wrangling" are the terms covering this activity. The RStudio folks have
a useful [cheat sheet](http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf).

This is a very, very hard, very general problem; everyone's data
problems and requirements are slightly different. But there are
recurring themes.

## Specialized data

Some data are in specialized formats, and often already cleaned. We will
mention only in passing:

-   phylogenetic trees
-   sequence data
-   maps, spatial data

## Tidy(ing) data

Hadley Wickham has defined a concept of [tidy
data](http://www.jstatsoft.org/v59/i10/paper), and has recently
introduced the `tidyr` package.

-   Each variable is in a column
-   Each observation is in a row
-   "Long" rather than "wide" form
-   Sometimes duplicates data
-   Statistical modeling tools and graphical tools (especially the
    **ggplot2** package) in R work best with long form

### Tools

#### base R

-   `reshape`: wide-to-long and vice versa
-   `merge`: join data frames
-   `ave`: compute averages by group
-   `subset`, `[`-indexing: select obs and vars
-   `transform`: modify variables and create new ones
-   `aggregate`: split-apply-summarize
-   `split`, `lapply`, `do.call(rbind())`: split-apply-combine
-   `sort`

#### The tidyverse

-   `tidyr` package: `gather`, `spread`
-   `dplyr` package:
    -   `mutate`
    -   `select`
    -   `filter`
    -   `group_by`
    -   `summarise`
    -   `arrange`

Manipulation
------------

-   [Canadian homicide rate
    example](Homicide_example.html)
-   Simple [Reshape examples](Reshape_examples.html)

