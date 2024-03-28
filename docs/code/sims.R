library(glmmTMB)
library(dplyr)

set.seed(101)

nGroup <- 15
nBats <- nGroup*2
nGroup=3; days=seq(3, 60, by=3)
β0=10; β_treat=10; β_day=2
sdint=3; sdslope=0.1; corr=0; sdres=2

batID <- as.factor(1:nBats) ## Make this look less like a number with paste()
treatment <- as.factor(rep(c("control", "exercise"), each=nGroup))

tdat <- data.frame(batID, treatment)

dat <- expand.grid(batID=batID, day=days)

dat <- full_join(dat, tdat, by="batID")

y <- simulate_new( ~ 1 + treatment + day + (1 + day | batID)
	, nsim = 1
	, family = "gaussian"
	, newdata = dat
	, newparams = list(
		beta = c(β0, β_treat, β_day)
		, theta = c(log(sdint), log(sdslope), corr)
		, betad = log(sdres)
	)
)

dat$flightTime <- y[[1]]

fit <- glmmTMB(flightTime ~ 1 + treatment + day + (1 + day | batID)
	, data=dat
	, family = "gaussian"
)

summary(fit)

confint(fit)

