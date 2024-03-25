## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
options(digits = 3, show.signif.stars = FALSE, show.coef.Pvalues = TRUE)


## ----lm-out,  results='hide'--------------------------------------------------
lm_out <- function(x = modname) {
    cbind(as.matrix(summary(x)$coef[,1:3]),
          as.matrix(confint(x)) )}


## ----pkgs, results='hide', message = FALSE------------------------------------
library(lme4)
library(emmeans)
library(car)
library(ggplot2)
library(ggbeeswarm)


## ----load-data----------------------------------------------------------------
data(iris)


## ----check-iris---------------------------------------------------------------
head(iris)

with(iris, table(Species))


## ----iris-plot----------------------------------------------------------------
ggplot(iris, aes(y = Sepal.Length, x = Petal.Length, col = Species)) +
   geom_point()


## ----lm1----------------------------------------------------------------------
mod1 <- lm(Sepal.Length ~ Species,
           data = iris)


## ----iris_anova---------------------------------------------------------------
anova(mod1)


## ----iris-summary-------------------------------------------------------------
summary(mod1)


## ----iris-lmout---------------------------------------------------------------
lm_out(mod1)


## ----meansepal-by-species-----------------------------------------------------
SL_means_Species <- with(iris, 
     tapply(Sepal.Length, Species, mean))

SL_means_Species


## ----compare-means------------------------------------------------------------
species_predictedVals <- unique(predict(mod1))

names(species_predictedVals) <- c("setosa", "versicolor", "virginica")

species_predictedVals 


## ----mean-diffs---------------------------------------------------------------
SL_means_Species["versicolor"] - SL_means_Species["setosa"]

SL_means_Species["virginica"] - SL_means_Species["setosa"]


## ----modelmat-----------------------------------------------------------------
head(model.matrix( ~ iris$Species))


## ----meancomp2----------------------------------------------------------------
unique(model.matrix( ~ iris$Species))


## ----check-contrasts----------------------------------------------------------
Smat <- contrasts(as.factor(iris$Species))


## ----add-intercept------------------------------------------------------------
Smat <- cbind(1, Smat)

Smat


## ----invert-------------------------------------------------------------------
Lmat <- solve(Smat)

Lmat


## ----predictvals--------------------------------------------------------------
species_predictedVals


## ----versicolor-diff----------------------------------------------------------
species_predictedVals[2] - species_predictedVals[1]


## ----virginica-diff-----------------------------------------------------------
species_predictedVals[3] - species_predictedVals[1]


## ----mod1-lmout---------------------------------------------------------------
lm_out(mod1)


## ----relevel------------------------------------------------------------------
iris$Species2 <- relevel(iris$Species, "versicolor")


## ----relevel-ex---------------------------------------------------------------
model.matrix(~iris$Species2)[c(1:2,51:52, 101:102),]


## ----relevel-contrasts--------------------------------------------------------
cbind(1, contrasts(as.factor(iris$Species2)))


## ----relevel-refit------------------------------------------------------------
mod1_alt <- lm(Sepal.Length ~ Species2,
           data = iris)

lm_out(mod1_alt)


## ----modelmat-0---------------------------------------------------------------
unique(model.matrix(mod1))


## ----new-modelmat-------------------------------------------------------------
unique(model.matrix(mod1_alt))


## ----predvals-again-----------------------------------------------------------
species_predictedVals


## ----predvals-comp------------------------------------------------------------
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


## ----emm1---------------------------------------------------------------------
summary(mod1)

spp_em <- emmeans(mod1, ~Species)   # means
spp_em 

plot(spp_em) +
  theme_bw() +
  theme(text = element_text(size = 16))


## ----emm_custom1--------------------------------------------------------------
iris_custom_contrasts <- contrast(spp_em, 
         list(versicolor_VS_others = versicolor_VS_others, 
              virginica_VS_setosa = c(1, 0, -1)))

iris_custom_contrasts


## ----emm_confint--------------------------------------------------------------
confint(iris_custom_contrasts )


