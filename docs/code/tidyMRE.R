library(glmmTMB)
library(dplyr)
library(purrr)
library(broom.mixed)

## These ...'s aren't the best practice; should figure out more about map
sim <- function(groupSize, days, β0, β_treat, β_day
	, sdint, sdslope, corr, sdres=2, ...
){

	nBats <- groupSize*2 ## Treatment and control

	batID <- as.factor(1:nBats) ## Make this look less like a number with paste()
	treatment <- as.factor(rep(c("control", "exercise"), each=groupSize))

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
	return(dat)
}

fit <- function(dat){
	return(glmmTMB(flightTime ~ 1 + treatment + day + (1 + day | batID)
		, data=dat
		, family = "gaussian"
	))
}

simCIs <- function(simfun, fitfun, ...){
	dat <- simfun(...)
	fit <- fitfun(dat)
	return(as.data.frame(tidy(fit, conf.int=TRUE)))
	c <- as.data.frame(confint(fit))
}

set.seed(101)

sessionInfo()

print(try(simCIs(simfun=sim, fitfun=fit
	, groupSize = 15, days=seq(3, 60, by=3)
	, β0=10, β_treat=10, β_day=2
	, sdint=3, sdslope=0.1, corr=0, sdres=2
)))
