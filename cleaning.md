---
title: Data management and cleaning
author: Jonathan Dushoff
date: QMEE 2019
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
## ── Attaching packages ────────────────────────────────── tidyverse 1.2.1 ──
```

```
## ✔ ggplot2 3.1.0     ✔ purrr   0.2.5
## ✔ tibble  1.4.2     ✔ dplyr   0.7.6
## ✔ tidyr   0.8.1     ✔ stringr 1.3.1
## ✔ readr   1.1.1     ✔ forcats 0.3.0
```

```
## ── Conflicts ───────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
```

## A sample data set


```r
villageTable <- read_csv("~/gitroot/malariaImmunity/garki_data/village.csv")
```

```
## Parsed with column specification:
## cols(
##   area = col_character(),
##   village = col_integer(),
##   grid = col_character(),
##   fup = col_integer(),
##   vname = col_character(),
##   vu = col_character(),
##   grouped1 = col_integer(),
##   grouped2 = col_integer(),
##   scattered1 = col_integer(),
##   scattered2 = col_integer(),
##   population = col_integer()
## )
```

## A sample data set


```r
summary(villageTable)
```

```
##      area              village          grid                fup        
##  Length:180         Min.   :  1.0   Length:180         Min.   : 1.000  
##  Class :character   1st Qu.:211.2   Class :character   1st Qu.: 3.000  
##  Mode  :character   Median :362.5   Mode  :character   Median : 6.000  
##                     Mean   :402.0                      Mean   : 6.217  
##                     3rd Qu.:565.2                      3rd Qu.: 7.000  
##                     Max.   :967.0                      Max.   :92.000  
##     vname                vu               grouped1         grouped2      
##  Length:180         Length:180         Min.   :  0.00   Min.   : 0.0000  
##  Class :character   Class :character   1st Qu.:  0.00   1st Qu.: 0.0000  
##  Mode  :character   Mode  :character   Median : 24.50   Median : 0.0000  
##                                        Mean   : 37.06   Mean   : 0.7833  
##                                        3rd Qu.: 52.25   3rd Qu.: 1.0000  
##                                        Max.   :550.00   Max.   :10.0000  
##    scattered1       scattered2        population    
##  Min.   :  0.00   Min.   :0.00000   Min.   :   0.0  
##  1st Qu.:  0.00   1st Qu.:0.00000   1st Qu.: 124.0  
##  Median :  6.00   Median :0.00000   Median : 222.0  
##  Mean   : 14.29   Mean   :0.01111   Mean   : 287.1  
##  3rd Qu.: 22.00   3rd Qu.:0.00000   3rd Qu.: 375.0  
##  Max.   :117.00   Max.   :1.00000   Max.   :2556.0
```

## A sample data set


```r
parasiteTable <- read_csv("~/gitroot/malariaImmunity/garki_data/parademo.csv")
```

```
## Parsed with column specification:
## cols(
##   .default = col_integer(),
##   datecoll = col_date(format = ""),
##   datep = col_date(format = ""),
##   dateexam = col_date(format = "")
## )
```

```
## See spec(...) for full column specifications.
```

```
## Warning in rbind(names(probs), probs_f): number of columns of result is not
## a multiple of vector length (arg 1)
```

```
## Warning: 58129 parsing failures.
## row # A tibble: 5 x 5 col     row col      expected   actual   file                                  expected   <int> <chr>    <chr>      <chr>    <chr>                                 actual 1    96 datep    valid date 0000-00… '~/gitroot/malariaImmunity/garki_dat… file 2    96 dateexam valid date 0000-00… '~/gitroot/malariaImmunity/garki_dat… row 3   108 datep    valid date 0000-00… '~/gitroot/malariaImmunity/garki_dat… col 4   108 dateexam valid date 0000-00… '~/gitroot/malariaImmunity/garki_dat… expected 5   119 datep    valid date 0000-00… '~/gitroot/malariaImmunity/garki_dat…
## ... ................. ... .......................................................................... ........ .......................................................................... ...... .......................................................................... .... .......................................................................... ... .......................................................................... ... .......................................................................... ........ ..........................................................................
## See problems(...) for more details.
```

## A sample data set


```r
summary(parasiteTable)
```

```
##        id           village         compound       survey     
##  Min.   :    1   Min.   : 51.0   Min.   :  1   Min.   : 1.00  
##  1st Qu.: 2671   1st Qu.:202.0   1st Qu.: 40   1st Qu.: 6.00  
##  Median : 6186   Median :220.0   Median :205   Median :10.00  
##  Mean   : 5980   Mean   :337.3   Mean   :176   Mean   :10.61  
##  3rd Qu.: 8993   3rd Qu.:552.0   3rd Qu.:249   3rd Qu.:15.00  
##  Max.   :12849   Max.   :806.0   Max.   :949   Max.   :23.00  
##                                                               
##      person            sch             _add           tribe        
##  Min.   : 1.000   Min.   :0.000   Min.   :1.000   Min.   :0.00000  
##  1st Qu.: 2.000   1st Qu.:1.000   1st Qu.:2.000   1st Qu.:0.00000  
##  Median : 5.000   Median :1.000   Median :2.000   Median :0.00000  
##  Mean   : 6.745   Mean   :1.189   Mean   :1.906   Mean   :0.08756  
##  3rd Qu.: 9.000   3rd Qu.:1.000   3rd Qu.:2.000   3rd Qu.:0.00000  
##  Max.   :99.000   Max.   :5.000   Max.   :2.000   Max.   :3.00000  
##                                                                    
##       hght            sleep             dist               baby      
##  Min.   :  0.00   Min.   :0.0000   Min.   :0.00e+00   Min.   :0.000  
##  1st Qu.:  0.00   1st Qu.:1.0000   1st Qu.:0.00e+00   1st Qu.:2.000  
##  Median :  0.00   Median :1.0000   Median :0.00e+00   Median :2.000  
##  Mean   : 15.33   Mean   :0.7863   Mean   :7.96e-05   Mean   :1.714  
##  3rd Qu.:  0.00   3rd Qu.:1.0000   3rd Qu.:0.00e+00   3rd Qu.:2.000  
##  Max.   :985.00   Max.   :2.0000   Max.   :2.00e+00   Max.   :2.000  
##                                                                      
##      alive             datecoll               coll         
##  Min.   :0.000000   Min.   :1970-10-26   Min.   :       0  
##  1st Qu.:0.000000   1st Qu.:1971-12-01   1st Qu.:       1  
##  Median :0.000000   Median :1972-10-11   Median :       1  
##  Mean   :0.005442   Mean   :1972-11-26   Mean   :     138  
##  3rd Qu.:0.000000   3rd Qu.:1973-08-29   3rd Qu.:       1  
##  Max.   :2.000000   Max.   :1976-12-10   Max.   :19000000  
##                     NA's   :7                              
##      sliden            car1           ncar1               car2      
##  Min.   :     0   Min.   :0.000   Min.   :    0.00   Min.   :0.000  
##  1st Qu.: 14967   1st Qu.:1.000   1st Qu.:    0.00   1st Qu.:1.000  
##  Median : 47182   Median :3.000   Median :    0.00   Median :3.000  
##  Mean   : 49504   Mean   :2.263   Mean   :   85.08   Mean   :2.298  
##  3rd Qu.: 81473   3rd Qu.:3.000   3rd Qu.:    0.00   3rd Qu.:3.000  
##  Max.   :117927   Max.   :3.000   Max.   :30000.00   Max.   :3.000  
##                                                                     
##      ncar2               filt           nfilt             fever      
##  Min.   :   0.000   Min.   :0.000   Min.   :0.0e+00   Min.   :0.000  
##  1st Qu.:   0.000   1st Qu.:1.000   1st Qu.:0.0e+00   1st Qu.:2.000  
##  Median :   0.000   Median :3.000   Median :0.0e+00   Median :2.000  
##  Mean   :   1.888   Mean   :2.279   Mean   :7.3e-02   Mean   :1.694  
##  3rd Qu.:   0.000   3rd Qu.:3.000   3rd Qu.:0.0e+00   3rd Qu.:2.000  
##  Max.   :4200.000   Max.   :3.000   Max.   :1.0e+04   Max.   :2.000  
##                                                                      
##      datep                micro           dateexam         
##  Min.   :1970-10-26   Min.   : 0.000   Min.   :1970-01-11  
##  1st Qu.:1971-11-16   1st Qu.: 5.000   1st Qu.:1971-09-29  
##  Median :1972-09-21   Median : 7.000   Median :1972-07-07  
##  Mean   :1972-11-13   Mean   : 7.226   Mean   :1972-07-03  
##  3rd Qu.:1973-08-16   3rd Qu.:10.000   3rd Qu.:1973-04-02  
##  Max.   :1976-01-31   Max.   :90.000   Max.   :1976-05-06  
##  NA's   :19703                         NA's   :38419       
##      slide             exam            pfa              pfg          
##  Min.   :     0   Min.   :  0.0   Min.   :  0.00   Min.   :  0.0000  
##  1st Qu.: 14967   1st Qu.:200.0   1st Qu.:  0.00   1st Qu.:  0.0000  
##  Median : 47182   Median :200.0   Median :  0.00   Median :  0.0000  
##  Mean   : 49504   Mean   :198.3   Mean   : 16.05   Mean   :  0.5428  
##  3rd Qu.: 81473   3rd Qu.:200.0   3rd Qu.:  3.00   3rd Qu.:  0.0000  
##  Max.   :117927   Max.   :462.0   Max.   :449.00   Max.   :392.0000  
##                                                                      
##        pm                po                ppfa             ppfg        
##  Min.   :  0.000   Min.   :  0.0000   Min.   :0.0000   Min.   :0.00000  
##  1st Qu.:  0.000   1st Qu.:  0.0000   1st Qu.:0.0000   1st Qu.:0.00000  
##  Median :  0.000   Median :  0.0000   Median :0.0000   Median :0.00000  
##  Mean   :  1.442   Mean   :  0.1589   Mean   :0.2982   Mean   :0.08759  
##  3rd Qu.:  0.000   3rd Qu.:  0.0000   3rd Qu.:1.0000   3rd Qu.:0.00000  
##  Max.   :400.000   Max.   :396.0000   Max.   :1.0000   Max.   :1.00000  
##                                                                         
##       ppm               ppo                 pf             smove        
##  Min.   :0.00000   Min.   :0.000000   Min.   :  0.00   Min.   :0.00000  
##  1st Qu.:0.00000   1st Qu.:0.000000   1st Qu.:  0.00   1st Qu.:0.00000  
##  Median :0.00000   Median :0.000000   Median :  0.00   Median :0.00000  
##  Mean   :0.09235   Mean   :0.009935   Mean   : 16.38   Mean   :0.00657  
##  3rd Qu.:0.00000   3rd Qu.:0.000000   3rd Qu.:  3.00   3rd Qu.:0.00000  
##  Max.   :1.00000   Max.   :1.000000   Max.   :449.00   Max.   :1.00000  
##                                                                         
##       agec        
##  Min.   :0.00000  
##  1st Qu.:0.00000  
##  Median :0.00000  
##  Mean   :0.00419  
##  3rd Qu.:0.00000  
##  Max.   :7.00000  
## 
```

## Entering, maintaining and using data

* These are different functions, and often call for different ways of formatting data

* This is why we have computers

## Data entry 

* Convenient for users

* Some amount of redundancy is good (to catch errors)
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
	* Often in a "long" format (to signal values that are comparable)

## Redundancy

You don't want any redundancy in your database (although you might for entry or analysis)

* Removing redundancies is a great way to check data integrity

* Non-redundant information can be updated conveniently
	* and without introducing new errors
	* and without introducing inconsistencies

## Example


```r
head(parasiteTable)
```

```
## # A tibble: 6 x 39
##      id village compound survey person   sch `_add` tribe  hght sleep  dist
##   <int>   <int>    <int>  <int>  <int> <int>  <int> <int> <int> <int> <int>
## 1     1     801      401      1      1     1      1     1     0     1     0
## 2     1     801      401      2      1     1      2     0     0     1     0
## 3     1     801      401      3      1     1      2     0     0     1     0
## 4     1     801      401      4      1     1      2     0     0     1     0
## 5     1     801      401      5      1     1      2     0     0     1     0
## 6     1     801      401      6      1     1      2     0     0     1     0
## # ... with 28 more variables: baby <int>, alive <int>, datecoll <date>,
## #   coll <int>, sliden <int>, car1 <int>, ncar1 <int>, car2 <int>,
## #   ncar2 <int>, filt <int>, nfilt <int>, fever <int>, datep <date>,
## #   micro <int>, dateexam <date>, slide <int>, exam <int>, pfa <int>,
## #   pfg <int>, pm <int>, po <int>, ppfa <int>, ppfg <int>, ppm <int>,
## #   ppo <int>, pf <int>, smove <int>, agec <int>
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




