Introduction
============

If we are performing a lot of tests, we want to control the probability
of getting a false positive at a higher level than that of individual
tests.

We do this by defining *families* of tests.

It's not always so clear what a family should be. By convention, a set
of pairwise comparisons is defined as a family. Doing the same
comparison on a large set of genes is usually defined as a family. Doing
several related comparisons is often not defined as a family.

What if we do a large linear model, keeping all the predictors?

-   People usually don't worry about multiple comparisons if they have
    one test per parameter, but it's not so clear why.
-   If you have categorical variables, one test per parameter covers
    pre-planned contrasts, but not full pairwise comparisons

Family-level error
==================

We want to define a *family* of tests, and perform them so that the
probability of seeing any significance at all under the null hypothesis
is \$\$&lt;\\alpha\$\$.

Bonferroni
----------

The simplest approach. Divide the threshold \$\$\\alpha\$\$ by
\$\$T\$\$, the number of tests in the family.

Equivalently, multiply each of the P values by \$\$T\$\$.

This is very simple, and very conservative, because the total
probability of an error under the null hypothesis is
\$\$&lt;\\alpha\$\$.

-   In fact, the expected *number* of errors under then null hypothesis
    is \$\$\\alpha\$\$.

Holm
----

Sometimes called Bonferroni-Holm, by those who want to cash in on the
credibility of Bonferroni.

-   If the lowest P value is significant when multiplied by \$\$T\$\$,
    B-H multiplies the next lowest by \$\$T-1\$\$. And so on.
-   This actually seems to maintain family-level error of
    \$\$\\alpha\$\$ even in the worst case. Therefore, there is no
    reason to use Bonferroni.

Hochberg/Hommel
---------------

Two similar tests that effectively assume the P values in the family are
independent.

-   This means that they are conservative if there are *positive*
    associations between P values, but suspect when there are *negative*
    associations

Tukey
-----

A particular family-level test meant to apply to levels of a single
factor.

False discovery rate approaches
===============================

FDR is a relatively new and fairly slick technique. It attempts to
control the expected *proportion* of identified results which are false.
FDR provides more power than family-level corrections, but is less
conservative.

Implementation in R
===================

-   `p.adjust()` takes a list of P values, and returns a list of
    adjusted P values
    -   It can do Holm, Hochberg and BY (an FDR method), among others
    -   `pairwise.t.test` calls `p.adjust` to compare a set of factor
        levels, for example


-   TukeyHSD can be applied to `aov` objects. `aov` uses `lm`, but
    returns things in a slightly different way


-   `cld` in package multcomp produces "compact letter displays".
    -   \$\$1\^a, 2\^{ab}, 3\^b, 4\^c\$\$
    -   JD hasn't tried this yet

