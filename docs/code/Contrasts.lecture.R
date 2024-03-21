## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
options(digits = 3, show.signif.stars = FALSE, show.coef.Pvalues = TRUE)


## ----results='hide'-----------------------------------------------------------
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

Lmat


## -----------------------------------------------------------------------------
species_predictedVals


## -----------------------------------------------------------------------------
species_predictedVals[2] - species_predictedVals[1]


## -----------------------------------------------------------------------------
species_predictedVals[3] - species_predictedVals[1]


## -----------------------------------------------------------------------------
lm_out(mod1)


## -----------------------------------------------------------------------------
iris$Species2 <- relevel(iris$Species, "versicolor")


## -----------------------------------------------------------------------------
model.matrix(~iris$Species2)[c(1:2,51:52, 101:102),]


## -----------------------------------------------------------------------------
cbind(1, contrasts(as.factor(iris$Species2)))


## -----------------------------------------------------------------------------
mod1_alt <- lm(Sepal.Length ~ Species2,
           data = iris)

lm_out(mod1_alt)


## -----------------------------------------------------------------------------
unique(model.matrix(mod1))


## -----------------------------------------------------------------------------
unique(model.matrix(mod1_alt))


## -----------------------------------------------------------------------------
species_predictedVals


## -----------------------------------------------------------------------------
species_predictedVals["versicolor"] - mean(species_predictedVals[c("setosa", "virginica")])


## -----------------------------------------------------------------------------
1*species_predictedVals["versicolor"] - (1/2)*species_predictedVals["setosa"] - (1/2)*species_predictedVals["virginica"] 


## -----------------------------------------------------------------------------
contrast_vector_example <- c(1, -0.5, -0.5)

sum(contrast_vector_example)


## -----------------------------------------------------------------------------
contrasts(iris$Species)

contrasts(iris$Species2)


## -----------------------------------------------------------------------------
levels(iris$Species)

setosa_virginica <- c(1, 0, -1)  # setosa VS virginica


versicolor_VS_others <- c(-0.5, 1, -0.5)


## -----------------------------------------------------------------------------
summary(mod1)

spp_em <- emmeans(mod1, ~Species)   # means
spp_em 

plot(spp_em) +
  theme_bw() +
  theme(text = element_text(size = 16))


## -----------------------------------------------------------------------------
iris_custom_contrasts <- contrast(spp_em, 
         list(versicolor_VS_others = versicolor_VS_others, 
              virginica_VS_setosa = c(1, 0, -1)))

iris_custom_contrasts


## -----------------------------------------------------------------------------
confint(iris_custom_contrasts )


## -----------------------------------------------------------------------------
plot(iris_custom_contrasts) +
         geom_vline(xintercept = 0, lty = 2 , alpha = 0.5) +
         theme_bw() +
         theme(text = element_text(size = 20))
         


## -----------------------------------------------------------------------------
contrast(spp_em, method = "pairwise")

pairs(spp_em) # same as above, just a shortcut function.

confint(pairs(spp_em))


## -----------------------------------------------------------------------------
plot(pairs(spp_em)) +
         geom_vline(xintercept = 0, lty = 2 , alpha = 0.5) +
         xlab("Estimated difference in Sepal Lengths")


## -----------------------------------------------------------------------------
pairs(spp_em, exclude = 2)


## -----------------------------------------------------------------------------
load("../data/contrast_tutorial_dat.RData")

size_dat <- contrast_tutorial_dat


## -----------------------------------------------------------------------------
head(size_dat)


## -----------------------------------------------------------------------------
ggplot(size_dat, 
       aes( y = length, x = selection:sex, col = sex, shape = replicate)) +
  geom_quasirandom(alpha = 0.8, size = 1.4) +
  labs( y = "length (mm)") +
  ggtitle("thorax") +
  theme_classic() +
  theme(text = element_text(size = 18))


## -----------------------------------------------------------------------------
mod1_thorax <- lmer(log2(length*1000) ~ (sex + selection + sampling)^2 + (0 + sex| replicate:selection),
           data = size_dat, 
           subset = repeat_measure == "1")


## -----------------------------------------------------------------------------
Anova(mod1_thorax)


## -----------------------------------------------------------------------------
summary(mod1_thorax)


## -----------------------------------------------------------------------------
thorax_emm <- emmeans(mod1_thorax, specs = ~ sex | selection)

thorax_emm

plot(thorax_emm,
     xlab = "model estimates, thorax length, log2 microM") +
  theme_bw() +
  theme(text = element_text(size = 16))


## -----------------------------------------------------------------------------
thorax_emm_response <- emmeans(mod1_thorax, specs = ~ sex | selection, type = "response")

thorax_emm_response

plot(thorax_emm_response,
     xlab = "model estimates, thorax length, microM") +
  theme_bw() +
  theme(text = element_text(size = 16))


## -----------------------------------------------------------------------------
thorax_vals <- emmeans(mod1_thorax, 
             specs = ~ sex | selection)

SSD_contrasts_treatment <- pairs(thorax_vals)

SSD_contrasts_treatment

confint(SSD_contrasts_treatment)


## -----------------------------------------------------------------------------
plot(SSD_contrasts_treatment) + 
  geom_vline(xintercept = 0, lty = 2, alpha = 0.5) + 
  labs(x = "sexual size dimorphism") +
  theme_bw() +
  theme(text = element_text(size = 16))


## -----------------------------------------------------------------------------
thorax_ssd <- emmeans(mod1_thorax,  pairwise ~ sex*selection) # warning is letting you know these are not of general use. We only do this as we are forming an interaction contrast.

thorax_ssd_contrasts <- contrast(thorax_ssd[[1]], 
                                 interaction = c(selection = "trt.vs.ctrl1", sex = "pairwise"),
                                 by = NULL)


thorax_ssd_contrasts

confint(thorax_ssd_contrasts)

plot(thorax_ssd_contrasts) + 
  geom_vline(xintercept = 0, lty = 2, alpha = 0.5) + 
  labs(x = "change in SSD relative to control lineages", y = "comparison") +
  theme_bw() +
  theme(text = element_text(size = 16))

