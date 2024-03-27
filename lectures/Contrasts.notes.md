---
title: "Introduction to contrasts, and using emmeans in R"
bibliography: "../qmee.bib"
author: "Ian Dworkin"
date: "27 Mar 2024"
output:
  html_document:
    keep_md: true
    code_folding: hide
    number_sections: true
    toc: true
  pdf_document:
    toc: true
editor_options:
  chunk_output_type: console
---




# Introduction to custom contrasts, and using emmeans


## custom functions



```r
lm_out <- function(x = modname) {
    cbind(as.matrix(summary(x)$coef[,1:3]),
          as.matrix(confint(x)) )}
```


## Load packages


```r
library(lme4)
library(emmeans)
library(car)
library(ggplot2)
library(ggbeeswarm)
```


## Background

Often we are fitting models where there may be many levels for our categorical predictors (factors). For example we may have a predictor for type of water body (lake, pond river, stream, ...). However, we may note be just interested in whether there are overall differences in our response (say [P]) like we may get from an ANOVA table. Nor are we interested in all possible comparisons between the four levels, but just specific comparisons (large volumes of water vs small, fast moving vs slow). This is a great use for custom contrasts!

Alternatively a common situation is where you are fitting models with multiple categorical predictors, along with their interactions. Sometimes the model output can be hard to interpret, especially if you have a specific hypothesis, and the default R output does not provide the estimates in a conveniently interpretable format. This is again an important use for custom contrasts.


## First example  with the iris data set


