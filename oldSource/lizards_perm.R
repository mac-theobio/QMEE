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

## what if we want to extract summary statistics from a 1-way ANOVA?

a2 <- anova(lm(gfrac~time, data=lizards))
str(a2)
## Classes ‘anova’ and 'data.frame':	2 obs. of  5 variables:
##  $ Df     : int  2 20
##  $ Sum Sq : num  0.214 0.495
##  $ Mean Sq: num  0.107 0.0247
##  $ F value: num  4.33 NA
##  $ Pr(>F) : num  0.0275 NA
##  - attr(*, "heading")= chr  "Analysis of Variance Table\n" "Response: gfrac"

## we want to pull out the F value ("4.33")
a2$`F value`
a2[["F value"]]

## but we only need the first element
a2$`F value`[1]

