## This script is designed to be run from its parent directory (the repo base)

library(readr)
library(dplyr)
library(tidyr)

widedat <- read_csv("data/CA_homicide.csv", col_types=cols())
summary(widedat)
## We will want to make this into a long, tidy data frame

popdat <- (read_csv("data/CA_popdat.csv", col_types=cols())
	|> mutate(Place=factor(Place))
)
summary(popdat)

## |> and %>% are the same; the former is new, but in base R

regions <- (read_csv("data/canadaRegions.csv", col_types=cols())
	|> mutate(Place=factor(Place))
	|> mutate(Region=factor(Region))
)
## A cooler way of doing the same thing!
regions <- (read_csv("data/canadaRegions.csv", col_types=cols())
	|> mutate(across(c(Region, Place), factor))
)
summary(regions)

## Make a region-level combined file
## Use a join operator to make sure everything is lined up and correct as we go
## Get rid of Canada because we may or may not want to reconstruct it later

places <- (full_join(popdat, regions, by="Place")
	|> filter(Place != "Canada")
	|> rename(Population=Pop_2011)
	|> mutate(Region=droplevels(Region))
)
summary(places)

## Make an observation-level combined file
## Pivot all of the columns _except_ Place
rates <- (widedat
	|> pivot_longer(cols=-Place, names_to="Year", values_to="rate")
	|> filter(Place != "Canada")
	|> mutate(
		Place=factor(Place)
		, Year = as.numeric(Year)
	)
)

summary(rates)

## rates and places represent my current relational DB (tidy, non-repetitive)
## Do another merge both to check, and to make a file for a particular use (visualization, in this case)

## save creates an environment, typically uses rda
## We put it in a tmp/ subdirectory because we don't want to save these files; we want to regenerate them (and check that they can be generated on different platforms). You should ignore tmp/ in git.
save(places, rates, file="tmp/homRead.rda")
