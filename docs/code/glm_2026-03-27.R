library(ggplot2)

aids <- read.csv("../data/aids.csv")
aids <- transform(aids, date=year+(quarter-1)/4)
gg0 <- ggplot(aids,aes(date,cases))+geom_point()

gg1 <- gg0 + geom_smooth(method="glm",colour="red",
                         formula=y~x,
                         method.args=list(family="quasipoisson"))
g1 <- glm(cases~date, data = aids, 
           family=quasipoisson(link="log"))
library(MASS)
g2 <- glm.nb(cases~date, data = aids,
    control = glm.control(maxit=1000))

performance::check_model(g2)
## var = mu*(1+mu/theta)
summary(g2)
performance::check_model(g2)
library(DHARMa)
plot(simulateResiduals(g2))
g3 <- update(g2, . ~ poly(date, 2))

library(glmmTMB)
g4 <- glmmTMB(cases ~ poly(date,2),
        family = nbinom2,
        data = aids)
summary(g4)

plot(simulateResiduals(g4))
performance::check_model(g4)

library(dplyr)
lizards <- read.csv("../data/lizards.csv") |>
  mutate(total = grahami+opalinus, gprop = grahami/total)

g5 <- glm(cbind(grahami, opalinus) ~ light*time, data = lizards,
    family= quasibinomial)

g5B <- glm(gprop ~ light*time, data = lizards,
           weights = total,
          family= quasibinomial)
summary(g5)

g6 <- glmmTMB(cbind(grahami, opalinus) ~ light*time, data = lizards,
          family= betabinomial)

dotwhisker::dwplot(list(binom = g5, bbinom= g6, qb = g5B))
