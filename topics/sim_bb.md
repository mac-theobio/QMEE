## stages

* simulate experimental design (sample size, distribution of covariates, balance, missing values, etc.): `expand.grid`, `sample`, `seq()`, `rep()`, `r*` functions
* compute moments (means/SDs of response variables) from covariates and parameters (effects)
* sample means/SDs of response variables (`r*` functions)

## parameterizations

* need to know something about the parameters of distributions you're going to smulate from
* often need to translate from mean+SD or mean+CV (*coefficient of variance*) to the parameters that R uses
* distributions
   * Gaussian is easy/familiar (mean, SD)
   * Poisson is easy (mean)
   * negative binomial: need to specify mean as `mu`; `size` is the dispersion parameter, smaller means more variability (mean = $\mu (1+\mu/k)$).
   * log-Normal: `meanlog`, `sdlog` are the mean and SD *on the log scale*
   * Gamma: *shape* parameter is $1/\sqrt{\textrm{CV}}$; *scale* parameter is (mean/shape)

## tools

* in general `simulate` samples new values *based on a fitted model*
* however, `simulate()` (in `lme4`) and `simulate_new()` (in `glmmTMB`) can simulate values *de novo*, by specifying covariates and parameter values

For example:

```{r}
data("sleepstudy", package = "lme4")
set.seed(101)
library(glmmTMB)
y <- simulate_new( ~ Days + (Days | Subject),
                  nsim = 1,
                  family = "gaussian",
                  newdata = sleepstudy, ## covariates
                  newparams = list(
                      beta = c(250, 10),   ## intercept and slope (pop-level)
                      ## log-SD of intercept and slope; transformed correlation
                      theta = c(2, 1, 0),
                      betad = 2)  ## log-SD of residual variation
                  )[[1]]  ## simulate_new always returns a list
```

The hardest part is understanding the random-effects parameters (`theta`); see [here](https://glmmtmb.github.io/glmmTMB/articles/covstruct.html) or ask us.

Since `glmmTMB` can handle models with or without random effects, and a wide range of GLM-type distributions, this may be a good way to simulate responses once you've simulated your experimental design/covariate distribution.
