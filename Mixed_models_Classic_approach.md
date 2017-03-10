The classic approach to mixed models involves fitting regular linear
models, but interpreting the "sums of squares" differently.

-   Decompose sums of squares
-   Decide which error terms to put in the denominator, which in the
    numerator, how many degrees of freedom
-   For simplest cases (e.g. one-way ANOVA), the answer is the same
    either way
-   Bestiary of experimental designs: nested, randomized block,
    split-plot (Gotelli and Ellison, Quinn and Keough)
-   For simple nested designs, you often can (and should) simplify your model by simply _aggregating_ at the bottom level (Murtaugh 2007)
	-   ... doesn't work for randomized block and other more complicated designs
-   works (although perhaps with very low power) for any sample size
-   gives negative variance estimates in some situations (e.g.
    population genetics)

