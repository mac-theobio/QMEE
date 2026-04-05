## analyzing tick data from:
# Elston, D. A., R. Moss, T. Boulinier, C. Arrowsmith, and X. Lambin. “Analysis of Aggregation, a Worked Example: Numbers of Ticks on Red Grouse Chicks.” Parasitology 122, no. 05 (2001): 563–69. https://doi.org/10.1017/S0031182001007740.
## see also https://bbolker.github.io/mixedmodels-misc/ecostats_chap.html


library(tidyverse); theme_set(theme_bw())
## we would want lmerTest pkg if we were doing LMMs
## (to get denominator df/p-values)
library(lme4)
library(reformulas) ## for isNested()
library(glmmTMB)
library(DHARMa)
library(performance)
library(ggalt) ## for geom_encircle()
library(broom.mixed)
## get data

dd <- (read.table("data/Elston2001_tickdata.txt", header=TRUE)
  |> mutate(across(c(YEAR, LOCATION, BROOD), factor))
  ## centred/scaled height
  ## (scale by 100m rather than by 1sd for interpretability)
  |> mutate(csHEIGHT = (HEIGHT-mean(HEIGHT))/100)
)

## explore structure
with(dd, table(LOCATION, YEAR) |> head())
with(dd, reformulas::isNested(BROOD, LOCATION)) ## TRUE
with(dd, reformulas::isNested(INDEX, BROOD))    ## TRUE

## too-clever plot
ggplot(dd, aes(HEIGHT, TICKS)) + 
  stat_sum(alpha = 0.8) + 
  geom_smooth(aes(colour = YEAR)) +
  ## poorly documented
  ggalt::geom_encircle(aes(group = BROOD), fill = "black",
                       colour = NA, alpha = 0.2,
                       expand = 0.01, spread = 0.01) +
  scale_size(breaks = c(1, 2, 5, 10)) +
  scale_y_continuous(trans = "log1p") ## log(1+x)  scaling

## first model: BROOD nested within LOCATION
mod1 <- glmer(TICKS ~ csHEIGHT*YEAR + 
                (1  | LOCATION / BROOD),
              data = dd,
              family = poisson)

## 
summary(mod1)

## check overdispersion
deviance(mod1)/df.residual(mod1)

## what does DHARMa think?
plot(simulateResiduals(mod1))

## what does check_model think?
performance::check_model(mod1)
## not too bad except for top right plot (which I'm not sure I
## trust anyway)

## observation-level random effects
## would be clearer with (1|LOCATION/BROOD/INDEX) but this
## is equivalent since broods are uniquely labeled
mod2 <- update(mod1, . ~ .+ (1|INDEX))
summary(mod2)

## convergence warning

## try all optimizers ...
aa <- allFit(mod2)
## random effect SDs (and correlations, if there were any)
##  are all very similar, so we're probably OK
summary(aa)$sdcor

## trying glmer.nb
## no family(), no INDEX random effect
## (overdispersion is handled by neg binom distribution)
system.time(
  mod3 <- glmer.nb(TICKS ~ csHEIGHT*YEAR + 
                     (1  | LOCATION / BROOD),
                   data = dd)
)
##  24 seconds on my machine

## alternative: with glmmTMB (almost instantaneous)
mod4 <- glmmTMB(formula(mod1),
              data = dd,
              family = nbinom2)
## almost the same (0.1 log likelihood units is not much)
logLik(mod3)
logLik(mod4)

## confidence intervals of random effect terms
## verbose tracing output to show progress (slow)
system.time(
  cc <- confint(mod2, "theta_", signames = FALSE, verbose = 1)
)
## 144 seconds
## the LOCATION SD is most uncertain (0-0.79); most likely because
## we have the fewest locations (63), so the smallest amount of data
## with which to compute a variance ...

## another way to do this (slightly more convenient for plotting etc.)
## just as slow (doing the same computations under the hood)
cc2 <- broom.mixed::tidy(mod2, effects = "ran_pars",
                         conf.int = TRUE, conf.method = "profile") |>
  ## order levels sensibly
  mutate(across(group,
                ~forcats::fct_inorder(factor(.))))

ggplot(cc2, aes(group, estimate)) +
  geom_pointrange(aes(ymin= conf.low, ymax = conf.high))
