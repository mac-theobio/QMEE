## I don't often use base_size when experimenting, but it's really good to know about for papers and especially slides
library(ggplot2); theme_set(theme_bw(base_size=14))
pdf(width=10)

dat <- readRDS("tmp/homMerge.rds")
names(dat)

base <- (ggplot(dat)
	+ aes(Year, rate, color=Place)
	+ geom_point() + geom_line()
)

print(base)
print(base + scale_y_log10())
print(base + scale_y_continuous(trans="log1p"))
print(base + scale_y_continuous(trans="log1p") + aes(linewidth=Population))

## See the lecture material
## I may also add more stuff below, especially direct labels
## There is also boxplot material
