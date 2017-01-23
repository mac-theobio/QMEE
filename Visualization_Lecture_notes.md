---
title: "Data Visualization in R"
author: Jonathan Dushoff and Ben Bolker
date: "12:57 22 January 2017"
---

# Ideas

***

- Exploratory vs. diagnostic vs. presentation
- [Cleveland hierarchy](http://sfew.websitetoolbox.com/post/clevelands-graphical-features-hierarchy-4598555): position, length, angle, area, volume, colour
- [Edward Tufte](http://en.wikipedia.org/wiki/Edward_tufte): chartjunk, data- and non-data-ink, small multiples, "information at the point of need"/direct labeling, ...
- graphics nazis: [dynamite plots](http://emdbolker.wikidot.com/blog:dynamite), [pie charts](http://www.qualia.hr/pie-chart-controversy/), [dual-axes plots](http://www.perceptualedge.com/articles/visual_business_intelligence/dual-scaled_axes.pdf) ... 
-   Extending the pipeline: R vs [GLE](http://glx.sourceforge.net/) vs. [D3.js](https://d3js.org/) vs. [plot.ly](https://plot.ly/) vs. ...
-   Telling a story vs. letting the data speak
-   Showing the data vs. representing the statistical model accurately
-   Dynamic graphics

# R

## Base graphics

-   advantages: speed, simplicity, breadth
-   disadvantages: lack of structure, canvas metaphor, clunkiness, fragmentation
-   basic commands:
	-   `plot()`, `lines()` and `points()` and `text()` (add stuff to an existing plot)
	-   `legend()`, `axis()` (for decoration), `par()` (for all kinds of graphics parameters)
	-   other kinds of graphs: `matplot()` for multi-series plots, `boxplot()` for box plots, `hist()` for histograms, `contour()` and `image()`, `pairs`, ...
	-   `par(mfrow)`, `layout()` for multiple plots on a page
	-   useful packages: `car` (for `scatterplot()`, `scatterplotMatrix()`), `plotrix` (miscellaneous "plot tricks")

## Lattice graphics

- alternative, higher-level graphing interface
- `xyplot` (with `type=` one or more of \[`"p"`, `"l"`, `"r"`,`"smooth"`, `"a"` ...\]), `bwplot`
-   Disadvantages: tricky to customize
-   Advantages: abstraction (relative to base graphics), speed (relative to `ggplot`), banking (aspect ratio control), shingles, faceting, 3D plots

## [ggplot](http://ggplot2.org)

Grammar of graphics: create pictures based on _logical_ specifications of what you want to show.

The library is called ggplot2; there is no ggplot1.

-   **data**
	* You are going to want your data in "long" form (probably done with tidyr)
-   **mappings**: between variables in the data frame and **aesthetics**, or graphical attributes
(x position, y position, size, colour ...)
-   **geoms**:
	- simple: `geom_point`, `geom_line`

-   Data and aesthetic mappings set up a plot, but ggplot won't print it:
```r 
	base <- ggplot(my_data,aes(x=age,y=rootgrowth,colour=phosphate))
```

- To make an actual picture, you need a `geom`

```r
print(base + geom_point())
```

equivalent to:

```r
print(ggplot(my_data,aes(x=age,y=rootgrowth,colour=phosphate))
	+ geom_point()
)
```

- more complex: `geom_boxplot`, `geom_smooth`

## more on ggplot

- geoms are **added** to an existing data/mapping combination
- **facets**: `facet_wrap` (free-form wrapping of subplots), `facet_grid` (two-D grid of subplots)
- also: scales, coordinate transformations, statistical summaries, position adjustments
- advantages: pretty defaults (mostly), flexible, easy to overlay model predictions etc.
- disadvantages: slow, magical, tricky to customize
- general graphical strategy:
	- primary response as y axis
	- an important predictor as x axis
		- most important, or most "axis-like" (many values, or continuous)
	- other important predictors as:
		- color; shape; facets
		- roughly in that order
	- Adding predictors:
		- use friendly colors
		- all of these are easier with smallish numbers of categories
		- avoid forcing things into arbitrary categories
	
## challenges:

* more than one continuous predictor
	* use categories when necessary
	* color ramps don't necessary need to be categorized; use a simple, logical progression if you have more than 7 colors
* multivariate responses
* high-dimensional data generally
* factors with lots of (unordered) levels
* spatial data
* phylogenetic trees + tip data
* huge data sets (hexagonal binning, summaries)

ggplot2 [extensions](https://www.ggplot2-exts.org) can help

## Bits and pieces

- [Cookbook for R: Graphs](http://wiki.stdout.org/rcookbook/Graphs/), [R Graph Gallery](http://www.r-graph-gallery.com), [R Graphics Cookbook](http://shop.oreilly.com/product/0636920023135.do) ($$)
- Exporting graphics: bitmap (PNG, JPEG) vs vector (SVG, PDF) representations
- Andrew Gelman's blog: Infovis vs. statistical graphics
-   [Paul Krugman on axes starting from zero](http://krugman.blogs.nytimes.com/2011/09/14/axes-of-evil/)
- Beyond 2D: `googleVis`, `Rggobi`, `rgl`, `Mondrian`, ...