![Iris](https://upload.wikimedia.org/wikipedia/commons/a/a7/Irissetosa1.jpg)



```r
data(iris)
```


### The iris data


```r
head(iris)
```

```
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
## 4          4.6         3.1          1.5         0.2  setosa
## 5          5.0         3.6          1.4         0.2  setosa
## 6          5.4         3.9          1.7         0.4  setosa
```

```r
with(iris, table(Species))
```

```
## Species
##     setosa versicolor  virginica 
##         50         50         50
```


### quick plot of the iris data



```r
ggplot(iris, aes(y = Sepal.Length, x = Petal.Length, col = Species)) +
   geom_point()
```

![](Contrasts.notes_files/figure-html/iris-plot-1.png)<!-- -->


### Let's consider this situation

 (this "question" is made up to facilitate the analysis!)
 
 While we want to compare the differences between species for these morphological traits, we are specifically interested in in comparisons of *versicolor* to the other two species. So how may we do this?
 
 
### What if we just fit a linear model (simple one way ANOVA)?

```r
mod1 <- lm(Sepal.Length ~ Species,
           data = iris)
```

We can examine the anova table

```r
anova(mod1)
```

```
## Analysis of Variance Table
## 
## Response: Sepal.Length
##            Df Sum Sq Mean Sq F value Pr(>F)
## Species     2   63.2   31.61     119 <2e-16
## Residuals 147   39.0    0.27
```

But all this really tells us is that there is variation among species (that exceeds expectations based on variation among individuals within species).


We can look at the summary to get the coefficients

```r
summary(mod1)
```

```
## 
## Call:
## lm(formula = Sepal.Length ~ Species, data = iris)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -1.688 -0.329 -0.006  0.312  1.312 
## 
## Coefficients:
##                   Estimate Std. Error t value Pr(>|t|)
## (Intercept)         5.0060     0.0728   68.76  < 2e-16
## Speciesversicolor   0.9300     0.1030    9.03  8.8e-16
## Speciesvirginica    1.5820     0.1030   15.37  < 2e-16
## 
## Residual standard error: 0.515 on 147 degrees of freedom
## Multiple R-squared:  0.619,	Adjusted R-squared:  0.614 
## F-statistic:  119 on 2 and 147 DF,  p-value: <2e-16
```

Let's make the output simpler and a bit more useful to the task at hand


```r
lm_out(mod1)
```

```
##                   Estimate Std. Error t value 2.5 % 97.5 %
## (Intercept)           5.01     0.0728   68.76 4.862   5.15
## Speciesversicolor     0.93     0.1030    9.03 0.727   1.13
## Speciesvirginica      1.58     0.1030   15.37 1.379   1.79
```

By default this shows the differences of each of *versicolor* and *virginica* to *setosa*. The intercept is the mean Sepal length for *setosa*, and the other two coefficients are the treatment contrasts (differences) for the other two species with *setosa*.


## But what we want is different than this!

We want to see if *versicolor* is different than either of the other two species, and the other two species averaged.

### A couple of ways of thinking about this that may help

Let's compute mean sepal length by species

```r
SL_means_Species <- with(iris, 
     tapply(Sepal.Length, Species, mean))

SL_means_Species
```

```
##     setosa versicolor  virginica 
##       5.01       5.94       6.59
```


As this is such a simple model (just a single factor) these means will be the same as the predicted values from the models:


```r
species_predictedVals <- unique(predict(mod1))

names(species_predictedVals) <- c("setosa", "versicolor", "virginica")

species_predictedVals 
```

```
##     setosa versicolor  virginica 
##       5.01       5.94       6.59
```


differences between means can be estimated simply:

```r
SL_means_Species["versicolor"] - SL_means_Species["setosa"]
```

```
## versicolor 
##       0.93
```

```r
SL_means_Species["virginica"] - SL_means_Species["setosa"]
```

```
## virginica 
##      1.58
```

So we can see that the treatment contrasts in the linear model are (in this simple case) just the differences in the estimates of the species means.

### These are not the difference(s) we are looking for!

![NotTheDroidsYouAreLookingFor](https://media.giphy.com/media/l2JJKs3I69qfaQleE/giphy.gif) 


But we are not interested in the difference between *setosa* and the other two species, but in comparisons to *versicolor*.


## Reviewing (or introducing) ourselves to the "design matrix"


It may help to remind ourselves of the design matrix ($\mathbf{X}$) for our linear model. In `R` we use the `model.matrix()` function to look at this.


```r
head(model.matrix( ~ iris$Species))
```

```
##   (Intercept) iris$Speciesversicolor iris$Speciesvirginica
## 1           1                      0                     0
## 2           1                      0                     0
## 3           1                      0                     0
## 4           1                      0                     0
## 5           1                      0                     0
## 6           1                      0                     0
```

Or more usefully, we only need to print out one row for each species, since each individual within a species is the same for the predictor.


```r
unique(model.matrix( ~ iris$Species))
```

```
##     (Intercept) iris$Speciesversicolor iris$Speciesvirginica
## 1             1                      0                     0
## 51            1                      1                     0
## 101           1                      0                     1
```


While R can be somewhat confusing on this, you can use the `contrasts` function to also peek at this:


```r
Smat <- contrasts(as.factor(iris$Species))
```

Note that the first column (of all 1s) is missing from this. That first column represents what? 


Let's add the intercept back on


```r
Smat <- cbind(1, Smat)

Smat
```

```
##              versicolor virginica
## setosa     1          0         0
## versicolor 1          1         0
## virginica  1          0         1
```

So we see that `lm` by default, is using the estimated mean of the first species, *setosa* as the model intercept (first column in the design matrix). The second column is telling lm says to estimate how much needs to be added to the the intercept (*setosa* mean) to get the mean of the second species (*versicolor*).  The third and final column represents how much needs to be added to the the intercept (*setosa* mean) to get the mean of the third species (*virginica*).

But it sometimes helps to think about this in terms of the contrasts between estimates (in this case the means) *per se*. To do this we just use the `solve` function in `R` which does a bit of linear algebra (inverts the matrix). 


```r
Lmat <- solve(Smat)

Lmat
```

```
##            setosa versicolor virginica
##                 1          0         0
## versicolor     -1          1         0
## virginica      -1          0         1
```


Now we consider each row (instead of column like the design matrix)

- The second row says that the contrast it is giving us is the difference between the estimated means of *versicolor* and *setosa*.

- The third row says that the contrast it is giving us is the difference between the estimated means of *virginica* and *setosa*.

Let's take a look


```r
species_predictedVals
```

```
##     setosa versicolor  virginica 
##       5.01       5.94       6.59
```

For *versicolor*

```r
species_predictedVals[2] - species_predictedVals[1]
```

```
## versicolor 
##       0.93
```

For *virginica*

```r
species_predictedVals[3] - species_predictedVals[1]
```

```
## virginica 
##      1.58
```

which is the same as the estimates in the second and third rows of our model output

```r
lm_out(mod1)
```

```
##                   Estimate Std. Error t value 2.5 % 97.5 %
## (Intercept)           5.01     0.0728   68.76 4.862   5.15
## Speciesversicolor     0.93     0.1030    9.03 0.727   1.13
## Speciesvirginica      1.58     0.1030   15.37 1.379   1.79
```

Importantly, in statistics we describe the values in the matrix (`Lmat`) that we inverted as *contrast coefficients*. 

So how we set up the design matrix actually influences the default contrasts we get as the model coefficients. But what if those are not the contrasts we want? Do we need to change the design matrix?  Not necessarily. Once we have the estimates, we can fit our custom contrasts. But first, let's go through an example where we do change the design matrix.

## How might we get the contrast we care about?

One easy fix for this without having to think about custom contrasts at all (yet!) is to re-level our factor so that the base level is versicolor:



```r
iris$Species2 <- relevel(iris$Species, "versicolor")
```


we can look at two rows each for the three species

```r
model.matrix(~iris$Species2)[c(1:2,51:52, 101:102),]
```

```
##     (Intercept) iris$Species2setosa iris$Species2virginica
## 1             1                   1                      0
## 2             1                   1                      0
## 51            1                   0                      0
## 52            1                   0                      0
## 101           1                   0                      1
## 102           1                   0                      1
```

or using `contrasts`

```r
cbind(1, contrasts(as.factor(iris$Species2)))
```

```
##              setosa virginica
## versicolor 1      0         0
## setosa     1      1         0
## virginica  1      0         1
```

Now if we fit the same model, just with *versicolor* representing the intercept


```r
mod1_alt <- lm(Sepal.Length ~ Species2,
           data = iris)

lm_out(mod1_alt)
```

```
##                   Estimate Std. Error t value  2.5 % 97.5 %
## (Intercept)          5.936     0.0728   81.54  5.792  6.080
## Species2setosa      -0.930     0.1030   -9.03 -1.133 -0.727
## Species2virginica    0.652     0.1030    6.33  0.449  0.855
```



Why did this work? Because we re-organized the design matrix a bit.  


Our initial design matrix had this format

```r
unique(model.matrix(mod1))
```

```
##     (Intercept) Speciesversicolor Speciesvirginica
## 1             1                 0                0
## 51            1                 1                0
## 101           1                 0                1
```


When we changed the reference level, the intercept was now *versicolor* instead of *setosa*. 


```r
unique(model.matrix(mod1_alt))
```

```
##     (Intercept) Species2setosa Species2virginica
## 1             1              1                 0
## 51            1              0                 0
## 101           1              0                 1
```


## So what's the problem?

This solution works for simple cases. It is not particularly useful for more complex models, or complex contrasts.

What if I wanted to compare the difference between *versicolor* and the other two species? How should I go about doing that?

Here are the predicted values again:

```r
species_predictedVals
```

```
##     setosa versicolor  virginica 
##       5.01       5.94       6.59
```

One way of thinking about this is comparing the predicted value of *versicolor* to the mean of the predicted values of the other two species



```r
species_predictedVals["versicolor"] - mean(species_predictedVals[c("setosa", "virginica")])
```

```
## versicolor 
##      0.139
```


Mathematically,

$$ 1 \times \hat{\mu}_{versicolor}  - \frac{1}{2} \times\hat{\mu}_{setosa} - \frac{1}{2} \times\hat{\mu}_{virginica}$$

i.e

$$ 1 \times \hat{\mu}_{versicolor}  - \frac{1}{2} (\hat{\mu}_{setosa} + \hat{\mu}_{virginica})$$

with (contrast) coefficients

$$ (1,- \frac{1}{2}, - \frac{1}{2} )$$


```r
1*species_predictedVals["versicolor"] - (1/2)*species_predictedVals["setosa"] - (1/2)*species_predictedVals["virginica"] 
```

```
## versicolor 
##      0.139
```


That is, the difference between the predicted value of versicolor and half the predicted value of each of the other two species.



```r
contrast_vector_example <- c(1, -0.5, -0.5)

sum(contrast_vector_example)
```

```
## [1] 0
```

This is the same as saying if the predicted value of *setosa* was the same as the mean of the predicted values of the other two species, the difference should be zero. 


$$ \hat{\mu}_{versicolor}  \approxeq \frac{1}{2} (\hat{\mu}_{setosa} + \hat{\mu}_{virginica})$$

This is an example of a custom contrast. With:

$$(1, -\frac{1}{2}, -\frac{1}{2})$$ 

representing the contrasts coefficients.

### Contrast coefficients

We can construct our contrast coefficients with a few basic "rules" (See Crawley pg 368-369). For each particular contrast we want to set it up so that:

- Treatments to be lumped together (like *setosa* and *virginica*) get the same sign ($+$ or $-$)
- Groups of means to be contrasted get opposite signs
- a contrast coefficient of $0$ is used if that factor level is to be excluded from the comparison
- The sum of the contrasts coefficients (usually) add up to zero

When we are examining more than one contrast from a particular model, we often would like to only have *orthogonal contrasts*, where each contrast is uncorrelated (linearly independent) of all other contrasts. To do so we make sure:  

- The sum of the contrasts coefficients, for a particular contrast (always) add up to zero
- The cross-product of the coefficients, for any pair of contrasts, sum to zero. (show example to explain)

### How does this help me get the estimates I want?

Well a couple of issues. First the way I just wrote this, is annoying for anything but a toy problem like this. 
More importantly I want to be able to assess the uncertainty in this difference I computed. That means some fiddly algebra with the standard errors for each estimate. 


### custom contrasts in base R.
Not shockingly in base R, we can use the `contrasts` function to help set up our custom contrasts

We can see what the default contrasts are



```r
contrasts(iris$Species)
```

```
##            versicolor virginica
## setosa              0         0
## versicolor          1         0
## virginica           0         1
```

```r
contrasts(iris$Species2)
```

```
##            setosa virginica
## versicolor      0         0
## setosa          1         0
## virginica       0         1
```

Say in addition to the contrast above, I planned to also contrast the difference between *setosa* and *virginica*. How could we set this up?


```r
levels(iris$Species)
```

```
## [1] "setosa"     "versicolor" "virginica"
```

```r
setosa_virginica <- c(1, 0, -1)  # setosa VS virginica


versicolor_VS_others <- c(-0.5, 1, -0.5)
```

Unfortunately using these effectively with base R requires a few additional algebraic steps, which we want to avoid for now. So let's use the `emmeans` library, which takes care of all of this for us.

## using emmeans




### Getting the estimated means and their confidence intervals with emmeans

```r
summary(mod1)
```

```
## 
## Call:
## lm(formula = Sepal.Length ~ Species, data = iris)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -1.688 -0.329 -0.006  0.312  1.312 
## 
## Coefficients:
##                   Estimate Std. Error t value Pr(>|t|)
## (Intercept)         5.0060     0.0728   68.76  < 2e-16
## Speciesversicolor   0.9300     0.1030    9.03  8.8e-16
## Speciesvirginica    1.5820     0.1030   15.37  < 2e-16
## 
## Residual standard error: 0.515 on 147 degrees of freedom
## Multiple R-squared:  0.619,	Adjusted R-squared:  0.614 
## F-statistic:  119 on 2 and 147 DF,  p-value: <2e-16
```

```r
spp_em <- emmeans(mod1, ~Species)   # means
spp_em 
```

```
##  Species    emmean     SE  df lower.CL upper.CL
##  setosa       5.01 0.0728 147     4.86     5.15
##  versicolor   5.94 0.0728 147     5.79     6.08
##  virginica    6.59 0.0728 147     6.44     6.73
## 
## Confidence level used: 0.95
```

```r
plot(spp_em) +
  theme_bw() +
  theme(text = element_text(size = 16))
```

![](Contrasts.notes_files/figure-html/emm1-1.png)<!-- -->


### Setting up our custom contrasts in emmeans

We can use the `contrast` function (note, not `contrasts` with an **s** at the end) and provide these to get the contrasts we are interested in.


```r
iris_custom_contrasts <- contrast(spp_em, 
         list(versicolor_VS_others = versicolor_VS_others, 
              virginica_VS_setosa = c(1, 0, -1)))

iris_custom_contrasts
```

```
##  contrast             estimate     SE  df t.ratio p.value
##  versicolor_VS_others    0.139 0.0892 147   1.560  0.1212
##  virginica_VS_setosa    -1.582 0.1030 147 -15.370  <.0001
```


`emmeans` is even more useful, making it straightforward to get confidence intervals for the contrasts!


```r
confint(iris_custom_contrasts )
```

```
##  contrast             estimate     SE  df lower.CL upper.CL
##  versicolor_VS_others    0.139 0.0892 147   -0.037    0.315
##  virginica_VS_setosa    -1.582 0.1030 147   -1.785   -1.379
## 
## Confidence level used: 0.95
```


Which can be plotted easily (`ggplot2` object)


```r
plot(iris_custom_contrasts) +
         geom_vline(xintercept = 0, lty = 2 , alpha = 0.5) +
         theme_bw() +
         theme(text = element_text(size = 20))
```

![](Contrasts.notes_files/figure-html/emm-plot-custom-1.png)<!-- -->


### Flexibility with emmeans for many types of contrasts

This approach allows much more flexibility. see `?"contrast-methods"`. Furthermore emmeans has excellent vignettes in the help which can guide you a great deal.

Importantly and helpfully, for broader sets of contrasts emmeans does much automatically.

If we had *a priori* (really important!), planned to compare all species to each other we could use this. 


```r
contrast(spp_em, method = "pairwise")
```

```
##  contrast               estimate    SE  df t.ratio p.value
##  setosa - versicolor      -0.930 0.103 147  -9.030  <.0001
##  setosa - virginica       -1.582 0.103 147 -15.370  <.0001
##  versicolor - virginica   -0.652 0.103 147  -6.330  <.0001
## 
## P value adjustment: tukey method for comparing a family of 3 estimates
```

For pairwise comparisons there is a shortcut function as well.


```r
pairs(spp_em) 
```

```
##  contrast               estimate    SE  df t.ratio p.value
##  setosa - versicolor      -0.930 0.103 147  -9.030  <.0001
##  setosa - virginica       -1.582 0.103 147 -15.370  <.0001
##  versicolor - virginica   -0.652 0.103 147  -6.330  <.0001
## 
## P value adjustment: tukey method for comparing a family of 3 estimates
```

```r
confint(pairs(spp_em))
```

```
##  contrast               estimate    SE  df lower.CL upper.CL
##  setosa - versicolor      -0.930 0.103 147   -1.174   -0.686
##  setosa - virginica       -1.582 0.103 147   -1.826   -1.338
##  versicolor - virginica   -0.652 0.103 147   -0.896   -0.408
## 
## Confidence level used: 0.95 
## Conf-level adjustment: tukey method for comparing a family of 3 estimates
```

It automatically adjusts for the multiple comparisons in this case of doing pairwise comparisons.

As we discussed in class. Doing all pairwise comparisons is probably **not** something you want, and rarely makes for good science either. Certainly, it is not consistent with the statistical philosophy we are trying to instill. Instead, we strongly advocate focusing on your (small?) set of planned (*a priori*) comparisons.


```r
plot(pairs(spp_em)) +
         geom_vline(xintercept = 0, lty = 2 , alpha = 0.5) +
         xlab("Estimated difference in Sepal Lengths")
```

![](Contrasts.notes_files/figure-html/unnamed-chunk-7-1.png)<!-- -->


The pairs function does allow us to focus on fewer comparisons thankfully. We could have gotten our *setosa* VS *virginica* (i.e. excluding *versicolor*) comparison this way:


```r
pairs(spp_em, exclude = 2)
```

```
##  contrast           estimate    SE  df t.ratio p.value
##  setosa - virginica    -1.58 0.103 147 -15.370  <.0001
```


## An example of interaction contrasts from a linear mixed effects model

Here is an example from a much more complex linear mixed model.

The data is from an artificial selection experiment in *Drosophila melanogaster*, where, over the course of more than 350 generations (when this data was generated) flies were selected sex concordantly or discordantly for body size. [See the pre-print here for more information](https://www.biorxiv.org/content/10.1101/2023.08.31.555745v2)

We have been investigating trait specific changes in sexual size dimorphism, and how it compares to what is observed in the control lineages (where the ancestral pattern of female biased size dimorphism occurs). We are, in particular, interested in the effects of the interaction between sex and selective treatment. How best to examine this?

A subset of the data from this experiment is available in the same github repository as `contrast_tutorial_dat.RData`

### The data

```r
load("../data/contrast_tutorial_dat.RData")

#load("contrast_tutorial_dat.RData")

size_dat <- contrast_tutorial_dat
```


What the data frame looks like

```r
head(size_dat)
```

```
##     sex selection replicate sampling  trait individual_id length repeat_measure
## 100   F   Control         1        R thorax             1  0.934              1
## 101   F   Control         1        R thorax             2  1.057              1
## 102   F   Control         1        R thorax             3  0.908              1
## 103   F   Control         1        R thorax             4  1.016              1
## 104   F   Control         1        R thorax             5  0.854              1
## 105   F   Control         1        R thorax             6  0.973              1
```

### A quick visual summary


```r
ggplot(size_dat, 
       aes( y = length, x = selection:sex, col = sex, shape = replicate)) +
  geom_quasirandom(alpha = 0.8, size = 1.4) +
  labs( y = "length (mm)") +
  ggtitle("thorax") +
  theme_classic() +
  theme(text = element_text(size = 18))
```

<img src="Contrasts.notes_files/figure-html/beeswarm-1.png" width="100%" />


Here is the  model we used for the study for this trait. I will briefly discuss it with you, but importantly you will see it is more complicated than our simple example above with the iris data.

### review: Why log transform the response variable?

**Note:** with the model that I am multiplying thorax length by 1000 (to convert to $\mu m$) and then using a $log_2$ transformation on it.

Why am I doing the log transformation in the first place?

I am doing the transformation directly in the model call itself. While not necessary, it is useful, as `emmeans` recognizes the log transformation, and facilitates back-transformation of our estimates, if we want to examine them.


### The model

```r
mod1_thorax <- lmer(log2(length*1000) ~ (sex + selection + sampling)^2 + (0 + sex| replicate:selection),
           data = size_dat, 
           subset = repeat_measure == "1")
```


### Limited value of ANOVA's for interaction effect
So how do we make sense of how sexual size dimorphism is changing among the selective treatments?

An Anova (putting aside limitations on ANOVA in general, and for mixed models in particular for the moment) is not particularly informative:


```r
Anova(mod1_thorax)
```

```
## Analysis of Deviance Table (Type II Wald chisquare tests)
## 
## Response: log2(length * 1000)
##                     Chisq Df Pr(>Chisq)
## sex                140.67  1    < 2e-16
## selection          242.72  3    < 2e-16
## sampling            18.90  1    1.4e-05
## sex:selection       38.24  3    2.5e-08
## sex:sampling         5.29  1    0.02141
## selection:sampling  20.28  3    0.00015
```

We see a significant effect of the interaction between sex and treatment, but so what? What selective treatment is this a result of and what are the magnitudes of the change? An Anova is not useful for this.


### model coefficients (in treatment contrast form) are not very helpful either

For a model this complicated we also see that the summary table of coefficients is not simple to parse for our needs (we could do lots of adding up of various terms, but how about the standard errors for these...)



```r
round(summary(mod1_thorax)$coef, digits = 4)
```

```
##                                 Estimate Std. Error  t value
## (Intercept)                       9.8831     0.0274 360.2216
## sexM                             -0.1798     0.0224  -8.0223
## selectionSSD_reversed            -0.1543     0.0391  -3.9483
## selectionLarge                    0.1186     0.0391   3.0333
## selectionSmall                   -0.3864     0.0391  -9.8857
## samplingS                        -0.0394     0.0145  -2.7268
## sexM:selectionSSD_reversed        0.1527     0.0311   4.9170
## sexM:selectionLarge               0.0005     0.0311   0.0152
## sexM:selectionSmall              -0.0159     0.0311  -0.5124
## sexM:samplingS                    0.0311     0.0135   2.3007
## selectionSSD_reversed:samplingS   0.0041     0.0189   0.2180
## selectionLarge:samplingS          0.0291     0.0189   1.5417
## selectionSmall:samplingS         -0.0557     0.0189  -2.9550
```



### Using emmeans for this model
This is where contrasts become SO useful!

#### Estimated marginal means 
First, just the estimated means, for each sex, by selective regime

```r
thorax_emm <- emmeans(mod1_thorax, specs = ~ sex | selection)

thorax_emm
```

```
## selection = Control:
##  sex emmean     SE   df lower.CL upper.CL
##  F     9.86 0.0268 3.88     9.79     9.94
##  M     9.70 0.0302 3.94     9.61     9.78
## 
## selection = SSD_reversed:
##  sex emmean     SE   df lower.CL upper.CL
##  F     9.71 0.0271 4.05     9.64     9.79
##  M     9.70 0.0303 4.02     9.62     9.78
## 
## selection = Large:
##  sex emmean     SE   df lower.CL upper.CL
##  F    10.00 0.0271 4.05     9.92    10.07
##  M     9.83 0.0303 4.02     9.75     9.92
## 
## selection = Small:
##  sex emmean     SE   df lower.CL upper.CL
##  F     9.45 0.0271 4.05     9.37     9.52
##  M     9.27 0.0303 4.02     9.18     9.35
## 
## Results are averaged over the levels of: sampling 
## Degrees-of-freedom method: kenward-roger 
## Results are given on the log2 (not the response) scale. 
## Confidence level used: 0.95
```

```r
## rotate strip labels:
## https://stackoverflow.com/questions/40484090/rotate-switched-facet-labels-in-ggplot2-facet-grid
rot_strips <-   theme_bw() +
    theme(text = element_text(size = 16),
          strip.text.y.right = element_text(angle = 0))

plot(thorax_emm,
     xlab = "model estimates, thorax length, log2 µm") +
    rot_strips
```

![](Contrasts.notes_files/figure-html/marg-means-plot-1.png)<!-- -->


#### side note: Back-transforming in emmeans
Like I mentioned `emmeans` can recognize the $\mathrm{log_2}$ transformation, so if you prefer the measures or plots in $\mu m$ response scale.


```r
thorax_emm_response <- emmeans(mod1_thorax, 
                               specs = ~ sex | selection, type = "response")

thorax_emm_response
```

```
## selection = Control:
##  sex response   SE   df lower.CL upper.CL
##  F        931 17.3 3.88      884      981
##  M        831 17.4 3.94      784      881
## 
## selection = SSD_reversed:
##  sex response   SE   df lower.CL upper.CL
##  F        838 15.8 4.05      796      883
##  M        831 17.5 4.02      784      881
## 
## selection = Large:
##  sex response   SE   df lower.CL upper.CL
##  F       1022 19.2 4.05      970     1076
##  M        912 19.2 4.02      860      967
## 
## selection = Small:
##  sex response   SE   df lower.CL upper.CL
##  F        699 13.1 4.05      664      736
##  M        617 13.0 4.02      582      654
## 
## Results are averaged over the levels of: sampling 
## Degrees-of-freedom method: kenward-roger 
## Confidence level used: 0.95 
## Intervals are back-transformed from the log2 scale
```

*What this is doing:* For the estimated mean of females from the control treatment ($\mathrm{log_2}$ ):

```r
F_control_log2 <- as.data.frame(thorax_emm[1,])

F_control_log2
```

```
##  sex selection emmean     SE   df lower.CL upper.CL
##  F   Control     9.86 0.0268 3.88     9.79     9.94
## 
## Results are averaged over the levels of: sampling 
## Degrees-of-freedom method: kenward-roger 
## Results are given on the log2 (not the response) scale. 
## Confidence level used: 0.95
```

Let's pull out the estimate (`emmean`) and its lower and upper confidence intervals:


```r
F_control_log2 <- c(F_control_log2$emmean,
                    F_control_log2$lower.CL,
                    F_control_log2$upper.CL)

F_control_log2
```

```
## [1] 9.86 9.79 9.94
```

To get this back to the response scale in $ \mathrm{\mu m}$ we just need to remember all we are doing is using $2^x$, where $x$ will be our estimate and its confidence intervals like so:


```r
2^F_control_log2
```

```
## [1] 931 884 981
```

this is the same as what emmeans reports on the response scale:

```r
thorax_emm_response[1,]
```

```
##  sex selection response   SE   df lower.CL upper.CL
##  F   Control        931 17.3 3.88      884      981
## 
## Results are averaged over the levels of: sampling 
## Degrees-of-freedom method: kenward-roger 
## Confidence level used: 0.95 
## Intervals are back-transformed from the log2 scale
```


Let's plot it on the response scale


```r
plot(thorax_emm_response,
     xlab = "model estimates, thorax length, µm") +
    rot_strips
```

![](Contrasts.notes_files/figure-html/unnamed-chunk-19-1.png)<!-- -->


### contrasts for sexual dimorphism
 While it is not the hypothesis we are examining, for purposes of clarity of taking you through the steps, let's examine treatment specific patterns of sexual dimorphism. We will set this up as so:



```r
thorax_vals <- emmeans(mod1_thorax, 
             specs = ~ sex | selection)

SSD_contrasts_treatment <- pairs(thorax_vals)

SSD_contrasts_treatment
```

```
## selection = Control:
##  contrast estimate     SE   df t.ratio p.value
##  F - M      0.1643 0.0217 3.70   7.580  0.0020
## 
## selection = SSD_reversed:
##  contrast estimate     SE   df t.ratio p.value
##  F - M      0.0116 0.0222 4.11   0.520  0.6290
## 
## selection = Large:
##  contrast estimate     SE   df t.ratio p.value
##  F - M      0.1638 0.0222 4.11   7.360  0.0020
## 
## selection = Small:
##  contrast estimate     SE   df t.ratio p.value
##  F - M      0.1802 0.0222 4.11   8.100  0.0010
## 
## Results are averaged over the levels of: sampling 
## Degrees-of-freedom method: kenward-roger 
## Results are given on the log2 (not the response) scale.
```

```r
confint(SSD_contrasts_treatment)
```

```
## selection = Control:
##  contrast estimate     SE   df lower.CL upper.CL
##  F - M      0.1643 0.0217 3.70   0.1021   0.2264
## 
## selection = SSD_reversed:
##  contrast estimate     SE   df lower.CL upper.CL
##  F - M      0.0116 0.0222 4.11  -0.0495   0.0727
## 
## selection = Large:
##  contrast estimate     SE   df lower.CL upper.CL
##  F - M      0.1638 0.0222 4.11   0.1027   0.2249
## 
## selection = Small:
##  contrast estimate     SE   df lower.CL upper.CL
##  F - M      0.1802 0.0222 4.11   0.1191   0.2413
## 
## Results are averaged over the levels of: sampling 
## Degrees-of-freedom method: kenward-roger 
## Results are given on the log2 (not the response) scale. 
## Confidence level used: 0.95
```



```r
plot(SSD_contrasts_treatment) + 
  geom_vline(xintercept = 0, lty = 2, alpha = 0.5) + 
    labs(x = "sexual size dimorphism") +
    rot_strips
```

![](Contrasts.notes_files/figure-html/unnamed-chunk-21-1.png)<!-- -->


### The interaction contrast
But what we really want is to see how dimorphism changes in the selected treatments, relative to the controls. This is the interaction contrast (contrast of contrasts)


```r
thorax_ssd <- emmeans(mod1_thorax,  pairwise ~ sex*selection) # warning is letting you know these are not of general use. We only do this as we are forming an interaction contrast.

thorax_ssd_contrasts <- contrast(thorax_ssd[[1]], 
                                 interaction = c(selection = "trt.vs.ctrl1", sex = "pairwise"),
                                 by = NULL)
```

Let's take a look at our interaction contrasts and their confidence intervals:


```r
thorax_ssd_contrasts
```

```
##  selection_trt.vs.ctrl1 sex_pairwise estimate     SE  df t.ratio p.value
##  SSD_reversed - Control F - M         -0.1527 0.0311 3.9  -4.920  0.0080
##  Large - Control        F - M         -0.0005 0.0311 3.9  -0.020  0.9890
##  Small - Control        F - M          0.0159 0.0311 3.9   0.510  0.6360
## 
## Results are averaged over the levels of: sampling 
## Degrees-of-freedom method: kenward-roger 
## Results are given on the log2 (not the response) scale.
```

```r
confint(thorax_ssd_contrasts)
```

```
##  selection_trt.vs.ctrl1 sex_pairwise estimate     SE  df lower.CL upper.CL
##  SSD_reversed - Control F - M         -0.1527 0.0311 3.9  -0.2397  -0.0656
##  Large - Control        F - M         -0.0005 0.0311 3.9  -0.0875   0.0866
##  Small - Control        F - M          0.0159 0.0311 3.9  -0.0712   0.1030
## 
## Results are averaged over the levels of: sampling 
## Degrees-of-freedom method: kenward-roger 
## Results are given on the log2 (not the response) scale. 
## Confidence level used: 0.95
```

I find this most helpful to plot. The contrast is on the $\mathrm{log}_2$ scale, so we are comparing differences. It is useful to add a line at 0 to help compare our estimated contrast (and its uncertainty) against the "null" of no difference. i.e. no change in the amount of sexual dimorphism across evolutionary treatments.


```r
plot(thorax_ssd_contrasts) + 
  geom_vline(xintercept = 0, lty = 2, alpha = 0.5) + 
    labs(x = "change in SSD relative to control lineages (log2)", y = "comparison") +
    theme_bw() + theme(text = element_text(size = 16))
```

![](Contrasts.notes_files/figure-html/unnamed-chunk-24-1.png)<!-- -->

We see a very clear effect of the evolutionary treatment that artificially selected for reversed dimorphism. As Jonathan and Ben mentioned in class, understanding the magnitude of this effect (how much change in dimorphism) on the log scale can take some getting used to for interpreting. So this may be worthwhile to backtransform to our response scale (micrometres). 

The backtransforming from the log scale is happening **after** the contrast (and confidence intervals) are computed. So, like we showed above, you can (to double check and make sure you understand it) take the (log2) contrast estimates and its confidence limits and plug each into $2^x$.  It also means we are examining the ratio (or ratio of ratios in this case), and our no difference of "0" on the $\mathrm{log}_2$ scale will be $2^0 = 1$ for the ratio.



```r
thorax_ssd_contrasts_ratios <- contrast(thorax_ssd[[1]], 
                                 interaction = c(selection = "trt.vs.ctrl1", sex = "pairwise"),
                                 by = NULL,type = "response")

confint(thorax_ssd_contrasts_ratios)
```

```
##  selection_trt.vs.ctrl1 sex_pairwise ratio     SE  df lower.CL upper.CL
##  SSD_reversed / Control F / M         0.90 0.0194 3.9    0.847    0.956
##  Large / Control        F / M         1.00 0.0215 3.9    0.941    1.062
##  Small / Control        F / M         1.01 0.0218 3.9    0.952    1.074
## 
## Results are averaged over the levels of: sampling 
## Degrees-of-freedom method: kenward-roger 
## Confidence level used: 0.95 
## Intervals are back-transformed from the log2 scale
```


Now we can plot these contrasts as ratios:

```r
plot(thorax_ssd_contrasts_ratios) + 
  geom_vline(xintercept = 1, lty = 2, alpha = 0.5) + 
    labs(x = "change in SSD relative to control lineages (ratio)", y = "comparison") +
    theme_bw() + theme(text = element_text(size = 16))
```

![](Contrasts.notes_files/figure-html/unnamed-chunk-26-1.png)<!-- -->



## links for other tutorials on contrasts

I like this one a fair bit, and it is goes through it all pretty gently
https://bookdown.org/pingapang9/linear_models_bookdown/chap-contrasts.html


This one goes through the logic as well using biologically relevant examples, discussing 
This one is an alternative explanation of the same ideas 
https://rstudio-pubs-static.s3.amazonaws.com/65059_586f394d8eb84f84b1baaf56ffb6b47f.html

Chapter 5 of the book by Irizarry and Love, Data Analysis for the Life Sciences with R [ https://doi-org.libaccess.lib.mcmaster.ca/10.1201/9781315367002]

overview of contrast codings 
https://rpubs.com/timflutre/tuto_contrasts

@schadHow2018

https://bbolker.github.io/mixedmodels-misc/notes/contrasts.pdf

## references
