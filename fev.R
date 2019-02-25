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

bayesmod <- jags(model.file='fev.bug',
	parameters=c("")
	data = list('fev' = fev, 'height' = height),
	n.chains = 4,
	inits=NULL
)
