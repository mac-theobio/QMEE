## dealing with empty rows and columns
library(tidyverse)
library(janitor)
## (minimal) reproducible example
dd <- tibble(x=c(LETTERS[1:5],NA,rep("",2)),
             y=c(1:5,rep(NA,3)),
             z=rep(NA,8))
## BAD (suboptimal)
dd[-(6:7),-3]
dd[1:5,1:2]
##

dd %>% mutate_if(is.character,
                 ~replace(., which(!nzchar(.)),NA))
dd %>% mutate(across(is.character,
      ~replace(., which(!nzchar(.)),NA)))

remove_empty(dd,c("rows","cols"))

emptyrows2 <- function(x) {
  apply(x,1,
        function(x) {
          y <- unlist(x)
          all(is.na(y) | nchar(y)==0)
        })
}
emptyrows2(dd)
dd <- dd[!emptyrows2(dd),]


## the importance of clean/sensible data coding standards

"
{site tag}{date}
N6/919
P22/1020
A1/511
"
"
N060919
P221020
A010511

separate(
  


"

lookahead & lookbehind regular expressions

## univariate and multivariate views of data
summary()
library(skimr)
skim(mtcars)

library(MASS)
m <- mvrnorm(50, mu=c(0,0), Sigma=matrix(c(2,1.9,1.9,2),2))
plot(m[,1],m[,2])
m <- rbind(m,c(-2,2))
pairs(mtcars,gap=0)
library(GGally)
ggpairs(mtcars)
library(car)
## apropos("scatter") ## what was that function again???
## help(package="car")
scatterplotMatrix(mtcars)
library(sos)
findFn("scatterplot")
