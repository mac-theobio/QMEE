library(glmmTMB)
library(dplyr)

set.seed(101)

## flightTime ~ treatment + weight + timeInCaptivity + day + sex

## flightTime ~ treatment + day + (day | batID)

nGroup <- 15
nBats <- nGroup*2


batID <- as.factor(1:nBats) ## Make this look less like a number with paste()
day <- seq(3, 60, by=3)
treatment <- as.factor(rep(c("control", "exercise"), each=nGroup))

tdat <- data.frame(batID, treatment)

dat <- expand.grid(batID=batID, day=day)

dat <- full_join(dat, tdat, by="batID")

##  \print(dat)

## Think about using treatment*day instead; what are the units of that β??
y <- simulate_new( ~ 1 + treatment + day + (1 + day | batID),
	nsim = 1,
	family = "gaussian",
	newdata = dat,
	newparams = list(
		beta = c(10, 10, 2),   ## intercept and slope (pop-level)
		## log-SD of intercept and slope; transformed correlation
		theta = c(log(c(3, 0.1)), 0), ## correlation in RL may be <-
		betad = log(3) ## log-SD of residual variation
	)
)

dat$flightTime <- y[[1]]

fit <- glmmTMB(flightTime ~ 1 + treatment + day + (1 + day | batID)
	, data=dat
	, family = "gaussian"
)

summary(fit)

confint(fit)