## ----emm-plot-custom----------------------------------------------------------
plot(iris_custom_contrasts) +
         geom_vline(xintercept = 0, lty = 2 , alpha = 0.5) +
         theme_bw() +
         theme(text = element_text(size = 20))


## -----------------------------------------------------------------------------
contrast(spp_em, method = "pairwise")


## -----------------------------------------------------------------------------
pairs(spp_em) 

confint(pairs(spp_em))


## -----------------------------------------------------------------------------
plot(pairs(spp_em)) +
         geom_vline(xintercept = 0, lty = 2 , alpha = 0.5) +
         xlab("Estimated difference in Sepal Lengths")


## -----------------------------------------------------------------------------
pairs(spp_em, exclude = 2)


## -----------------------------------------------------------------------------
load("../data/contrast_tutorial_dat.RData")

#load("contrast_tutorial_dat.RData")

size_dat <- contrast_tutorial_dat


## -----------------------------------------------------------------------------
head(size_dat)


## ----beeswarm, fig.width = 14, out.width="100%"-------------------------------
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
round(summary(mod1_thorax)$coef, digits = 4)


## ----marg-means-plot, fig.width = 14------------------------------------------
thorax_emm <- emmeans(mod1_thorax, specs = ~ sex | selection)

thorax_emm

## rotate strip labels:
## https://stackoverflow.com/questions/40484090/rotate-switched-facet-labels-in-ggplot2-facet-grid
rot_strips <-   theme_bw() +
    theme(text = element_text(size = 16),
          strip.text.y.right = element_text(angle = 0))

plot(thorax_emm,
     xlab = "model estimates, thorax length, log2 µm") +
    rot_strips


## ----fig.width = 14-----------------------------------------------------------
thorax_emm_response <- emmeans(mod1_thorax, 
                               specs = ~ sex | selection, type = "response")

thorax_emm_response


## -----------------------------------------------------------------------------
F_control_log2 <- as.data.frame(thorax_emm[1,])

F_control_log2


## -----------------------------------------------------------------------------
F_control_log2 <- c(F_control_log2$emmean,
                    F_control_log2$lower.CL,
                    F_control_log2$upper.CL)

F_control_log2


## -----------------------------------------------------------------------------
2^F_control_log2


## -----------------------------------------------------------------------------
thorax_emm_response[1,]


## ----fig.width = 14-----------------------------------------------------------
plot(thorax_emm_response,
     xlab = "model estimates, thorax length, µm") +
    rot_strips


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
    rot_strips


## ----fig.width = 14-----------------------------------------------------------
thorax_ssd <- emmeans(mod1_thorax,  pairwise ~ sex*selection) # warning is letting you know these are not of general use. We only do this as we are forming an interaction contrast.

thorax_ssd_contrasts <- contrast(thorax_ssd[[1]], 
                                 interaction = c(selection = "trt.vs.ctrl1", sex = "pairwise"),
                                 by = NULL)


## ----fig.width = 14-----------------------------------------------------------
thorax_ssd_contrasts

confint(thorax_ssd_contrasts)


## ----fig.width = 14-----------------------------------------------------------
plot(thorax_ssd_contrasts) + 
  geom_vline(xintercept = 0, lty = 2, alpha = 0.5) + 
    labs(x = "change in SSD relative to control lineages (log2)", y = "comparison") +
    theme_bw() + theme(text = element_text(size = 16))


## -----------------------------------------------------------------------------

thorax_ssd_contrasts_ratios <- contrast(thorax_ssd[[1]], 
                                 interaction = c(selection = "trt.vs.ctrl1", sex = "pairwise"),
                                 by = NULL,type = "response")

confint(thorax_ssd_contrasts_ratios)


## ----fig.width = 14-----------------------------------------------------------
plot(thorax_ssd_contrasts_ratios) + 
  geom_vline(xintercept = 1, lty = 2, alpha = 0.5) + 
    labs(x = "change in SSD relative to control lineages (ratio)", y = "comparison") +
    theme_bw() + theme(text = element_text(size = 16))

