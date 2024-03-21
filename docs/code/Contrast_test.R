lm_out <- function(x = modname) {
    cbind(as.matrix(summary(x)$coef[,1:3]),
          as.matrix(confint(x)) )}


## ----results='hide'-----------------------------------------------------------
library(lme4)
library(emmeans)
library(car)
library(ggplot2)
library(ggbeeswarm)


## -----------------------------------------------------------------------------
data(iris)


## -----------------------------------------------------------------------------
head(iris)

with(iris, table(Species))


## -----------------------------------------------------------------------------
ggplot(iris, aes(y = Sepal.Length, x = Petal.Length, col = Species)) +
   geom_point()


## -----------------------------------------------------------------------------
mod1 <- lm(Sepal.Length ~ Species,
           data = iris)


## -----------------------------------------------------------------------------
anova(mod1)


## -----------------------------------------------------------------------------
summary(mod1)


## -----------------------------------------------------------------------------
lm_out(mod1)


## -----------------------------------------------------------------------------
SL_means_Species <- with(iris, 
     tapply(Sepal.Length, Species, mean))

SL_means_Species


## -----------------------------------------------------------------------------
species_predictedVals <- unique(predict(mod1))

names(species_predictedVals) <- c("setosa", "versicolor", "virginica")

species_predictedVals 


## -----------------------------------------------------------------------------
SL_means_Species["versicolor"] - SL_means_Species["setosa"]

SL_means_Species["virginica"] - SL_means_Species["setosa"]


## -----------------------------------------------------------------------------
head(model.matrix( ~ iris$Species))


## -----------------------------------------------------------------------------
unique(model.matrix( ~ iris$Species))


## -----------------------------------------------------------------------------
Smat <- contrasts(as.factor(iris$Species))


## -----------------------------------------------------------------------------
Smat <- cbind(1, Smat)

Smat


## -----------------------------------------------------------------------------
Lmat <- solve(Smat)

print(Lmat)

print(solve(Lmat))
