dd <- read.csv("aids.csv")
dd <- transform(dd, time=(year-min(year)+(quarter-1)/4))
library(ggplot2)
ggplot(dd,aes(time,cases)) + 
  geom_point() +
  geom_smooth(method="glm",
    formula=y~poly(x,2),
    method.args=list(family=
                       quasipoisson(link="log")),
    fill="blue")
# +
#   geom_smooth(method="glm",
#               method.args=list(family=quasipoisson(link="log")),
#               colour="red")
  
m1 <- glm(cases~time,
          family=poisson(link="log"),
          data=dd)
library(broom)
tidy(m1)
tidy(m1,exponentiate=TRUE)
library(dotwhisker)
dwplot(m1)
## ??? talk to maintainers.

summary(m1)

m1Q <- update(m1, family=quasipoisson(link="log"))
summary(m1Q)

drop1(m1Q,test="F")
predict(m1Q)
predict(m1Q,type="response")

pframe <- data.frame(time=10.91111)
predict(m1Q, type="response", newdata=pframe)

plot(m1Q)

