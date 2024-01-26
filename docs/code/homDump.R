
library(readr)
library(dplyr)
library(tidyr)

homicides <- read_csv("data/CA_homicide.csv", col_types=cols())
pops <- read_csv("data/CA_popdat.csv", col_types=cols())
regions <- read_csv("data/canadaRegions.csv", col_types=cols())

summary(homicides)
summary(pops)
summary(regions)

longdat <- (homicides
	|> pivot_longer(cols=-Place, names_to="year", values_to="homicides")
	|> mutate(year=as.numeric(year))
)

places <- full_join(pops, regions, by="Place")

save("longdat", "places", file="tmp/homDB.rda")

library(forcats)
library(dplyr)

load("tmp/homDB.rda")

combdat <- (full_join(longdat, places, by="Place")
	|> filter(Place != "Canada")
	|> rename(Pop=Pop_2011)
	|> mutate(
		Place=fct_reorder(Place,Pop)
		, Region=as.factor(Region)
	)
)

summary(combdat)

saveRDS(combdat, "tmp/hom2.rds")
library(ggplot2)
theme_set(theme_bw())  ## black-and-white theme
library(directlabels)

pdf(width=10)

dat <- readRDS("tmp/hom2.rds")

base <- (ggplot(dat)
	+ aes(x=year, y=homicides, color=Place)
)

## print(base + geom_line())

nice <- (base + geom_line()
	+ scale_y_continuous(trans="log1p")
	+ labs(y="Homicides per 100,000 population")
)

print(nice 
	+ geom_dl(aes(label=Place), method="last.points") 
    + expand_limits(x=2013)  ## add a little more space
    + theme(legend.position="none")  ## don't need the legend any more
)

print(nice 
	 + aes(linewidth=Pop)
	 + scale_size_continuous(trans="log10")
	 + facet_wrap(~Region)
)
library(ggplot2)
theme_set(theme_bw())  ## black-and-white theme

dat <- readRDS("tmp/hom2.rds")

boxp <- (ggplot(dat)
	+ aes(x=Place, y=homicides, color=Region)
	+ geom_boxplot()
)

print(boxp) + geom_boxplot(outlier.colour=NULL)  ## set outlier points to same colour as boxes
print(boxp + coord_flip())

