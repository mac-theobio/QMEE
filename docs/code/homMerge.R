## This script is designed to be run from its parent directory (the repo base)

library(readr)
library(dplyr)
library(tidyr)
library(forcats)

load("tmp/homRead.rda")

## This is our useful table, but it's not tidy, it's redundant
## Any problems should be fixed upstream of here
combined <- (full_join(places, rates, by="Place")
	|> mutate(Place=fct_reorder(Place,-Population))
)
## fct_reorder will reorder a factor's levels without changing anything else

summary(combined)
print(combined)

saveRDS(combined, file="tmp/homMerge.rds")
