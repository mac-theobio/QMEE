---
title: Bayesian approaches
---

# Introduction

## Bayes Theorem 

* Bayes theorem is what we used for the MMV calculation

* If $A_i$ are *alternative events* (exactly one must happen), then:
	* $\mbox{Pr}(A_i|B) = \frac{\mbox{Pr}(B|A_i) \mbox{Pr}(A_i)}{\sum{\mbox{Pr}(B|A_j) \mbox{Pr}(A_j)}}$
	* $\mbox{Pr}(A_i)$ the *prior* probability of $A_i$
	* $\mbox{Pr}(A_i|B)$ is the *posterior* probability of
	 $A_i$, given event $B$

* People argue about Bayesian inference, but nobody argues about Bayes
	 theorem

## Bayesian inference

* Go from a *statistical model* of how your data are generated, to a
	probability model of parameter values
	* Requires *prior* distributions describing the assumed likelihood
	 of parameters before these observations are made
	* Use Bayes theorem to go from probability of the data given
	 parameters to the probability of parameters given data

* Once we have a posterior distribution, we can calculate a best guess for each parameter
	* Mean, median or mode
	* Only median is scale-independent

## Confidence intervals

* We do hypothesis tests using "credible intervals" -- these are like confidence intervals, except that we really believe (relying on our assumptions) that there is a 95% chance that the value is in the credible interval
	* There are a lot of ways to do this. You need to decide in advance.
	* _Quantiles_ are principled, but not easy in >1 dimension
	* Highest posterior density is straightforward, but scale-dependent

* Example, a linear relationship is significant if the credible interval for the slope does not include zero

* A difference between groups is significant if the credible interval for the difference does not include zero

## Advantages

* Assumptions more explicit

* Probability statements more straightforward

* Very flexible

* Can combine information from different sources

## Disadvantages

* More assumptions required

* More difficult to calculate answers
	* easy problems are easy
	* medium problems are hard [compared to the frequentist analog]
	* hard problems are possible [not always true for frequentist analog]

# Assumptions

## Prior distributions

* Typically, start with a prior distribution that has little
	"information"
	* Let the data do the work

* This often means a normal (or lognormal, or gamma) with a very large
	variance
	* We can test for sensitivity to this choice

* Can also use a uniform distribution (on log, or linear scale) with
	 very broad coverage

## Examples

* "Complete ignorance" can be harder to specify than you think

	* Linear vs. log scale: do we expect the probability of being
	     between 10 and 11 grams to be the same as the prob. of being
	     between 100 and 101 grams, or the same as the prob. of being
	     between 100 and 110 grams??

	* Linear vs. inverse scale: if we are waiting for things to happen, do we pick our prior on the time scale (number of minutes per bus) or the rate scale (number of buses per minute)?

	* Discrete hypotheses: subdivision (nest predation example: do we
	     consider species separately, or grouped by higher-level taxon?)

## Improper priors

* There is no uniform distribution over the real numbers

* But for Bayesian analysis, we can pretend that there is

	* Using this sort of improper prior poses no problems (over and above the problems of specifying a uniform prior in the first place), as long as we can guarantee that the posterior distribution exists

## Statistical models

* A statistical model allows us to calculate the *likelihood* of the
	data based on parameters

	* Relationships between quantities, e.g.:

	* X is linearly related to Y

	* The variance of X is linearly related to Z

	* Distributions

	* X has a Poisson (or normal, or lognormal) distribution

# Making a probability model

## Assumptions

* We need enough assumptions to actually calculate the "likelihood" of our data given parameters

* To make a probability model we need prior distributions for all of
	the parameters we wish to estimate

* We then need to make explicit assumptions about how our data are
	generated, and calculate a likelihood for the data corresponding to
	any set of parameters

## An analytic example

* We count events over a period of time, and would like credible intervals (or a whole posterior distribution) for the underlying rate (assuming events are independent).

* For each rate, our likelihood of observing $N$ events in time $T$ if the true rate is $r$ is a Poisson distribution with mean $rT$:

	* $\frac{(rT)^N \exp(-rT)}{N!}$

* We choose an improper, uniform prior over $\log r$,
	 equivalent to $\pi(r) = 1/r$.

* The posterior distribution is then proportional to:
	* $(rT)^{N-1} \exp(-rT)$, which gives a Gamma distribution
	     with mean $N/T$ (the observed rate), and CV $1/\sqrt{N}$.


This example is in the category of "easy problems"; the math is a bit
hard (Calc II level), but no harder than the equivalent math for a
frequentist approach, and the actual procedure is easy once you know
how.

# MCMC methods

* Bayesian methods are very flexible

* We can write down reasonable priors, and likelihoods, to cover a
	wide variety of assumptions and situations

* Unfortunately, we usually can't *integrate* -- calculate the
	denominator of Bayes' formula

* Instead we use *Markov chain Monte Carlo* methods to sample randomly
	from the posterior distribution

	* Simple to do, but hard to know how long you have to simulate to
	 get a good sample of the posterior distribution

## MCMC sampling

* Rules that assure that we will visit each point in parameter space
	 in proportion to its likelihood ... eventually

* Checking convergence:

	* Look at your parameter estimates: do they seem to have settled to bouncing back and forth) rather than going somewhere?

	* Repeat the whole process with a different starting point (in parameter space): do these "chains" converge?

## Packages

* There is a lot of software, including R packages, that will do MCMC
	sampling for you

* We will give you examples
	* [Bayesian regression example](Bayesian_regression_example.html) using rjags

# Sampling from the posterior

## Great power ⇒ great responsibility

* Once you have calculated (or estimated) a Bayesian posterior, you can calculate whatever you want!
	* In particular, you can attach a probability to any combination of the parameters
	* You can simulate a model forward in time and get credible intervals not only for the parameters, but what you expect to happen

## Live coding example

* [R script](fev.R)
* [model file](fev.bug)

