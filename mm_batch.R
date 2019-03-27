library(lme4)
library(broom.mixed)

dll_melt <- readRDS("dll_melt.rds")
t1 <- system.time(
    lmer1 <- lmer(value ~ trait:(genotype*temp) - 1 +
                      (trait-1|line) + (trait-1|units),
                  data=dll_melt,
                  control=lmerControl(optCtrl=list(ftol_abs=1e-8),
                                      check.nobs.vs.nlev="ignore",
                                      check.nobs.vs.nRE="ignore"))
)
pp <- profile(lmer1, which="theta_",
              parallel="multicore",
              ncpus=2,
              verbose=TRUE)
saveRDS(pp, file="mm_ranprof.rds")
cc2 <- tidy(lmer1,
            effect = "ran_pars",
            conf.int = TRUE,
            conf.method = "profile",
            profile=pp
)
saveRDS(cc2, file="mm_ranpars.rds")
as.data.frame(VarCorr(lmer1),order="lower.tri")
confint(pp)