```r
print(sim)
```

```
## # A tibble: 1,001 x 4
##     time       S     I       R
##    <dbl>   <dbl> <dbl>   <dbl>
##  1   0   390000   100  389900 
##  2   0.1 389991   108  389901 
##  3   0.2 389981.  117. 389902.
##  4   0.3 389971.  126. 389903.
##  5   0.4 389959.  136. 389905.
##  6   0.5 389947.  147. 389906.
##  7   0.6 389934.  159. 389907.
##  8   0.7 389920.  171. 389909.
##  9   0.8 389904.  185. 389911.
## 10   0.9 389888.  200. 389912.
## # ... with 991 more rows
```

## Gathering makes things tidy

* Use long structure to mark things that are comparable, or have the same units


```r
longsim <-  gather(sim, class, people, S:R)
print(longsim)
```

```
## # A tibble: 3,003 x 3
##     time class  people
##    <dbl> <chr>   <dbl>
##  1   0   S     390000 
##  2   0.1 S     389991 
##  3   0.2 S     389981.
##  4   0.3 S     389971.
##  5   0.4 S     389959.
##  6   0.5 S     389947.
##  7   0.6 S     389934.
##  8   0.7 S     389920.
##  9   0.8 S     389904.
## 10   0.9 S     389888.
## # ... with 2,993 more rows
```

