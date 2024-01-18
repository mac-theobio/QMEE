## Designed to be run from repo parent directory

library(readr)
library(dplyr)

## FIXME: look for info in documentation about Dec the zero-th
parasiteTable <- read_csv("data/parademo.csv"
	, na = c("", "NA", "0000-00-00", "1972-12-00")
)

problems(parasiteTable)

summary(parasiteTable)
