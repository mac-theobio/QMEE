library(ggplot2); theme_set(theme_bw(base_size=14))

## dat <- readRDS("tmp/homMerge.rds")
dat <- readRDS("tmp/hom2.rds")

boxp <- (ggplot(dat)
	+ aes(x=Place, y=homicides, color=Region)
	+ geom_boxplot()
)

print(boxp) + geom_boxplot(outlier.colour=NULL)  ## set outlier points to same colour as boxes
print(boxp + coord_flip())


