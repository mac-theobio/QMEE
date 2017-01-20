ggplot example ========================================================

\`\`\`{r opts,echo=FALSE} opts\_chunk\$set(message=FALSE,warning=FALSE)
\#\# cheating \`\`\`

\`\`\`{r pkgs} library(mlmRev) \#\# for contraception data
library(ggplot2) library(grid) \#\# for unit() \`\`\`

\`\`\`{r} theme\_set(theme\_bw()+theme(panel.margin=unit(0,"lines")))
\`\`\`

\`\`\`{r} g1 &lt;- ggplot(Contraception,aes(x=age,y=use))+

` labs(x="Centered age",y="Contraceptive use")`

print(g1+geom\_point()) \`\`\`

Not very useful!

Use a fancy component (\`stat\_sum\`) that calculates the proportion of
the data in a given category that fall at exactly the same \$\\{x,y\\}\$
location, and by default changes the size of the symbol proportionally:
\`\`\`{r} print(g1+stat\_sum()) \`\`\`

Use transparency -- not a mapping (which would be inside an \`aes()\`
function) but a hard-coded value: \`\`\`{r}
print(g1+stat\_sum(alpha=0.25)) \`\`\`

Distinguish by number of live children: \`\`\`{r} g2 &lt;-
ggplot(Contraception,aes(x=age,y=use,colour=livch))+

`   labs(x="Centered age",y="Contraceptive use")`

g3 &lt;- g2+stat\_sum(alpha=0.25) print(g3) \`\`\`

Add smooth lines: \`\`\`{r} print(g4 &lt;- g3 +
geom\_smooth(aes(y=as.numeric(use)))) \`\`\`

Adjust the axis limits. \`\`\`{r} print(g4 &lt;- g3 +
geom\_smooth(aes(y=as.numeric(use)))+

`       coord_cartesian(ylim=c(0.9,2.1)))`

\`\`\` Technical details:

-   we need to know that the numeric values on the \$y\$ axis actually
    correspond to the underlying \*\*numeric\*\* factor codes (N=1,Y=2);
-   we use \`coord\_cartesian(ylim=...)\` rather than just saying
    \`+ylim(0.9,2.1)\`, which will erase the confidence-interval ribbons
    that go below the lower limits of the graph

Facet by urban/rural: the syntax is \`rows\~columns\`, and \`.\` here
means "nothing", or "only a single row" (cf. \`facet\_wrap\`) \`\`\`{r}
g4+facet\_grid(.\~urban) \`\`\`

Separate urban/rural by line type instead (and turn off
confidence-interval ribbons): \`\`\`{r} g3 +
geom\_smooth(aes(y=as.numeric(use),

`                           lty=urban),se=FALSE)`

\`\`\`

-   Technical detail: we need \`as.numeric(use)\` because \`use\` is
    a factor.

Or make the confidence-interval ribbons light (\`alpha=0.1\`) instead of
turning them off completely: \`\`\`{r} g3 +
geom\_smooth(aes(y=as.numeric(use),

`                    lty=urban),alpha=0.1)`

\`\`\`

Advanced topic: smooth by fitting a polynomial logistic regression.
\`\`\`{r} g5 &lt;- ggplot(Contraception,aes(x=age,

`                              y=as.numeric(use)-1,`\
`                              colour=livch))+`\
` stat_sum(alpha=0.25)+labs(x="Centered age",y="Contraceptive use")`

g5 + geom\_smooth(aes(lty=urban),method="glm",

`                    family="binomial",`\
`                    formula=y~poly(x,2),alpha=0.1)`

\`\`\` Technical details:

-   have to convert \$y\$ from (1,2) to (0,1) so that logistic
    regression makes sense

A more common use would be to use \`method="lm"\` to get linear
regression lines for each group.

Two-way faceting: \`\`\`{r} g1 +
facet\_grid(livch\~urban)+geom\_smooth(aes(y=as.numeric(use))) \`\`\`
This is nice, although a plot without data is always a little
scary.</source-file>
