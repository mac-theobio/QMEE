library(palmerpenguins)
library(skimr)
library(tidyverse)
skim(penguins)
head(penguins)

penguins_sum <- (penguins
   |> group_by(species, island)              
  |> summarise(mass = mean(body_mass_g))
    )
print(penguins_sum) 

penguins_sum <- (penguins
                 |> summarise(mass = mean(body_mass_g), .by = c(species, island))
)


penguins_sum_means <- (penguins
                 |> summarise(across(c(body_mass_g, flipper_length_mm),
                                     mean), 
                              .by = c(species, island))
)


penguins_sum_vars <- (penguins
                       |> summarise(across(c(body_mass_g, flipper_length_mm),
                                           .fns = list(mean = mean, sd = sd)), 
                                    .by = c(species, island))
)


penguins_sum_vars <- (penguins
                      |> summarise(across(c(body_mass_g, flipper_length_mm),
                      .fns = list(mean = ~ mean(., na.rm = TRUE), 
                  se = ~ sd(., na.rm=TRUE))/sqrt(length(na.omit(.)))), 
                                   .by = c(species, island))
)

se_nona <- function(x) {
 ret <- sd(x, na.rm=TRUE)/sqrt(length(na.omit(x)))
 return(ret)
}

source("utils.R")

penguins_sum_vars <- (penguins
                      |> summarise(across(c(body_mass_g, flipper_length_mm),
                                          .fns = list(mean = ~ mean(., na.rm = TRUE), 
                                                      se = se_nona)), 
                                   .by = c(species, island))
)


penguins_sum_vars <- (penguins
                      |> summarise(across(where(is.numeric),
                                          .fns = list(mean = ~ mean(., na.rm = TRUE), 
                                                      se = se_nona)), 
                                   .by = c(species, island))
)

help(package="tidyselect")

vars_interest <- c("bill_depth_mm", "body_mass_g")

penguins_sum_vars <- (penguins
                      |> summarise(across(all_of(vars_interest),
                                          .fns = list(mean = ~ mean(., na.rm = TRUE), 
                                                      se = se_nona)), 
                                   .by = c(species, island))
)

penguins |> mutate(across(bill_length_mm, ~ . /10))

mm_to_cm_name <- function(x) {
   stringr::str_replace(x, "_mm$", "_cm")
   ## gsub("mm", "cm", x)
}




penguins_sum_vars <- (penguins
                      |> summarise(across(where(~!is.factor(.)),
                                          .fns = list(mean = ~ mean(., na.rm = TRUE), 
                                                      se = se_nona)), 
                                   .by = c(species, island))
)


my_types <- function(x ) {
    is.factor(x) || is.character(x)
}

penguins_sum_vars <- (penguins
                      |> summarise(across(where(\(x) !is.factor(x)),
                                          .fns = list(mean = ~ mean(., na.rm = TRUE), 
                                                      se = se_nona)), 
                                   .by = c(species, island))
)