## Spreading can make things more human-readable


```r
print(spread(longsim, class, people))
```

```
## # A tibble: 1,001 x 4
##     time     I       R       S
##    <dbl> <dbl>   <dbl>   <dbl>
##  1   0    100  389900  390000 
##  2   0.1  108  389901  389991 
##  3   0.2  117. 389902. 389981.
##  4   0.3  126. 389903. 389971.
##  5   0.4  136. 389905. 389959.
##  6   0.5  147. 389906. 389947.
##  7   0.6  159. 389907. 389934.
##  8   0.7  171. 389909. 389920.
##  9   0.8  185. 389911. 389904.
## 10   0.9  200. 389912. 389888.
## # ... with 991 more rows
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
	%>% mutate(village=as.factor(village))
)
summary(villageTable)
```

```
##      area              village        grid                fup        
##  Length:180         1      :  1   Length:180         Min.   : 1.000  
##  Class :character   2      :  1   Class :character   1st Qu.: 3.000  
##  Mode  :character   3      :  1   Mode  :character   Median : 6.000  
##                     4      :  1                      Mean   : 6.217  
##                     5      :  1                      3rd Qu.: 7.000  
##                     6      :  1                      Max.   :92.000  
##                     (Other):174                                      
##     vname                vu               grouped1         grouped2      
##  Length:180         Length:180         Min.   :  0.00   Min.   : 0.0000  
##  Class :character   Class :character   1st Qu.:  0.00   1st Qu.: 0.0000  
##  Mode  :character   Mode  :character   Median : 24.50   Median : 0.0000  
##                                        Mean   : 37.06   Mean   : 0.7833  
##                                        3rd Qu.: 52.25   3rd Qu.: 1.0000  
##                                        Max.   :550.00   Max.   :10.0000  
##                                                                          
##    scattered1       scattered2        population    
##  Min.   :  0.00   Min.   :0.00000   Min.   :   0.0  
##  1st Qu.:  0.00   1st Qu.:0.00000   1st Qu.: 124.0  
##  Median :  6.00   Median :0.00000   Median : 222.0  
##  Mean   : 14.29   Mean   :0.01111   Mean   : 287.1  
##  3rd Qu.: 22.00   3rd Qu.:0.00000   3rd Qu.: 375.0  
##  Max.   :117.00   Max.   :1.00000   Max.   :2556.0  
## 
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
## # A tibble: 180 x 3
## # Groups:   vname [?]
##    vname           vu    count
##    <chr>           <chr> <int>
##  1 Adinis Fulanin  Kar       1
##  2 Aduwa           Aju       1
##  3 Ajura           Aju       1
##  4 Anju            Dok       1
##  5 Arindi          Sug       1
##  6 Asayaya         Kit       1
##  7 Ba'wa           Dok       1
##  8 Bakan Sabara    Kar       1
##  9 Bakan Sabara II Kar       1
## 10 Balalashi       Dok       1
## # ... with 170 more rows
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
## # A tibble: 0 x 3
## # Groups:   vname [0]
## # ... with 3 variables: vname <chr>, vu <chr>, count <int>
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
## # A tibble: 2 x 2
##   vname      count
##   <chr>      <int>
## 1 Daurawa        2
## 2 Sabon Gari     2
```

