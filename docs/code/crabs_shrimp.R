## testing emmeans/marginaleffects on crabs/shrimp example
dd <- read.csv("data/culcita_volume.csv")
library(ggpubr)
library(ggbeeswarm)
library(emmeans)
library(dplyr)
library(marginaleffects)

gg0 <- ggplot(dd, aes(ttt, predvolume)) +
  geom_boxplot(fill = "gray") +
  geom_beeswarm()

plot(gg0)

plot(gg0 + ggpubr::stat_pwc())

m <- lm(predvolume ~ ttt, dd)

## what contrasts do we want?
## effect of symbiont = (average of symb ttt - control)
## crabs vs shrimp = crabs - shrimp
## effect of two vs one symbionts = both - (average of crabs/shrimp)
my_contrasts <-	list(symbiont = c(-1, 1/3, 1/3, 1/3),
       crabs_vs_shrimp = c(0, 1, -1, 0),
       twodiff = c(0, -1/2, -1/2, 1)
)

refline <- geom_vline(xintercept = 0, lty = 2)
cc <- contrast(emmeans(m, specs = ~ ttt), my_contrasts)
print(cc)
plot(cc) + refline

## interaction might not be the most useful way to look at this either ...
m2 <- lm(predvolume ~ crab*shrimp, dd)
summary(m2)
dotwhisker::dwplot(m2) + refline


avg_comparisons(m)

H <- do.call(cbind, my_contrasts)
avg_predictions(m, by = "ttt", hypothesis = H)

###
ddL <- read.csv("data/culcitalogreg.csv")
ddL_sum <- (ddL  
  |> summarise(across(predation,
                      .fns = list(pred = sum,
                                  N = length),
                      .names = "{.fn}"),
               .by = c(ttt.1, crab, shrimp))
  |> mutate(prop = pred/N)
)

library(DHARMa)
mb <- glm(predation ~ crab*shrimp, family = binomial, data = ddL)

plot(simulateResiduals(mb))
performance::check_model(mb)

## what contrasts do we want?
## effect of symbiont = (average of symb ttt - control)
## crabs vs shrimp = crabs - shrimp
## effect of two vs one symbionts = both - (average of crabs/shrimp)
my_contrasts <-	list(symbiont = c(-1, 1/3, 1/3, 1/3),
       crabs_vs_shrimp = c(0, 1, -1, 0),
       twodiff = c(0, -1/2, -1/2, 1)
)

avg_predictions(mb, by = c("crab", "shrimp"))
avg_comparisons(mb, by = c("crab", "shrimp"))

mbs <- glm(cbind(pred, N-pred) ~crab*shrimp, family = binomial,
    data = ddL_sum)
confint(mbs)

mbs2 <- glm(cbind(pred, N-pred) ~ttt.1, family = binomial,
    data = ddL_sum)

cc <- contrast(emmeans(mbs2, specs = ~ ttt.1), my_contrasts, type = "response") +

plot(cc) + scale_x_log10() +   geom_vline(xintercept = 1, lty = 2)

