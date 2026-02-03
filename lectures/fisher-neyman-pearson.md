---
title: 'Fisherian' vs 'Neyman-Pearson' p-values
bibliography: qmee.bib
---

## @cromeResearching1997

> Perhaps the average user of significance tests, without knowing it, smears him- or herself over the three major statistical schools, and disobeys the rules of each: we act as if Fisherian and often believe we are; attempt Neymann-Pearson approaches, but never properly; and interpret tests in a Bayesian fashion.

> In theory, hypothesis testing is not about decision making--decision theory is available for that. In practice, however, statistics and hypothesis testing cannot wriggle out of the patently obvious fact theat they can be used, and often are used, as decision-making procedures

## Fisherian

* $p$-values as strength of evidence against (never **for**!) a scientific hypothesis
* report exact $p$-value
* sometimes truncated if "very small" (e.g. R reports "< 2.2e-16"; can get exact values if you need them

## Neyman(n)-Pearson

* decision-theoretic approach
* set $\alpha$ (rejection) level **ahead of time**
* **specify alternative hypothesis** ($H_A$) ahead of time
* if everything else is correct (e.g. test assumptions hold), can say that decisions to  have a correct *error rate*
* underlies power calculations as well (set power = $1-\beta$ = prob of correctly rejecting $H_0$)

## References
