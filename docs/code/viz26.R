## boxplots, coordinate-flipping, std errors
## improve our direct labels

library(readr)
library(dplyr)
library(ggplot2); theme_set(theme_bw(base_size=15))
library(directlabels)

## Lazily change the aspect ratio
## pdf(width=10)

## Data from FAO; plot used to be famous among Ben
#### pix/bananasbananas.webp
bf <- (read_tsv("data/bananas.tsv")
	## Should have used rename
	|> transmute(Year, Country, Production=Value)
)

bf <- (bf
	|> mutate(across(Country, ~ reorder(., Production, decreasing=TRUE)))
)
summary(bf |> mutate(across(where(is.character), factor)))

print(ggplot(bf)
	+ aes(y=Country, x=Production)
	+ geom_boxplot()
	+ scale_x_log10()
)
## We used to do this with coord_flip, but that is needed less often now

quit() ## DO NOT FORGET to remove this

linPlot <- direct.label(ggplot(bf)
	+ aes(Year, Production, color=Country)
	+ geom_line()
	+ labs(y="Banana production (tons)")
)

print(linPlot)
print(linPlot + scale_y_log10())


print(linPlot + (bf |> filter(Country!="Ecuador")))
