## some R code
list.files("../data")
list.files("data")

##
library(tidyverse)
find("filter")
m <- as_tibble(mtcars)  ## fancy tidyverse data frame
print(m)
m %>% group_by(cyl) %>% ungroup()
m %>% group_by(cyl)
m %>% group_by(cyl) %>% summarise(mpg=mean(mpg))

## grouping by two different variables
options(dplyr.summarise.inform=FALSE) ## tell tidyverse to shut up

m %>% group_by(cyl,gear) %>% summarise(mpg=mean(mpg), .groups="drop")
m %>% group_by(cyl,gear) %>% summarise(mpg=mean(mpg))

str(mtcars[,1])
str(m[,1])
## you should do these instead
str(m$cyl)
str(mtcars$cyl)
str(mtcars[["cyl"]])
str(m[["cyl"]])

###
tax_table <-read.csv(text="
common_name, taxon
sunfish, fish
gar, fish
pike, fish
raccoon, mammal
mouse, mammal
")
tax_table2 <- read.table(header=TRUE,sep="|", strip.white=TRUE,
text="
  a   |  b
  c   |  d
  e   |  f
  g   |  h
")