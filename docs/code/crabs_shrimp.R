## testing emmeans/marginaleffects on crabs/shrimp example
dd <- read.csv("data/culcita_volume.csv")
library(ggpubr)
library(ggbeeswarm)
library(emmeans)

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

library(marginaleffects)
avg_comparisons(m)

H <- do.call(cbind, my_contrasts)
avg_predictions(m, by = "ttt", hypothesis = H)

