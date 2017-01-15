---
title: "Canadian homicide rates"
author: Ben Bolker
---




## Read data in wide format and play with it

Data are originally from [StatCan](http://www.statcan.gc.ca/tables-tableaux/sum-som/l01/cst01/legal12b-eng.htm) (it might be possible to *scrape* this data set using the `XML` package ...).

I also got [data on population size in 2011 from Wikipedia](http://en.wikipedia.org/wiki/List_of_Canadian_provinces_and_territories_by_population) .


```r
dat <- read.csv("CA_homicide.csv",check.names=FALSE)
```

```
## Warning in file(file, "rt"): cannot open file 'CA_homicide.csv': No such
## file or directory
```

```
## Error in file(file, "rt"): cannot open the connection
```

```r
popdat <- read.csv("popdat.csv")
```

```
## Warning in file(file, "rt"): cannot open file 'popdat.csv': No such file or
## directory
```

```
## Error in file(file, "rt"): cannot open the connection
```
We use `check.names=FALSE` to stop R from trying to sanitize the column names: this is reasonable if we plan to convert to long form and want to preserve the values (years, in this case).

These data are in wide format:

```r
head(dat)
```

```
## Error in head(dat): object 'dat' not found
```

What if we want combine other information?

```r
head(rdat <- data.frame(Place=dat$Place,
      Region=c("all",rep("Atlantic",4),
             rep("East",2),
             rep("West",4),
             rep("North",3))))
```

```
## Error in data.frame(Place = dat$Place, Region = c("all", rep("Atlantic", : object 'dat' not found
```

Let's start by converting the data to long form:

```r
library("tidyr")
library("dplyr")
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
sdat <- dat %>% gather(year,homicides,-Place,convert=TRUE)
```

```
## Error in eval(expr, envir, enclos): object 'dat' not found
```
(we use `convert=TRUE` to convert the years back to numeric values)


```r
sdat2 <- sdat %>% full_join(rdat) %>% full_join(popdat)
```

```
## Error in eval(expr, envir, enclos): object 'sdat' not found
```

If we just used the original data set (without the added stuff), it's fairly easy to get summary statistics by dropping the first row (so that we have a data frame that is all numeric) and computing means of rows and columns:

```r
dmat <- dat[,-1]
```

```
## Error in eval(expr, envir, enclos): object 'dat' not found
```

```r
rownames(dmat) <- dat[,1]
```

```
## Error in eval(expr, envir, enclos): object 'dat' not found
```

```r
rowMeans(dmat)  ## means by place
```

```
## Error in is.data.frame(x): object 'dmat' not found
```

```r
colMeans(dmat)  ## means by year
```

```
## Error in is.data.frame(x): object 'dmat' not found
```
(Don't forget the `na.rm` argument, unnecessary in this case, that can be provided to most R summary functions to get them to ignore `NA` values.)

If we want summary statistics from the full data set we can do


```r
sdat2 %>% group_by(Place) %>% summarise(mean=mean(homicides))
```

```
## Error in eval(expr, envir, enclos): object 'sdat2' not found
```

```r
sdat2 %>% group_by(year) %>% summarise(mean=mean(homicides))
```

```
## Error in eval(expr, envir, enclos): object 'sdat2' not found
```

One more useful technique is reordering factors (representing categorical variables) in a sensible way.  Right now the 'places' (provinces, territories, etc.) are ordered alphabetically, R's default.


```r
sdat3 <- sdat2 %>% mutate(Place=reorder(Place,Pop_2011))
```

```
## Error in eval(expr, envir, enclos): object 'sdat2' not found
```

I can also group by two different variables:

```r
sdat2 %>% group_by(year,Region) %>% summarise(mean=mean(homicides))
```

```
## Error in eval(expr, envir, enclos): object 'sdat2' not found
```

What if I want the mean and standard error?  R doesn't have a built-in "standard error of the mean" function so I define one on the fly:


```r
sem <- function(x) { sd(x)/sqrt(length(x))}
sdat2 %>% group_by(year,Region) %>%
    summarise(mean=mean(homicides,na.rm=TRUE),
              sem=sem(homicides))
```

```
## Error in eval(expr, envir, enclos): object 'sdat2' not found
```

What if I want to check the variables to see why they're `NA`?


```r
sdat2 %>% filter(year==2007 & Region=="all")
```

```
## Error in eval(expr, envir, enclos): object 'sdat2' not found
```

## Hadleyverse 1


```r
detach("package:dplyr")
detach("package:tidyr")
library("plyr")
```

```
## -------------------------------------------------------------------------
```

```
## You have loaded plyr after dplyr - this is likely to cause problems.
## If you need functions from both plyr and dplyr, please load plyr first, then dplyr:
## library(plyr); library(dplyr)
```

```
## -------------------------------------------------------------------------
```

We can use `merge` to combine the data (without getting tricky, we can't `merge` more than two data sets at a time)

```r
dat2 <- merge(dat,rdat)
```

```
## Error in merge(dat, rdat): object 'dat' not found
```

```r
dat3 <- merge(dat2,popdat)
```

```
## Error in merge(dat2, popdat): object 'dat2' not found
```

```r
head(dat3)
```

```
## Error in head(dat3): object 'dat3' not found
```


```r
## Long format
```

```r
library("reshape2")
```

Reshape data from wide to long ("melt"): since I added the population data, I can't rely on `melt`'s default rule (ID variables=factor variables) but have to specify `id.var` explicitly.

```r
mdat <- melt(dat3,variable.name="Year",id.var=c("Place","Region","Pop_2011"))
```

```
## Error in melt(dat3, variable.name = "Year", id.var = c("Place", "Region", : object 'dat3' not found
```
Now clean up, relabeling the value column and translating years back to a numeric variable:

```r
mdat <- rename(mdat,c(value="Hom_rate"))
```

```
## Error in revalue(names(x), replace, warn_missing = warn_missing): object 'mdat' not found
```

```r
mdat$Year <- as.numeric(as.character(mdat$Year))
```

```
## Error in eval(expr, envir, enclos): object 'mdat' not found
```

We could also have `melt`ed the original data set (without region or population data) and waited until we had the data in long format to merge the extra information: `merge` is pretty smart.

## Casting
How do we summarize the data if we have it in long format?

Mean by place (I have to be a little careful with the way I `rename`: since `(all)` is not a legal R name, I have to surround it with back-quotes):

```r
place_mean <- dcast(mdat,Place~.,
      value="Hom_rate",fun.aggregate=mean)
```

```
## Error in match(x, table, nomatch = 0L): object 'mdat' not found
```

```r
place_mean <- rename(place_mean,c(`(all)`="mean_hom"))
```

```
## Error in revalue(names(x), replace, warn_missing = warn_missing): object 'place_mean' not found
```

```r
print(place_mean)
```

```
## Error in print(place_mean): object 'place_mean' not found
```

By year:

```r
dcast(mdat,Year~.,
      value="Hom_rate",fun.aggregate=mean)
```

```
## Error in match(x, table, nomatch = 0L): object 'mdat' not found
```

By region:

```r
dcast(mdat,Region~.,
      value="Hom_rate",fun.aggregate=mean)
```

```
## Error in match(x, table, nomatch = 0L): object 'mdat' not found
```

By region *and* year:

```r
dcast(mdat,Region+Year~.,
      value="Hom_rate",fun.aggregate=mean)
```

```
## Error in match(x, table, nomatch = 0L): object 'mdat' not found
```

To get multiple summaries in the same data frame, I need `plyr::ddply`.

```r
ddply(mdat,"Region",summarise,
      mean=mean(Hom_rate),sem=sem(Hom_rate))
```

```
## Error in empty(.data): object 'mdat' not found
```

We could also cast it back into the original wide format, or into the transposed form, using `dcast(mdat,Year~Place)` or `dcast(mdat,Place~Year)`.  `reshape2` can do considerably more complicated things, too.

In the long run it is generally easier to keep your data in long format and cast it to wide as necessary.

Save the data frame we've created:


```r
save("mdat",file="CA_homicide.RData")
```

```
## Error in save("mdat", file = "CA_homicide.RData"): object 'mdat' not found
```
