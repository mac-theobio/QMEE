library(R2jags)
## Try to install rjags first (read instructions about jags)
library(readr)
## wants to use curl package to read from web, you may want to install it
library(ggplot2)

df <- read_csv("http://biostat.mc.vanderbilt.edu/wiki/pub/Main/DataSets/FEV.csv")

print(ggplot(df, aes(x=height, y=fev))
	+ geom_point()
	+ geom_smooth()
)

linmod <- lm(fev~height, data=df)
plot(linmod)

N <- nrow(df)

bayesmod <- with(df, jags(model.file='fev.bug'
	, parameters=c("b_height", "b_0", "tau")
	, data = list('fev' = fev, 'height' = height, 'N'=N)
	, n.chains = 4
	, inits=NULL
))

print(bayesmod)
plot(bayesmod)
traceplot(bayesmod)
