library(glmmTMB)
library(broom.mixed)

dll_melt <- readRDS("dll_melt.rds")
t1 <- system.time(
    m1 <- glmmTMB(value ~ trait:(genotype*temp) - 1 +
                      (trait-1|line) + (trait-1|units),
                  disp=~0,
                  data=dll_melt)
)
debug(glmmTMB:::profile.glmmTMB)
debug(glmmTMB:::vcov.glmmTMB)
vcov(m1)
pp <- profile(m1, parm="theta_")

