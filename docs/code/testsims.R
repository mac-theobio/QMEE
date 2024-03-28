library(glmmTMB)
library(dplyr)
library(purrr)

library(shellpipes)

sim <- function(nGroup, days, β0, β_treat, β_day
	, sdint, sdslope, corr, sdres, ...
){
	nBats <- nGroup*2
	batID <- as.factor(1:nBats)

	gdat <- expand.grid(
		batID = batID
		, day=days
	)

	tdat <- data.frame(batID
		, treatment = as.factor(rep(c("control", "exercise"), each=nGroup))
	)

	dat <- full_join(gdat, tdat, by="batID")

	y <- simulate_new( ~ 1 + treatment + day + (1 + day | batID),
		nsim = 1,
		family = "gaussian",
		newdata = dat,
		newparams = list(
			beta = c(β0, β_treat, β_day)
			, theta = c(log(sdint), log(sdslope), corr)
			, betad = log(sdres)
		)
	)

	dat$flightTime <- y[[1]]
	return(dat)
}

fit <- function(dat){ 
	fit <- glmmTMB(flightTime ~ 1 + treatment + day + (1 + day | batID)
		, data=dat
		, family = "gaussian"
	)
	## summary(fit)
	return(confint(fit))
}

simCIs <- function(simfun, fitfun, ...)
{
	dat <- simfun(...)
	fit <- as.data.frame(fitfun(dat))
	return(data.frame(vname = row.names(fit)
		, est = fit$Est
		, low = fit$"2.5"
	))
}

######################################################################

numSims <- 10

set.seed(2134)
s0 <- sim(nGroup=3, days=seq(3, 60, by=3)
	, β0=10, β_treat=10, β_day=2
	, sdint=3, sdslope=0.1, corr=0, sdres=2
)

simCIs(sim, fit, nGroup=3, days=seq(3, 60, by=3)
	, β0=10, β_treat=10, β_day=2
	, sdint=3, sdslope=0.1, corr=0, sdres=2
)

ciList <- map(.x=1:numSims, .f=simCIs
	, simfun=sim, fitfun=fit
	, nGroup=3, days=seq(3, 60, by=3)
	, β0=10, β_treat=10, β_day=2
	, sdint=3, sdslope=0.1, corr=0, sdres=2
)

rdsSave(ciList)
