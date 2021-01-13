
library(dplyr)

dat <- tibble(
	site = rep(1:6, times=10)
	, sex = sample(c("M", "F"), size=60, replace=TRUE)
)

baselength <- rlnorm(6, 2, 0.2)
xlength <- 

print(dat)
