## do stuff in the script window whenever you can
2+3
2*sqrt(7689)*pi*exp(-456)
((2*5)/(2)/(3))

x = 5
x= "junk"
x
print(x)

x <- 1.123456789123456789
str(x)
print(x,digits=22)

x <- TRUE

x <- c(1,2,3,4)
x*2

list(1,TRUE,"abc",list(1,2,3))

x <- x + 2
y <- y + 2
z <- z + 2
c(x=1,y=2,z=3)
f <- function(x,y=1,z=2) {
    ## ARGUMENT(S) x
  x + 2  ## RETURN VALUES
}

dd <- data.frame(x=1:4,
                 y=c("a","b","c","c"))

dd[1,2]## rows, columns

dd$y
dd[["y"]]
dd[,2]

dd[1,]

library(tidyverse)
library(readr)
surveys <- read_csv("data/portal_data_joined.csv")
## tibble
str(surveys)

View(surveys)
## COLUMNS or variables
surveys2 <- select(surveys, plot_id, species_id, weight)
surveys2 <- select(surveys, -plot_id)
surveys2 <- select(surveys, -c(plot_id, species_id, weight))

names(surveys2)

## ROWS or observations
filter(surveys2, month==7 & genus=="Neotoma")
filter(surveys2, month==7,
                 genus=="Neotoma")
filter(surveys2, month==7 | genus=="Neotoma")
unique(surveys2$genus)
filter(surveys2, genus=="Neotoma" | genus == "Dipodomys" | genus == "Perognathus")
## DOESN'T WORK even though we'd like it to
## filter(surveys2, genus=="Neotoma" |  "Dipodomys" | "Perognathus")

filter(surveys2, genus %in% c("Neotoma","Dipodomys","Perognathus"))
keep_species <- c("Neotoma","Dipodomys","Perognathus")
filter(surveys2, genus %in% keep_species)

## PIPES

surveys3 <- (surveys2 
   %>% filter(genus %in% keep_species) 
   %>% select(plot_id, species, weight)
)

####

surveys %>% mutate(weight_kg = weight/1000,
                   weight_kg_sq = weight_kg^2) %>%
            filter(!is.na(weight) & !is.na(sex)) %>%
        group_by(genus,species_id,sex) %>%
        summarise(weight_mean = mean(weight_kg),
                  weight_median = median(weight_kg))
  head()

## also: na.omit()

  is.na(NA)