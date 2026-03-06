library(tidyverse)
dd <- (read.table("data/Elston2001_tickdata.txt", header=TRUE)
       |> mutate(across(c(YEAR, LOCATION, BROOD), factor))
       |> mutate(cHEIGHT = (HEIGHT-mean(HEIGHT))/100)
       )

with(dd, table(YEAR,  LOCATION))
library(lme4)
with(dd, isNested(BROOD, LOCATION))
library(ggplot2)
ggplot(dd, aes(HEIGHT, TICKS, colour=BROOD)) + 
  geom_point() +
  geom_smooth(aes(group = YEAR))

library(lme4)
mod1 <- glmer(TICKS ~ cHEIGHT*YEAR + 
                (1  | LOCATION / BROOD),
              data = dd,
              family = poisson)
summary(mod1)
deviance(mod1)/df.residual(mod1)
## observation-level random effects
mod2 <- update(mod1, . ~ .+ (1|INDEX))
summary(mod2)

aa <- allFit(mod2)
summary(aa)$sdcor

library(DHARMa)
plot(simulateResiduals(mod1))

## -> negative binomial
library(glmmTMB)
mod3 <- glmmTMB(TICKS ~ cHEIGHT*YEAR + 
                (1  | LOCATION / BROOD),
              data = dd,
              family = nbinom2)

cc <- confint(mod2, "theta_")
