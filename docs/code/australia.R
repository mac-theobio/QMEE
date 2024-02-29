
library(DHARMa)
library(ggplot2); theme_set(theme_bw(base_size=16))

aids <- read.csv("data/aids.csv")
aids <- transform(aids, date=year+(quarter-1)/4)
baseplot <- ggplot(aids,aes(date,cases))+geom_point()

print(baseplot 
	+ geom_smooth(formula=y~x
		, method="glm",colour="red"
		, method.args=list(family="poisson")
	)
	+ ylim(c(NA, 200))
	+ ggtitle("Linear; Poisson")
)

print(baseplot 
	+ geom_smooth(formula=y~x
		, method="glm",colour="red"
		, method.args=list(family="quasipoisson")
	)
	+ ylim(c(NA, 200))
	+ ggtitle("Linear; quasi")
)

print(baseplot 
	+ geom_smooth(formula=y~poly(x,2)
		, method="glm",colour="red"
		, method.args=list(family="quasipoisson")
	)
	+ ggtitle("Quadratic; quasi")
)

basemod <- glm(cases~date, data = aids, family=poisson(link="log"))
plot(simulateResiduals(basemod))

qmod <- update(basemod,.~poly(date,2))
plot(simulateResiduals(qmod))
