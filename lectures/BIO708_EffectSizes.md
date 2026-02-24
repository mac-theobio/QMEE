---
title: "Effect sizes"
author: "Ian Dworkin"
date: "03 Feb 2026"
output:
  html_document:
    toc: yes
    number_sections: yes
    keep_md: yes
  pdf_document:
    toc: yes
editor_options:
  chunk_output_type: console
---



# Thinking about effect sizes.


## Introduction

For most of the tutorial we are going to stick to the two group type evaluation (i.e. extending on a "t-test" like scenario), but focusing on estimating meaningful effect sizes.


## loading libraries.

### PLEASE NOTE the dabestr library seems to have a bug

Temporary fix (thanks Ben)

Install (just once) using the line below (uncomment it)

``` r
#remotes::install_github("bbolker/dabestr", ref="unpaired_unbalanced")
```



``` r
library(dabestr)
```

```
## 
## Attaching package: 'dabestr'
```

```
## The following object is masked from 'package:base':
## 
##     load
```

If you have not installed these before, you may need to do first (you only need to install them once).


``` r
library(effectsize)
```

```
## 
## Attaching package: 'effectsize'
```

```
## The following objects are masked from 'package:dabestr':
## 
##     cliffs_delta, cohens_d, cohens_h, hedges_g
```

``` r
library(emmeans)
```

```
## Welcome to emmeans.
## Caution: You lose important information if you filter this package's results.
## See '? untidy'
```

``` r
library(ggplot2)
library(ggbeeswarm)
```

