## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
options(digits  = 3)
timefun <- function(x,units,digits=0,component="elapsed") {
    t <- x[[component]]
    if (missing(units)) {
        units <- ifelse(t>30,"minutes","seconds")
    }
    t <- switch(units,
                seconds=t,
                minutes=t/60)
    paste(format(t,digits),units)
}


## ----mdat, echo = FALSE-------------------------------------------------------
OkIt <- palette.colors()[-1]
ctrs <- list(c(-5, -3), c(-1, 1), c(3,1))
Sigma <- matrix(c(2, 1.5, 1.5, 2), 2, 2)
ctr_dat <- rbind(unlist(ctrs[1:2]),
                 unlist(ctrs[2:3])) |>
  as.data.frame() |>
  setNames(c("x1", "y1", "x2", "y2"))
n <- 100
set.seed(101)
mdat <- do.call(rbind, lapply(ctrs, \(x) MASS::mvrnorm(n, mu = x, Sigma = Sigma)))
mdat <- data.frame(grp = factor(rep(1:3, each = n)), mdat)


## ----mplot, echo = FALSE, message = FALSE-------------------------------------
library(ggplot2); theme_set(theme_bw())
mplot <- ggplot(mdat, aes(X1, X2, colour = grp)) +
  geom_point() + stat_ellipse() +
  theme_minimal() +
  scale_colour_manual(values = OkIt)
print(mplot)


## ----pkgs, message=FALSE------------------------------------------------------
library(lme4)
library(glmmTMB)
library(tidyverse); theme_set(theme_bw())
library(corrplot)
library(broom.mixed)
library(dotwhisker)
library(car)
## install.packages('gllvm',
##                  repos = c('https://jenniniku.r-universe.dev',
##                            'https://cloud.r-project.org'))
library(gllvm)
## maybe?
library(MCMCglmm)
library(brms)


## ----get_data-----------------------------------------------------------------
raw <- read_csv("data/dll.csv", show_col_types = FALSE) |>
  mutate(across(c(temp, replicate, where(is.character)), factor))
morph_vars <- c("femur","tibia","tarsus","SCT")


## ----scale--------------------------------------------------------------------
scaled <- (raw
	|> mutate(across(any_of(morph_vars), ~drop(scale(.))))
)

summary(scaled)

raw_long <- (raw
    |> mutate(units=factor(1:n()))
    |> pivot_longer(names_to = "trait", cols = morph_vars)
    |> drop_na()
    |> arrange(units)
)

scaled_long <- (scaled
    |> mutate(units=factor(1:n()))
    |> pivot_longer(names_to = "trait", cols = morph_vars)
    |> drop_na()
    |> arrange(units)
)

## ----lmer-form----------------------------------------------------------------
lmer_form <- value ~ 0 + trait:(genotype*temp) +
  (0+trait|line) + (0+trait|units)


## ----fit_lmer1,cache=TRUE-----------------------------------------------------

mm_raw <- lmer(lmer_form, data=raw_long
	, control=lmerControl(
		check.nobs.vs.nlev="ignore", check.nobs.vs.nRE="ignore"
	)
)

mm_scaled <- update(mm_raw, data=scaled_long)

## ----corrs--------------------------------------------------------------------
vv_raw <- VarCorr(mm_raw)
print(vv_raw)

quit()


## ----corrplot1,width=10-------------------------------------------------------
par(mfrow=c(1,2))
## fix unit variance-covariance by adding residual variance:
diag(vv1$units) <- diag(vv1$units)+sigma(lmer1)^2
corrplot.mixed(cov2cor(vv1$line),upper="ellipse")
corrplot.mixed(cov2cor(vv1$units),upper="ellipse")


## ----dwplot, warning = FALSE--------------------------------------------------
cc1 <- tidy(lmer1,effect="fixed") |>
  tidyr::separate(term,into=c("trait","fixeff"),extra="merge",
                  remove=FALSE)
dwplot(cc1)+facet_wrap(~fixeff,scale="free",ncol=2)+
  geom_vline(xintercept=0,lty=2)


## ----tidy_ran_pars, eval=FALSE------------------------------------------------
# t1_CI <- system.time(cc2 <- tidy(lmer1,
#             effect = "ran_pars",
#             conf.int = TRUE,
#             conf.method = "profile",
#             parallel="multicore",
#             ncpus=8))
# saveRDS(cc2, file="../data/cc2.rds")

