library(ggplot2); theme_set(theme_bw())
library(dplyr)
library(directlabels)
library(scales)

data_url <- "https://mac-theobio.github.io/QMEE/data/bananas.tsv"
bf <- read.delim(data_url) |>
  rename(Production = "Value")

print(ggplot(bf, aes(Year, Production)) +
   geom_line(aes(group = Country)) +
   ## using point shapes 21-25 gives fillable points (circle, square, etc.)
   ## size = 3 makes the points a little bigger
   geom_point(aes(fill = Country), shape = 21, size = 3) +
   ## make room for direct labels by adding a virtual point at x=2007
   expand_limits(x = 2007) +
   ## direct control of labels. dl.trans(...) nudges the label
   ##  a bit to the right. "last.points" finds the max y-value for
   ##  each category, places the label there
   geom_dl(aes(color = Country, label = Country),
           method = list(dl.trans(x=x+0.25), "last.points")) +
   ## using geom_dl() doesn't automatically turn off the legend
   theme(legend.position = "none") +
   scale_y_continuous(
     ## y-axis labels with millions as 'M'
     ## https://stackoverflow.com/a/62919696/190277
     labels = label_number(scale_cut = cut_short_scale()),
     ## a square-root transformation is definitely weird (don't
     ## do this in real life), but is a nice compromise between
     ## linear (which squashes low values too much) and log transformation
     ## (which squashes large values too much)
     trans = "sqrt")
)




