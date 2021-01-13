library(R2jags)
library(readr)
library(ggplot2)

df <- read_csv("http://biostat.mc.vanderbilt.edu/wiki/pub/Main/DataSets/FEV.csv")

print(ggplot(df, aes(x=height, y=fev))
	+ geom_point()
	+ geom_smooth()
)

linmod <- lm(fev~height, data=df)
plot(linmod)

N <- nrow(df)

bayesmod <- with(df, jags(model.file='jags.bug',
	parameters=c("b_0", "b_height", "tau")
	, data = list('fev' = fev, 'height' = height, 'N' = N)
	, n.chains = 4
	, inits=NULL
))

print(bayesmod)
plot(bayesmod)
traceplot(bayesmod)
