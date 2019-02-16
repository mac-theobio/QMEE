library(ggplot2)
library(lmPerm)
library(dplyr)
library(readr)

lizards <- (read_csv("data/lizards.csv")
    %>% mutate(time=factor(time,levels=c("early","midday","late")))
)
    

table(lizards$time)
##  early   late midday 
##     8      8      7

(ggplot(lizards,aes(time,gfrac))
    +geom_boxplot()
    +geom_point())

## scramble time in lizards data
simfun <- function() {
    newdat <- (lizards
        %>% mutate(time=sample(time))
    )
}

sumfun <- function(d) {
    medvals <- (d
        %>% group_by(time)
        %>% summarise(med_gfrac=median(gfrac))
        %>% pull(med_gfrac)
    )
    return(sum(abs(medvals-median(d$gfrac))))
}

nsim <- 1000
res <- numeric(nsim)
res[1] <- sumfun(lizards)
for (i in 2:nsim) {
    res[i] <- sumfun(simfun())
}
2*mean(res>=res[1])
library(lmPerm)
## does *NOT* give overall comparison ...
summary(lmp(gfrac~time,data=lizards))
