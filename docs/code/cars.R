## BB and JD don't really love the default grey background
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
	## + aes(color=cyl)
	## + aes(color=as.factor(cyl))
	## + geom_smooth(method="lm")
	+ geom_smooth()
)

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

###### Inferential

## This is super-weird – because we are comparing predictors with different units
print(dwplot(m2))

## Scale the predictors for comparison, add a line for zero effect for reference
print(dwplot(m2, by_2sd=TRUE)
	+ geom_vline(xintercept=0, lty=2)
)