## Making relational tables

If we had data like the ```parasiteTable```, we would want to break it into

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
## # A tibble: 13,656 x 4
## # Groups:   id, village [?]
##       id village compound count
##    <int>   <int>    <int> <int>
##  1     1     801      401    16
##  2     2     801      401    16
##  3     3     801      401    16
##  4     4     801      401    16
##  5     5     801      401    16
##  6     6     801      401    16
##  7     7     801      401    12
##  8     8     801      401    11
##  9     9     801      401    15
## 10     9     801      417     1
## # ... with 13,646 more rows
```


## Parasite table


```r
print(parasiteTable
	%>% group_by(id, village, compound)
	%>% summarize(count=n())
	%>% group_by(id)
	%>% summarize(count=n())
	%>% filter(count>1)
	%>% arrange(desc(count))
)
```

```
## # A tibble: 756 x 2
##       id count
##    <int> <int>
##  1  6571     4
##  2  6572     4
##  3  6573     4
##  4  6574     4
##  5  6575     4
##  6  6576     4
##  7  6577     4
##  8  6578     4
##  9    41     3
## 10  1081     3
## # ... with 746 more rows
```

## Explore ranges


```r
print(ggplot(villageTable, aes(x=population))
	+ geom_histogram()
)
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

![plot of chunk pophist.R](figure/pophist.R-1.png)

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

