
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
dll_data <- read_csv("data/dll.csv", show_col_types = FALSE) |>
  mutate(across(c(temp, replicate, where(is.character)), factor))
morph_vars <- c("femur","tibia","tarsus","SCT")


## ----dll-data-----------------------------------------------------------------
dll_data

## ----dll_tab------------------------------------------------------------------
## tabulate and show only the first five lines
with(dll_data, table(temp, line, genotype))[,1:5,]


## ----viz1---------------------------------------------------------------------
grp <- as.numeric(as.factor(dll_data$temp)) ## numeric line value

## ----scale--------------------------------------------------------------------
dll_data <- (dll_data |>
               ## scale & center (and convert back from matrix to vector)
               mutate(across(any_of(morph_vars), ~drop(scale(.)),
                             .names = "{.col}_s"))
)
morph_vars_s <- paste0(morph_vars, "_s")

mlm_fit0 <- lm(as.matrix(dll_data[morph_vars]) ~ genotype,
               data = dll_data)
print(mlm_fit0)

mlm_fit1 <- lm(as.matrix(dll_data[morph_vars_s]) ~ genotype,
               data = dll_data)
print(mlm_fit1)

car::Anova(mlm_fit0)
car::Anova(mlm_fit1)

