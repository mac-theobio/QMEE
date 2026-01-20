library(readr)
library(dplyr)

## Data from FAO; plot used to be famous among Ben
#### pix/bananasbananas.webp
bf <- read_tsv("data/bananas.tsv")

summary(bf |> mutate(across(where(is.character), factor)))


