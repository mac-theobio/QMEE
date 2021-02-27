---
title: Linear models
author: Jonathan Dushoff and Ben Bolker
---

Introduction
============

Linear models are a kind of [lamppost](../tips/lamppost_theory.html): a
very powerful set of tools for solving certain kinds of problems, using
certain kinds of assumptions.

Class materials
===============

-   [Main lecture notes](../lectures/Linear_models.notes.html)
    -   [slide version](../lectures/Linear_models.slides.html)
-   [Parameters](../lectures/Linear_model_parameters.notes.html)

Resources
=========

-   Introductory
    -   [The model section from the R intro book](http://cran.r-project.org/doc/manuals/R-intro.html#Statistical-models-in-R)
    -   [Fridley examples and guidelines](http://plantecology.syr.edu/fridley/bio793/lm.html)
    -   [Rodriguez introduction](http://data.princeton.edu/R/linearModels.html)
    -   [Bolker book](http://www.math.mcmaster.ca/~bolker/emdbook/Bolker_proofs.pdf)
        (see Sec. 9.2)
    -   [Faraway linear models](http://cran.r-project.org/doc/contrib/Faraway-PRA.pdf)
        book draft
        -   [Book home page](http://www.maths.bath.ac.uk/~jjf23/LMR/)
    -   [Hector et al](http://onlinelibrary.wiley.com/doi/10.1111/j.1365-2656.2009.01634.x/pdf)
        on ANOVA for unbalanced data (i.e. "type III sums of squares" revisited)
    -   [Schielzeth](http://onlinelibrary.wiley.com/doi/10.1111/j.2041-210X.2010.00012.x/full) (2010)
        on centering and scaling in linear models
    -   [Murtaugh](http://www.esajournals.org/doi/abs/10.1890/0012-9658%282007%2988%5B56:SACIED%5D2.0.CO;2) (2007)
        on averaging in analysis of nested designs

-   Discussion
    -   [Hurlbert's classic Pseudo-replication paper](http://www.uvm.edu/~ngotelli/Bio%20264/Hurlbert.pdf)
    -   [Exegeses on linear models](http://www.stats.ox.ac.uk/pub/MASS3/Exegeses.pdf) (advanced)

Assignment
==========

Make a linear model for one or more of your hypotheses. 
Draw **and discuss** at least one of each of the following:

* diagnostic plot
* inferential plot (e.g., a coefficient plot, or something from `emmeans` or `effects`)
