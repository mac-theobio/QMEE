## Hannah Anderson:
library(tidyverse)

## MAKE UP DATA in similar format (one row per snake)
dfun <- function(nf,species,lambda,meanlog,sdlog) {
    (tibble(field=factor(1:nf),species=species,
            n=rpois(nf,lambda=lambda))
        %>% uncount(weights=n)
        %>% mutate(mass=rlnorm(n(), meanlog=meanlog, sdlog=sdlog))
    )
}
set.seed(101)
nf <- 20
cc <- dfun(nf,"copper",lambda=1, meanlog=2, sdlog=0.5)
kk <- dfun(nf,"king",  lambda=6, meanlog=5, sdlog=0.5)
dd3 <- bind_rows(cc,kk) %>% mutate(species=factor(species))

## NOW COLLAPSE DATA to number, mean size of individuals by field
## need to have both 'count' variables ({field, species} here;
## would be {field, species, year}) be *factors* in order
##  to fill in zeros properly

## numbers of individuals by field
ddc <- (dd3
    %>% count(field,species,.drop=FALSE)  ## would add year here
    %>% spread(species,n)
    %>% rename_if(is.numeric, ~paste0(.,"_n"))
)
## mean masses of individuals by field
ddm <- (dd3
    %>% group_by(field,species)   ## would add year here
    %>% summarise(mean_mass=mean(mass))
    %>% spread(species,mean_mass)
    %>% rename_if(is.numeric, ~paste0(., "_mass"))
)
dd4 <- full_join(ddc,ddm, by="field")  ## would join by c("field","year")
