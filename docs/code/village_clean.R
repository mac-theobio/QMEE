## Designed to be run from repo parent directory

library(readr)
library(dplyr)

## FIXME: look for info in documentation about Dec the zero-th
villageTable <- read_csv("data/village.csv"
)

problems(villageTable)

## This is slightly deprecated but still the neatest way to quickly see good summaries of character variables
summary(villageTable |> mutate_if(is.character, as.factor))
