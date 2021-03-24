## Weak/uninformative priors

* first step
* results still depend on scaling
* may cause numerical problems if data are weak
* more likely to need to specify initial values rather than sampling them from prior
* unrestricted (positive or negative, e.g. slopes) parameters: Normal with mean 0, "large" SD/small precision
* positive parameters (e.g. precision): half-Normal (or half-t/half-Cauchy), or gamma with small shape parameter and matching small rate parameter (mean=shape/rate)

## Regularizing priors

* probably more sensible
* neutral (e.g. centered at zero for slopes, between-group differences
* dispersion (SD etc.) small enough to exclude unrealistic values, limit overfitting

## Informed priors

* values taken from prior studies etc.
* (see McCarthy examples)
