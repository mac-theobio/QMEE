## BB and JD don't really love the default grey background
## You can pick a theme you like and set it at the top
## so that all your plots inherit the same theme

library(ggplot2); theme_set(theme_bw())
library(performance)
library(dotwhisker)

###### Exploratory
## It doesn't hurt to remind everyone you're printing the ggplot
## This style makes editing easier (+ signs are visible and consistent)
## YOu can try color=cyl, for example if you want to see
## ... maybe combine with method="lm"
print(ggplot(mtcars)
	+ aes(x=disp, y=mpg)
        + geom_point()
      	## + aes(color=cyl)            ## numeric: colour ramp
	## + aes(color=as.factor(cyl)) ## categorical: discrete colours
	## + geom_smooth(method="lm")  ## regression line
	+ geom_smooth()                ## loess (default)
      )

## if you want to plot a smooth line that's constrained to be positive or
## between 0 and 1 (e.g. for proportion data), use a GLM (method = "glm")
## or GAM (method = "gam") with the 'family' set to quasipoisson (for
## positive) or quasibinomial (for proportions): see
## https://github.com/mac-theobio/QMEE/blob/master/lectures/Contraception.rmd

###### Diagnostic
m1 <- lm(mpg~disp, data=mtcars)

## Old-style plots
## plot(m1)

# Hot new plots
check_model(m1)

## Do the plots look better if we add more sensible predictors?
## Should ask Ben about this
## A little better, and there's a new plot!
m2 <- lm(mpg ~ cyl+disp+hp, data=mtcars)
check_model(m2)

## also see DHARMa package (we will discuss later)

###### Inferential

## This is super-weird – because we are comparing predictors with different units
## omits the intercept by default (this is usually the right choice):
##  show_intercept = TRUE if you really want it

print(dwplot(m2))

## Scale the predictors for comparison, add a line for zero effect for reference
print(dwplot(m2, by_2sd=TRUE)
	+ geom_vline(xintercept=0, lty=2)
)

