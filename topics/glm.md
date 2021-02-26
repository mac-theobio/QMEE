---
title: Generalized linear models
author: Jonathan Dushoff and Ben Bolker
---

Introduction
============

Generalized linear models generalize the idea of linear models (!) by adding:

* a family (the responses don't have to be normally distributed)
* a link function (the linear predictor and the effect can be on different scales)

Like linear models, they are a very powerful set of tools depending on very specific assumptions, but at least they're more flexible than linear models.

Class materials
===============

-   [Main lecture notes](Generalized_linear_models.html)
    -   [slide version](Generalized_linear_models.slides.html)

<!--- This is how you make a comment
Resources
=========

-   Introductory
    -   [The model section from the R intro
        book](http://cran.r-project.org/doc/manuals/R-intro.html#Statistical-models-in-R)
    -   [Fridley examples and
        guidelines](http://plantecology.syr.edu/fridley/bio793/lm.html)
    -   [Rodriguez
        introduction](http://data.princeton.edu/R/linearModels.html)
    -   [Bolker
        book](http://www.math.mcmaster.ca/~bolker/emdbook/Bolker_proofs.pdf)
        (see Sec. 9.2)
    -   [Faraway linear
        models](http://cran.r-project.org/doc/contrib/Faraway-PRA.pdf)
        book draft
        -   [Book home page](http://www.maths.bath.ac.uk/~jjf23/LMR/)
    -   [Hector et
        al](http://onlinelibrary.wiley.com/doi/10.1111/j.1365-2656.2009.01634.x/pdf)
        on ANOVA for unbalanced data (i.e. "type III sums of
        squares" revisited)
    -   [Schielzeth](http://onlinelibrary.wiley.com/doi/10.1111/j.2041-210X.2010.00012.x/full) (2010)
        on centering and scaling in linear models
    -   [Murtaugh](http://www.esajournals.org/doi/abs/10.1890/0012-9658%282007%2988%5B56:SACIED%5D2.0.CO;2) (2007)
        on averaging in analysis of nested designs
    -   [O'Hara and
        Kotze](http://onlinelibrary.wiley.com/doi/10.1111/j.2041-210X.2010.00021.x/full) (2010)
        on not log-transforming count data
    -   ["The arcsine is
        asinine"](http://www.esajournals.org/doi/full/10.1890/10-0340.1):
        Warton and Hui on not arcsine-transforming proportion data
-->


Assignment
==========

Make a linear model for one or more of your hypotheses. 
Draw **and discuss** at least one of each of the following:

* diagnostic plot
* inferential plot (e.g., a coefficient plot, or something from `emmeans` or `effects`)

The assignment is due by sometime on Mon. 18 Feb.

* See the [assignment instructions](../admin/assignments.html)

