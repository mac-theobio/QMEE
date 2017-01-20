Ideas
-----

-   Exploratory vs diagnostic vs presentation
-   [Cleveland
    hierarchy](http://processtrends.com/toc_data_visualization.htm):
    position, length, angle, area, volume, colour
-   [Edward Tufte](http://en.wikipedia.org/wiki/Edward_tufte): data- and
    non-data-ink, small multiples, direct labeling, ...
-   graphics nazis: [dynamite
    plots](http://emdbolker.wikidot.com/blog:dynamite), [pie
    charts](http://www.qualia.hr/pie-chart-controversy/), [dual-axes
    plots](http://www.perceptualedge.com/articles/visual_business_intelligence/dual-scaled_axes.pdf) ...
-   Extending the pipeline: R vs [GLE](http://glx.sourceforge.net/)
    vs ...
-   Telling a story vs. letting the data speak
-   Showing the data vs. representing the statistical model accurately
-   Dynamic graphics

R
-

-   Base graphics
    -   advantages: speed, simplicity, breadth
    -   disadvantages: lack of structure, canvas metaphor, clunkiness,
        fragmentation
    -   basic commands:
        -   `plot()`, `lines()` and `points()` and `text()` (for adding
            stuff to an existing plot)
        -   `legend()`, `axis()` (for decoration), `par()` (for all
            kinds of graphics parameters)
        -   other kinds of graphs: `matplot()` for multi-series plots,
            `boxplot()` for box plots, `hist()` for histograms,
            `contour()` and `image()`, `pairs`, ...
        -   `par(mfrow)`, `layout()` for multiple plots on a page
        -   useful packages: `car` (for `scatterplot()`,
            `scatterplotMatrix()`), `plotrix` (for a million little bits
            and pieces)
-   Lattice: `xyplot` (with `type=` one or more of \[`"p"`, `"l"`,
    `"r"`,`"smooth"`, `"a"` ...\]), `bwplot`
    -   Disadvantages: tricky to customize
    -   Advantages: abstraction (relative to base graphics), speed
        (relative to `ggplot`), banking (aspect ratio control),
        shingles, faceting, 3D plots
-   [ggplot(2)](http://had.co.nz/ggplot2)
    -   **data**
    -   **aesthetic mappings**: between variables in the data frame and
        **aesthetics**, or graphical attributes (x position, y position,
        size, colour ...)
    -   first two show up as (e.g.) `ggplot(my_data,`
        `aes(x=age,y=rootgrowth,colour=phosphate))`
    -   **geoms**:
        -   simple: `geom_point`, `geom_line`:

`qplot(age,rootgrowth,colour=phosphate,data=my_data)` **or**
`ggplot(my_data,`
`aes(x=age,y=rootgrowth,colour=phosphate))+geom_point()`

more complex: `geom_boxplot`, `geom_smooth`

-   -   geoms are **added** to an existing data/mapping combination
    -   **facets**: `facet_wrap` (free-form wrapping of subplots),
        `facet_grid` (two-D grid of subplots)
    -   also: scales, coordinate transformations, statistical summaries,
        position adjustments
    -   advantages: pretty defaults (mostly), flexible, easy to overlay
        model predictions etc.
    -   disadvantages: slow, magical, tricky to customize
-   general strategy for using ggplot or lattice:
    -   primary response as y axis
    -   primary predictor as x axis, preferably continuous
    -   next (categorical) predictors as groupings
        (preferably colour/shape) within facets
    -   next (categorical) predictors as facets
-   challenges:
    -   &gt;1 continuous predictor (we can always discretize continuous
        predictors, but we lose information)
    -   multivariate responses
    -   high-dimensional data generally
    -   factors with lots of (unordered) levels
    -   spatial data
    -   huge data sets (hexagonal binning, summaries)

Bits and pieces
---------------

-   [Cookbook for R: Graphs](http://wiki.stdout.org/rcookbook/Graphs/),
    [R Graph Gallery](http://gallery.r-enthusiasts.com/), [R Graphics
    Cookbook](http://shop.oreilly.com/product/0636920023135.do)
    (\$\$ book)
-   Exporting graphics: bitmap (PNG, JPEG) vs vector (SVG, PDF)
    representations
-   Andrew Gelman's blog: Infovis vs. statistical graphics
-   [Paul Krugman on axes starting from
    zero](http://krugman.blogs.nytimes.com/2011/09/14/axes-of-evil/)
-   Beyond 2D: googleVis, Rggobi, rgl, Mondrian, ...
-   Python: scipy, matplotlib


