## make up a 'bad' data set
dd <- data.frame(x = c(1.01, 2.0, "3,0", 4.0, "a", "5a6"),
                 y = 1:6)
write.csv(dd, "tmp.csv", row.names = FALSE, quote = TRUE)

library(tidyverse)
dd2 <- read_csv("tmp.csv")

## some functions for finding and displaying 'bad' elements
##  (values in columns that should be numeric)

#'@param x a vector
#'@return integer indices of elements that can't be converted to numeric
find_bad_elements <- function(x) {
  xnum <- suppressWarnings(as.numeric(x))
  which(!is.na(x) & is.na(xnum))
}

#'@param x a vector
#'@return vector of elements that can't be converted to numeric, with names corresponding to their indices
show_bad_elements <- function(x) {
  bad <- find_bad_elements(x)
  ret <- x[bad]
  names(ret) <- bad
  ret
}

find_bad_elements(dd$x)
show_bad_elements(dd$x)

## this function tries (too) hard to convert to numeric:
## "This parses the first number it finds, 
## dropping any non-numeric characters before the first number 
## and all characters after the first number"
readr::parse_number(dd$x)

## apply show_bad_elements to every column
lapply(dd, show_bad_elements)

should_be_numeric <- 1 ## list of columns (indices or names)
dd |> mutate(across(all_of(should_be_numeric), as.numeric))

## can use na.omit() to drop *all* rows with *any* NA values (might not
## want to do this as you won't be using all columns in every analysis,
## so this may drop more than you want)
