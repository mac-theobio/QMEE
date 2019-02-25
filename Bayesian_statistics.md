Introduction
------------

Bayesian statistics is a completely different paradigm for thinking
about statistics. It involves making a complete probability model for
what you think *did* happen, rather than constructing a framework to
rule out things that *didn't* happen (e.g., this result arising by
chance). It has important advantages (conceptual simplicity, power,
ability to combine information from different sources), and important
disadvantages (requires more assumptions, answers may be difficult to
find).

As a scientist you are probably well advised to take a pragmatic
approach by using whatever statistical technique seems best suited to
your problem. You are definitely well advised to make a good-faith
effort to understand the foundations (particularly the philosophical
foundations) of the methods you are using (as well as the methods your
colleagues are using, since you will have to be able to evaluate these
intelligently.

Resources
---------

-   Material
    -   [Bayesian statistics/Lecture notes](Bayesian_statistics_Lecture_notes.html)
    -   [Bayesian regression example](Bayesian_example.html)

-   Introductory
    -   [Standing statistics right side
        up](http://www.annals.org.libaccess.lib.mcmaster.ca/content/130/12/1019.long)
    -   [Frameworks for statistical inference and estimation (Notes from UF)](https://web.archive.org/web/20100616211430/http://www.biology.ufl.edu/ip/2009Fall/notes/ip-bayes-etc.html)
    -   [Fisher, Jeffreys and Neyman](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.167.4064&rep=rep1&type=pdf)


-   Discussion
    -   [What is a statistical model?](http://www.jstor.org/pss/1558705)
        by Peter McCullagh. Aimed at mathematicians and
        mathematical statisticians.
    -   Gelman with [more discussion and
        examples](http://www.stat.columbia.edu/~gelman/research/published/signif4.pdf)
-   ["The first data analysis should be
    journalistic"](http://www.jstor.org/stable/2269593): Edwards 1996
    *Ecological Applications*
-   ["Should ecologists become
    Bayesians?"](http://www.jstor.org/stable/2269594): strong
    anti-Bayesian view, Dennis 1996 "Ecological Applications"
    ("Bayesianism means never having to say you're wrong";
    "Bayesianism equals scientific relativism, which is ... a sort
    of intellectual
    [Calvinball](http://en.wikipedia.org/wiki/Calvin_and_Hobbes#Calvinball)")


-   Software
    -   [JAGS](http://mcmc-jags.sourceforge.net/) (just another Gibbs
        sampler); software for doing Bayesian MCMC estimation
    -   The
        [rjags](http://cran.r-project.org/web/packages/rjags/index.html)
        and
        [R2jags](http://cran.r-project.org/web/packages/R2jags/index.html)
        packages: interfaces between R and JAGS
    -   [Some tips on JAGS and rjags](http://www.johnmyleswhite.com/notebook/2010/08/20/using-jags-in-r-with-the-rjags-package/)
    -   [coda](http://cran.r-project.org/web/packages/coda/index.html)
        (**co**nvergence **d**i**a**gnostics) is an R package for analyzing
        MCMC fits.

Assignment
----------

Install JAGS (and either `rjags` or `R2jags`). Use `jags` to fit a Bayesian model to your data, in some way that at least roughly makes sense. Discuss your prior assumptions, and compare your simple fit to an analogous frequentist fit.


