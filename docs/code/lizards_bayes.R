library(dplyr)
library(readr)
library(R2jags)
library(coda)
library(broom.mixed)

## utility for constructing an automatically named list
named_list <- lme4:::namedList

lizards <- (read_csv("data/lizards.csv")
    %>% mutate(time=factor(time,levels=c("early","midday","late")))
    %>% mutate_if(is.character,factor)
)

## create list of data
lizdat1 <- with(lizards,
               named_list(N=nrow(lizards),            ## total obs
                          ntime=length(levels(time)), ## number of categories
                          time=as.numeric(time),      ## numeric index
                          grahami))                   ## lizard count


## you can embed BUGS/JAGS 
## model with the main effect of time
## parameterized by group means
timemodel1 <- function() {
    for (i in 1:N) {
        ## Poisson model
        logmean[i] <- b_time[time[i]]    ## predicted log(counts)
        pred[i] <- exp(logmean[i])       ## predicted counts
        ## use log-link so that we never end up with negative predicted values
        grahami[i] ~ dpois(pred[i])
    }
    ## define priors for all parameters in a loop
    for (i in 1:ntime) {
        b_time[i] ~ dnorm(0,0.001)
    }
}

j1 <- jags(data=lizdat1,
           inits=NULL,
           parameters=c("b_time"),
           model.file=timemodel1)

## extract Bayesian CIs
broom.mixed::tidy(j1,conf.int=TRUE, conf.method="quantile")

## model with the main effect of time
## treatment contrasts
timemodel2 <- function() {
    for (i in 1:N) {
        ## Poisson model
        logmean[i] <- b_time[1] + ifelse(time[i]==1, 0, b_time[time[i]])
        pred[i] <- exp(logmean[i])       ## predicted counts
        grahami[i] ~ dpois(pred[i])
    }
    ## define priors in a loop
    for (i in 1:ntime) {
        b_time[i] ~ dnorm(0,0.001)
    }
}
j2 <- jags(data=lizdat1,
           inits=NULL,
           parameters=c("b_time"),
           model.file=timemodel2)
tidy(j2, conf.int=TRUE, conf.method="quantile")


## compare with generalized linear models
m1 <- glm(grahami ~ time, data=lizards, family=poisson)
m2 <- glm(grahami ~ time-1, data=lizards, family=poisson)


## for light, we're going to use a trick that works well
## when we only have two levels of a factor: use as.numeric(f)-1,
## which equals 0 (don't add anything) for the first level of
## the factor and 1 (add the specified coefficient) for the second
## level of the factor
## additive model (light and time)
lighttimemodel1 <- function() {
    for (i in 1:N) {
        ## Poisson model
        logmean0[i] <- b_time[time[i]]       ## predicted log(counts)
        lighteff[i] <- b_light*(light[i]-1)  ## effect of "sunny"
        pred[i] <- exp(logmean0[i] + lighteff[i])
        grahami[i] ~ dpois(pred[i])
    }
    ## define priors in a loop
    for (i in 1:ntime) {
        b_time[i] ~ dnorm(0,0.001)
    }
    b_light ~ dnorm(0,0.001)
}

lizdat2 <- with(lizards,
               named_list(N=nrow(lizards),
                          ntime=length(levels(time)),
                          time=as.numeric(time),
                          light=as.numeric(light),
                          grahami))
j3 <- jags(data=lizdat2,
           inits=NULL,
           parameters=c("b_time","b_light"),
           model.file=lighttimemodel1)
tidy(j3, conf.int=TRUE, conf.method="quantile")

## interaction model (light and time)
lighttimemodel2 <- function() {
    for (i in 1:N) {
        ## Poisson model
        logmean0[i] <- b_time[time[i]]       ## predicted log(counts)
         ## effect of "sunny" for group i
        lighteff[i] <- b_light[time[i]]*(light[i]-1) 
        pred[i] <- exp(logmean0[i] + lighteff[i])
        grahami[i] ~ dpois(pred[i])
    }
    ## define priors in a loop
    for (i in 1:ntime) {
        b_time[i] ~ dnorm(0,0.001)
        b_light[i] ~ dnorm(0,0.001)
    }

}

j4 <- jags(data=lizdat2,
           inits=NULL,
           parameters=c("b_time","b_light"),
           model.file=lighttimemodel2)
tidy(j4, conf.int=TRUE, conf.method="quantile")



#################################
## model with a main effect of time
## parameterized by overall mean and differences between mean & groups
## NOT GOOD -- overparameterized, so confidence intervals are huge
## (would only work if we put a joint prior on b_time??)
lightmodel2 <- function() {
    for (i in 1:N) {
        ## Poisson model
        logmean[i] <- b_avg + b_time[time[i]]    ## predicted log(counts)
        pred[i] <- exp(logmean[i])       ## predicted counts
        grahami[i] ~ dpois(pred[i])
    }
    ## define priors in a loop
    for (i in 1:ntime) {
        b_time[i] ~ dnorm(0,0.001)
    }
    b_avg ~ dnorm(0,0.001)
}

j2 <- jags(data=lizdat1,
           inits=NULL,
           parameters=c("b_time","b_avg"),
           model.file=lightmodel2)

## these parameters are undetermined
tidy(j2, conf.int=TRUE, conf.method="quantile")

library(emdbook)
mm0 <- as.mcmc.bugs(j2$BUGSoutput)
lattice::xyplot(mm0)
mm1 <- lump.mcmc.list(mm0)
pairs(as.matrix(mm1),gap=FALSE)
## all parameters are perfectly correlated

## we can recover the means of the groups, but it's a
summary(mm1[,"b_avg"]+mm1[,"b_time[1]"])
plot(density(mm1[,"b_avg"]+mm1[,"b_time[1]"]))
summary(mm1[,"b_avg"]+mm1[,"b_time[2]"])
summary(mm1[,"b_avg"]+mm1[,"b_time[3]"])