We are using some new R libraries today. Both [effectsize](https://easystats.github.io/effectsize/)
 and [dabestr](https://www.estimationstats.com/#/) (also see [here](https://github.com/ACCLAB/dabestr)) that will help with making the estimates and the plotting. As we get to some more advanced models, some of the tools in [ggstatsplot](https://indrajeetpatil.github.io/ggstatsplot/) will help. Eventually we will also use both the effects library and emmeans library for complex models.
 


## functions we will use in todays class

A nice set of outputs from a linear model

``` r
lm_out <- function(x = modname) {
    cbind(as.matrix(summary(x)$coef[,1:3]),
          as.matrix(confint(x)) )}
```

## Back to our favourite data


``` r
sct_data  <- read.csv("http://beaconcourse.pbworks.com/f/dll.csv",
                       h = T, stringsAsFactors = TRUE)

sct_data <- na.omit(sct_data)
```


Today we are going to work with a subset of the data so we can focus on some of the questions. Specifically only with the flies reared at 25C from a single strain (line). This will result in a pretty modest sample size within each group, but useful for our purposes.


``` r
str(sct_data)
```

```
## 'data.frame':	1918 obs. of  8 variables:
##  $ replicate: int  1 1 1 1 1 1 1 1 1 1 ...
##  $ line     : Factor w/ 27 levels "line-1","line-11",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ genotype : Factor w/ 2 levels "Dll","wt": 1 1 1 1 1 1 1 1 1 1 ...
##  $ temp     : int  25 25 25 25 25 25 25 25 25 25 ...
##  $ femur    : num  0.59 0.55 0.588 0.596 0.577 ...
##  $ tibia    : num  0.499 0.501 0.488 0.502 0.499 ...
##  $ tarsus   : num  0.219 0.214 0.211 0.207 0.207 ...
##  $ SCT      : int  9 13 11 12 14 11 12 10 12 13 ...
##  - attr(*, "na.action")= 'omit' Named int [1:55] 4 61 73 92 93 142 207 268 315 319 ...
##   ..- attr(*, "names")= chr [1:55] "4" "61" "73" "92" ...
```

``` r
with(sct_data, table( line, genotype, temp))
```

```
## , , temp = 25
## 
##            genotype
## line        Dll wt
##   line-1     19 36
##   line-11    16 22
##   line-12    20 21
##   line-13    15 19
##   line-15    18 20
##   line-16    11 19
##   line-17    10 19
##   line-18    21 22
##   line-19     4 19
##   line-2     20 38
##   line-20    17 20
##   line-21    20 20
##   line-22    14 19
##   line-23     8 20
##   line-24     0 20
##   line-26    17 20
##   line-27    20 20
##   line-3     20 24
##   line-4     32 38
##   line-6      4 17
##   line-7     40 44
##   line-8     30 43
##   line-9     16 15
##   line-CanS   0  0
##   line-OreR  12 20
##   line-Sam    0  0
##   line-w      8 19
## 
## , , temp = 30
## 
##            genotype
## line        Dll wt
##   line-1      8 21
##   line-11    28 31
##   line-12    20 14
##   line-13     6 21
##   line-15    14 16
##   line-16    17 18
##   line-17    20 18
##   line-18    38 38
##   line-19    20 20
##   line-2     20 22
##   line-20    22 19
##   line-21    21 18
##   line-22    20 25
##   line-23    20 20
##   line-24     4 16
##   line-26     0  0
##   line-27    18 22
##   line-3      6  5
##   line-4     21 19
##   line-6     11 14
##   line-7     22 21
##   line-8     17 18
##   line-9      6  3
##   line-CanS   8  4
##   line-OreR  17 20
##   line-Sam   17 21
##   line-w      8 19
```

``` r
sct_dat_subset <- sct_data[sct_data$temp == 25 & sct_data$line == "line-7",]

sct_dat_subset <- droplevels(sct_dat_subset)

dim(sct_dat_subset)
```

```
## [1] 84  8
```

``` r
with(sct_dat_subset, 
     table(genotype))
```

```
## genotype
## Dll  wt 
##  40  44
```

``` r
sct_dat_subset$genotype <- relevel(sct_dat_subset$genotype, "wt") # explain in class
```


## quick plot of the data


``` r
ggplot(sct_dat_subset, aes(y = SCT, x = genotype, color = genotype)) +
  geom_quasirandom(dodge.width = 0.25, cex = 2, alpha = 0.8)
```

![](BIO708_EffectSizes_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

``` r
ggplot(sct_dat_subset, aes(y = tarsus, x = genotype, color = genotype)) +
  geom_quasirandom(dodge.width = 0.25, cex = 2, alpha = 0.8)
```

![](BIO708_EffectSizes_files/figure-html/unnamed-chunk-7-2.png)<!-- -->



## t-tests

1. Run t-tests to compare differences between genotypes for the two response variables (SCT and tarsus). Anything that seems pretty important that is missing when you print out the results (`print`)



``` r
sct_t_test <- t.test(SCT ~ genotype, 
                    alternative = "two.sided",
                    data = sct_dat_subset)


print(sct_t_test)
```

```
## 
## 	Welch Two Sample t-test
## 
## data:  SCT by genotype
## t = -7, df = 73, p-value = 3e-09
## alternative hypothesis: true difference in means between group wt and group Dll is not equal to 0
## 95 percent confidence interval:
##  -2.41 -1.31
## sample estimates:
##  mean in group wt mean in group Dll 
##              10.8              12.7
```

``` r
tarsus_t_test <- t.test(tarsus ~ genotype, 
                    alternative = "two.sided",
                    data = sct_dat_subset)

print(tarsus_t_test)
```

```
## 
## 	Welch Two Sample t-test
## 
## data:  tarsus by genotype
## t = -2, df = 81, p-value = 0.03
## alternative hypothesis: true difference in means between group wt and group Dll is not equal to 0
## 95 percent confidence interval:
##  -0.011081 -0.000593
## sample estimates:
##  mean in group wt mean in group Dll 
##             0.196             0.202
```

2. Do you know what "kind" of t-test this is (in terms of the samples)?



3. Figure out how to extract just the t-statistic and degrees of freedom from this object. Indeed, if you can, write a little function to extract the t-statistic, df, confidence intervals, estimate and standard error only.



``` r
t_useful_bits <- function(t_object) {
  return(c( 
           t_object$estimate,
           difference = as.numeric(diff(t_object$estimate)),
           SE = t_object$stderr,
           CI = t_object$conf.int[1:2],
           t_object$statistic, 
           t_object$parameter))}
```




``` r
t_useful_bits(sct_t_test)
```

```
##  mean in group wt mean in group Dll        difference                SE 
##            10.818            12.675             1.857             0.276 
##               CI1               CI2                 t                df 
##            -2.406            -1.308            -6.738            73.255
```

``` r
t_useful_bits(tarsus_t_test)
```

```
##  mean in group wt mean in group Dll        difference                SE 
##          0.195791          0.201628          0.005837          0.002636 
##               CI1               CI2                 t                df 
##         -0.011081         -0.000593         -2.214473         81.248269
```

4. Repeat this, but using the lm function. What do each of the coefficients (`coef`) mean in each model? How does it compare to the t-tests.


``` r
sct_mod1 <- lm(SCT ~ genotype, 
               data = sct_dat_subset)

tarsus_mod1 <- lm(tarsus ~ genotype, 
               data = sct_dat_subset)

coef(sct_mod1)
```

```
## (Intercept) genotypeDll 
##       10.82        1.86
```

``` r
coef(tarsus_mod1)
```

```
## (Intercept) genotypeDll 
##     0.19579     0.00584
```


5. Instead of running `summary` on the model object, use the `lm_out` function I wrote above. What is the difference? Why did I do this?


``` r
lm_out(sct_mod1)
```

```
##             Estimate Std. Error t value 2.5 % 97.5 %
## (Intercept)    10.82      0.188   57.59 10.44   11.2
## genotypeDll     1.86      0.272    6.82  1.32    2.4
```

``` r
lm_out(tarsus_mod1)
```

```
##             Estimate Std. Error t value    2.5 % 97.5 %
## (Intercept)  0.19579    0.00182  107.64 0.192172 0.1994
## genotypeDll  0.00584    0.00264    2.21 0.000593 0.0111
```


## How does this help us?

We have compares the effects of genotype on two traits? But how do we know which (if any) is having a big effect or a small effect? One is in count of bristles, one in length in mm. So it is pretty hard to compare. So perhaps a use of standardized effect sizes may be useful.


## Effect sizes

We will compute a few of the effect sizes we discussed in lecture. We are going to use the functions in the `effectsize` library for this.

For simple experimental designs the `effectsize` library is generally a more useful choice than `dabestr` (but does not use bootstrapped CIs or makes pretty plots). Indeed it has many many options. One somewhat odd thing is that for `glass_delta` (where we used the standard deviation of the "control" group), it is the second group that is used for the standard deviation so we need to switch the releveling. Slight differences between the two libraries in values is because of some bias correction that I think is applied.

Again, all of this (how we are scaling our differences) would be determined *a priori*. For this tutorial I am just showing you how to do it.

We will focus on *Hedges' g* as it is the "sample size corrected" version of *Cohen's D*.

``` r
sct_dat_subset$genotype_rev <- relevel(sct_dat_subset$genotype, "Dll")

hedges_g(SCT ~ genotype_rev, data = sct_dat_subset)
```

```
## Hedges' g |       95% CI
## ------------------------
## 1.48      | [0.99, 1.95]
## 
## - Estimated using pooled SD.
```

``` r
hedges_g(tarsus ~ genotype_rev, data = sct_dat_subset)
```

```
## Hedges' g |       95% CI
## ------------------------
## 0.48      | [0.05, 0.91]
## 
## - Estimated using pooled SD.
```
We will discuss below how this helps us to compare the influence of genotype on these two very different types of traits.


We can also compute regular *Cohen's d* or *Glass's delta* (SD of control group is used for scaling)

``` r
cohens_d(SCT ~ genotype_rev, data = sct_dat_subset)
```

```
## Cohen's d |       95% CI
## ------------------------
## 1.49      | [1.00, 1.97]
## 
## - Estimated using pooled SD.
```

``` r
cohens_d(tarsus ~ genotype_rev, data = sct_dat_subset)
```

```
## Cohen's d |       95% CI
## ------------------------
## 0.48      | [0.05, 0.92]
## 
## - Estimated using pooled SD.
```

``` r
glass_delta(SCT ~ genotype_rev, data = sct_dat_subset)
```

```
## Glass' delta (adj.) |       95% CI
## ----------------------------------
## 1.68                | [1.07, 2.28]
```

``` r
glass_delta(tarsus ~ genotype_rev, data = sct_dat_subset)
```

```
## Glass' delta (adj.) |       95% CI
## ----------------------------------
## 0.48                | [0.04, 0.90]
```


## Gardner-Altman estimation plots

Let's first use [dabestr](https://www.estimationstats.com) to compute the differences and then use a [Garnder-Altman estimation plot](https://en.wikipedia.org/wiki/Estimation_statistics#Gardner-Altman_plot) from [Gardner and Altman 1986](https://www.bmj.com/content/bmj/292/6522/746.full.pdf) (British Medical Journal 292:746).



``` r
dim(sct_dat_subset)
```

```
## [1] 84  9
```

``` r
# needs a tibble
sct_dat_subset_tb <- tibble::tibble(sct_dat_subset)

diff_SCT <- load(data = sct_dat_subset_tb, 
                               x = genotype, y = SCT,
                             idx = c("wt", "Dll")) 

mean_diff_SCT <- mean_diff(diff_SCT) # get mean difference

mean_diff_SCT
```

```
## DABESTR v2025.3.15
## ==================
## 
## Good morning!
## The current time is 11:13 AM on Tuesday February 03, 2026.
## 
## The character(0) mean difference between Dll and wt is 1.857 [95%CI 1.325, 2.393].
## The p-value of the two-sided permutation t-test is 0.0000, calculated for legacy purposes only.
## 
## 5000 bootstrap samples were taken; the confidence interval is bias-corrected and accelerated.
## Any p-value reported is the probability of observing the effect size (or greater),
## assuming the null hypothesis of zero difference is true.
## For each p-value, 5000 reshuffles of the control and test labels were performed.
```

``` r
dabest_plot(mean_diff_SCT)
```

![](BIO708_EffectSizes_files/figure-html/unnamed-chunk-15-1.png)<!-- -->



``` r
diff_tarsus <- load(data = sct_dat_subset_tb, 
                               x = genotype, y = tarsus,
                             idx = c("wt", "Dll")) 

mean_diff_tarsus <- mean_diff(diff_tarsus) # get mean difference

mean_diff_tarsus
```

```
## DABESTR v2025.3.15
## ==================
## 
## Good morning!
## The current time is 11:13 AM on Tuesday February 03, 2026.
## 
## The character(0) mean difference between Dll and wt is 0.006 [95%CI 0, 0.011].
## The p-value of the two-sided permutation t-test is 0.0296, calculated for legacy purposes only.
## 
## 5000 bootstrap samples were taken; the confidence interval is bias-corrected and accelerated.
## Any p-value reported is the probability of observing the effect size (or greater),
## assuming the null hypothesis of zero difference is true.
## For each p-value, 5000 reshuffles of the control and test labels were performed.
```

``` r
dabest_plot(mean_diff_tarsus)
```

![](BIO708_EffectSizes_files/figure-html/unnamed-chunk-16-1.png)<!-- -->


## standardized measures of effect

Or we can (using dabest) do *Cohen's d* or *Hedges's g*. Importantly in dabest the *Hedges g* is just the bias corrected version of *Cohen's d*. For this data set (since sample sizes are not too small), the differences do not matter much. Usually best to use *Hedge's g* if you are not sure though.

we have to use `dabestr::functionName` as both packages have functions with the same name.


``` r
G_SCT <- dabestr::hedges_g(diff_SCT)

G_SCT
```

```
## DABESTR v2025.3.15
## ==================
## 
## Good morning!
## The current time is 11:13 AM on Tuesday February 03, 2026.
## 
## The character(0) Hedges'g between Dll and wt is 1.476 [95%CI 1.003, 1.927].
## The p-value of the two-sided permutation t-test is 0.0000, calculated for legacy purposes only.
## 
## 5000 bootstrap samples were taken; the confidence interval is bias-corrected and accelerated.
## Any p-value reported is the probability of observing the effect size (or greater),
## assuming the null hypothesis of zero difference is true.
## For each p-value, 5000 reshuffles of the control and test labels were performed.
```

``` r
dabest_plot(G_SCT)
```

![](BIO708_EffectSizes_files/figure-html/unnamed-chunk-17-1.png)<!-- -->



``` r
G_tarsus <- dabestr::hedges_g(diff_tarsus)

G_tarsus
```

```
## DABESTR v2025.3.15
## ==================
## 
## Good morning!
## The current time is 11:13 AM on Tuesday February 03, 2026.
## 
## The character(0) Hedges'g between Dll and wt is 0.479 [95%CI 0.023, 0.942].
## The p-value of the two-sided permutation t-test is 0.0296, calculated for legacy purposes only.
## 
## 5000 bootstrap samples were taken; the confidence interval is bias-corrected and accelerated.
## Any p-value reported is the probability of observing the effect size (or greater),
## assuming the null hypothesis of zero difference is true.
## For each p-value, 5000 reshuffles of the control and test labels were performed.
```

``` r
dabest_plot(G_tarsus)
```

![](BIO708_EffectSizes_files/figure-html/unnamed-chunk-18-1.png)<!-- -->

### what does this tell us?

Looking at these plots we can say (relative to the variation in the traits) that the effect the mutant allele has on the number of SCT is much greater than on the length of the leg segment (for this strain anyways). That is we can use this to understand something of the pleiotropic effects of the mutation.

How much greater?


``` r
1.476/0.479
```

```
## [1] 3.08
```

About 3 times greater effect (relative to the pooled standard deviation of each trait).


## What if we wanted to compare just to the variation in the control group.

Normally we would have decided all of this in advance of collecting data and modeling. But for purposes of getting a sense of how things may (or may not) change, let's try doing this just using the standard deviation of the control group (the wild type).


``` r
SCT_means <- with(sct_dat_subset, 
                  tapply(SCT, INDEX = genotype, mean))

SCT_sd <- with(sct_dat_subset, 
                  tapply(SCT, INDEX = genotype, sd))

tarsus_means <- with(sct_dat_subset, 
                  tapply(tarsus, INDEX = genotype, mean))

tarsus_sd <- with(sct_dat_subset, 
                  tapply(tarsus, INDEX = genotype, sd))

Glass_delta_SCT <- diff(SCT_means)/SCT_sd["wt"]

Glass_delta_tarsus <- diff(tarsus_means)/tarsus_sd["wt"]


Glass_delta_SCT
```

```
##  Dll 
## 1.71
```

``` r
Glass_delta_tarsus
```

```
##   Dll 
## 0.484
```

``` r
Glass_delta_SCT/Glass_delta_tarsus
```

```
##  Dll 
## 3.54
```

About 3.5 times greater in effect on SCT compared to the length of the tarsus. Take a look and see if you can figure out why this differs from Hedge's g


## How about scaling by the mean of the control group?

Another common approach would be to scale by the mean of the control group. There may be a pre-built function, but I could not find it, so let's just hard code it.



``` r
diff_mean_scaled_SCT <- diff(SCT_means)/SCT_means["wt"]

diff_mean_scaled_tarsus <- diff(tarsus_means)/tarsus_means["wt"]

diff_mean_scaled_SCT 
```

```
##   Dll 
## 0.172
```

``` r
diff_mean_scaled_tarsus
```

```
##    Dll 
## 0.0298
```

``` r
diff_mean_scaled_SCT/diff_mean_scaled_tarsus
```

```
##  Dll 
## 5.76
```


Using the mean standardized measure of effect gives us a somewhat different picture, where the effects of the mutant allele on SCT number is approximately 5.8 times greater than the effect on the length of the tarsus. Often the mean scaled measures can be more difficult to interpret (even if they are pretty easy to compare), so use with some degree of caution. 

Obviously (and I said it above, but it bears repeating), for a real analysis the appropriate measure of effect sizes would have been determined *a priori* along with what values of the measure would likely be deemed biologically relevant. In addition to our readings, there is a nice, but brief discussion of some of this [here](https://easystats.github.io/effectsize/articles/interpret.html).

## emmeans can do this all as well

For models with complexity of multiple predictors, continuous predictors, interactions etc, `emmeans` can probably handle what you want. It is very flexivle, but not super-intuitive (for `emmeans`, which is usually pretty good.)

See `?eff_size`

Even though you are scaling by `sigma` in the function, you could use other measures.

Note that for complex models, a reasonable measure of the `pooled sd` is just the standard deviation of the residuals (sometimes called the residual standard error)

``` r
summary(sct_mod1)
```

```
## 
## Call:
## lm(formula = SCT ~ genotype, data = sct_dat_subset)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -2.675 -0.818  0.182  1.182  3.325 
## 
## Coefficients:
##             Estimate Std. Error t value
## (Intercept)   10.818      0.188   57.59
## genotypeDll    1.857      0.272    6.82
## 
## Residual standard error: 1.25 on 82 degrees of freedom
## Multiple R-squared:  0.362,	Adjusted R-squared:  0.354 
## F-statistic: 46.5 on 1 and 82 DF,  p-value: 1.42e-09
```

``` r
emm1 <- emmeans(sct_mod1, ~genotype)
emm1
```

```
##  genotype emmean    SE df lower.CL upper.CL
##  wt         10.8 0.188 82     10.4     11.2
##  Dll        12.7 0.197 82     12.3     13.1
## 
## Confidence level used: 0.95
```

``` r
eff1 <- eff_size(emm1, sigma = sd(sct_mod1$residuals), edf = 50)

eff1
```

```
##  contrast effect.size    SE df lower.CL upper.CL
##  wt - Dll        -1.5 0.266 82    -2.03    -0.97
## 
## sigma used for effect sizes: 1.239 
## Confidence level used: 0.95
```

``` r
sqrt(2/50) # relative accuracy of sigma
```

```
## [1] 0.2
```