## Patching

* Fix the problem as far "upstream" as possible

* Not the count table (as I'm doing here)


```r
patchTab <- (ctab
	%>% left_join(cortab)
)
```

```
## Joining, by = "country"
```

```
## Warning: Column `country` joining factors with different levels, coercing
## to character vector
```

```r
print(patchTab)
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
ctab <- (patchTab
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
ctab <- (patchTab
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

* The more you use tools from the tidy family, the less this will happen

## Dictionary tables

* You might want to summarize a factor variable into categories that you define

* In this case you could use a similar table (Ungada $\to$ Uganda), but different logic
	* You only want to keep the new version
	* ... and check for cases where the original is not matched

## Making dictionaries


Print out all the codes for a particular variable, and see what you think of them


```r
print(religTab
	%>% select(code)
	%>% distinct()
)
```

```
## # A tibble: 62 x 1
##    code           
##    <chr>          
##  1 Catholic       
##  2 Orthodox       
##  3 Roman catholic 
##  4 Adventist      
##  5 Anglican       
##  6 Anglican Church
##  7 Apostolic Sect 
##  8 Aventist       
##  9 CCAP           
## 10 Charismatic    
## # ... with 52 more rows
```

## Coders can be funny

```r
print(religTab
	%>% select(code)
	%>% distinct()
	%>% filter(grepl("^M", code))
)
```

```
## # A tibble: 9 x 1
##   code      
##   <chr>     
## 1 Methodist 
## 2 Moslem    
## 3 Muslem    
## 4 Mulsim    
## 5 Muslim    
## 6 Muslum    
## 7 Musualmane
## 8 Mana      
## 9 Mungu
```

## Build a dictionary

You should start by editing the output from your previous step


```r
print(religTab)
```

```
## # A tibble: 62 x 2
##    category          code           
##    <chr>             <chr>          
##  1 Catholic/Orthodox Catholic       
##  2 Catholic/Orthodox Orthodox       
##  3 Catholic/Orthodox Roman catholic 
##  4 Christian         Adventist      
##  5 Christian         Anglican       
##  6 Christian         Anglican Church
##  7 Christian         Apostolic Sect 
##  8 Christian         Aventist       
##  9 Christian         CCAP           
## 10 Christian         Charismatic    
## # ... with 52 more rows
```

## Using a dictionary

Start the same way as before.


```
##         person       religion
## 1 Ntombikayise         Mulsim
## 2    Gao Zhong       Anglican
## 3      Mafalda         Angler
## 4         Bill Roman catholic
```


```r
patchTab <- (churchTab
	%>% left_join(religTab, by=c("religion"="code"))
) %>% print()
```

```
## Warning: Column `religion`/`code` joining factor and character vector,
## coercing into character vector
```

```
##         person       religion          category
## 1 Ntombikayise         Mulsim            Muslim
## 2    Gao Zhong       Anglican         Christian
## 3      Mafalda         Angler              <NA>
## 4         Bill Roman catholic Catholic/Orthodox
```

### ...


```
##         person       religion          category
## 1 Ntombikayise         Mulsim            Muslim
## 2    Gao Zhong       Anglican         Christian
## 3      Mafalda         Angler              <NA>
## 4         Bill Roman catholic Catholic/Orthodox
```

## Dictionary replacement

But use different logic for replacement


```r
catTab <- (patchTab
	%>% mutate(religion=category)
	%>% select(-category)
) %>% print()
```

```
##         person          religion
## 1 Ntombikayise            Muslim
## 2    Gao Zhong         Christian
## 3      Mafalda              <NA>
## 4         Bill Catholic/Orthodox
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
