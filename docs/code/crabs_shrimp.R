## testing emmeans/marginaleffects on crabs/shrimp example
data("culcitalvolume", package = "lme4") ## devel version
library(ggpubr)
library(ggbeeswarm)
library(emmeans)

ggplot(culcitalvolume, aes(ttt, predvolume)) +
  geom_boxplot() +
  geom_beeswarm() +
  stat_pwc()

m <- lm(predvolume ~ ttt, culcitalvolume)
plot(contrast(emmeans(m, ~ ttt),
         list(symbiont = c(-1, 1/3, 1/3, 1/3),
              crabs_vs_shrimp = c(0, 1, -1, 0),
              twodiff = c(0, -1/2, -1/2, 1),
              interact = c(-1, 1/2, 1/2, 

m2 <- lm(predvolume ~ crab*shrimp, culcitalvolume)
summary(m2)

