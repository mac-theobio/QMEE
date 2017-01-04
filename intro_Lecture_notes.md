Programming
===========


`   You may or may not use it for programming tasks, but it will help`\
`   if you understand roughly how it works inside.`

What is a program?

`   A program is a collection of simple instructions (read, write, send,`\
`   manipulate, calculate) that should be executed in a logical order`

`   A program's flow is controlled by control structures (instructions`\
`   about what instruction to do next)`

`   What are some examples of programs, and how do they work?`


Basic instructions
==================

Calculation
-----------

R works as a calculator.



What about 7+3\*9? 32/4\*4? Figure out what the second one does, and
then explain how you would write it more clearly.

Assignment
----------

R can remember numbers and give them back to you. This is the foundation
of being able to write programs that do many things in a specified
order.



Objects
=======

R keeps track of a variety of objects: data structures and functions
mostly. You can see all of your user-defined objects by typing
`objects()` (the parentheses mean that you are calling a *function*;
more on this later).

Values
------

In addition to numbers, R has other kinds of "values". The main ones
we're interested in are "character", "numeric" and "logical" (ie.,
`TRUE` or `FALSE`). `str` is one way to try to figure out what your R
object is.


char &lt;- "Hello, class?" str(char)

logic &lt;- TRUE \#\# Note lack of quotes str(logic) </source-file>


Types
-----

R objects are divided into types. For now, we're mostly interested in
three of these: *vectors*, *lists* and *functions*.

### Vectors

A vector consists of zero or more values of the same *storage mode*

"little", "lamb")

1.  1.  c() puts elements together into a vector

str(words)

print(v &lt;- 1:5) \#\# 'm:n' creates a sequence from m to n str(v)


#### Vector math

R does math on vectors directly. If we add two vectors we add each pair
of corresponding elements. If we multiply a vector by a "scalar" (a
single number) we multiply each element by the scalar. Avoid arithmetic
involving two vectors of different length (except the scalar case, which
cannot be avoided).

2\*w </source-file>


### Numbers

R does not have any particular idea of individual numbers (or strings,
etc.); you represent a number as a vector of length 1. This has
advantages and disadvantages.

### Lists

A list is a bunch of things in order. Those things can be any R object
-- vectors, functions, other lists ...

str(L) str(L[1](1.html)) \#\# L[1](1 "wikilink") picks out the
first element of the list

LL &lt;- list(L, c(2, 7, 9)) str(LL) str(LL[1](1.html))


### Functions

Functions are "called" using parentheses. A function is a set of
commands that uses whatever "arguments" are inside the parentheses and
does things (including possibly "returning" a result).

What functions have we seen so far?

Example: `mean()` in its simplest form takes a vector argument and
returns the mean.


x &lt;- 1:10 m\_x &lt;- mean(x) print(m\_x) </source-file>


You can learn about any built-in function by using R's help: type
`?"mean"` or `help("mean")`.

Arguments can be passed to functions in order, or by using names. For
example, `mean` takes an optional argument `trim`.

trim=0.1) </source-file>


#### Syntax

"=" is a synonym for "&lt;-" at the top level (and many people use it).
Be aware that they are not synonyms inside a function call: "&lt;-"
still means assignment, but "=" is used to name an argument.

R variable names are case-sensitive. This means that `m` and `M` are
different variables.

R variable names have to start with a letter, and certain characters
(particularly space characters) are not allowed. Good naming conventions
may include:

-   Using mostly or only letters and underscores ("\_")
    -   some people prefer dot (".") to underscore


-   Not using potentially confusing names like "l" or "O".


-   Not using built-in names (like "c" or "list") for variables.


-   Many people use `camelCase` or `underscore_spacing` or `dot.spacing`
    to make readable variable names
    -   but it's also better not to use
        `variableNamesThatAreExcessivelyLong`

Compound objects
================

R is a sophisticated system that builds complicated structures on top of
these simple objects. Hopefully we'll develop an intuition for more of
that as we go along. People interested in nuts and bolts can also look
at the (rather scary!) R language definition on the [R manuals
page](http://cran.r-project.org/manuals.html). For now, we'll talk about
just a few structures.

Matrices
--------

In R, matrices are basically vectors that understand that they have a
shape. R knows how to do matrix multiplication on them, which is very
cool, and other kinds of linear algebra. There are many ways to make a
matrix: use `?"matrix"` to get more information.

nrow=2))

1.  R arranges vectors into matrices in COLUMN-FIRST order, by default


1.  Elementwise ("vector") multiplication (or "Hadamard product")

m\*m

1.  Matrix multiplication

m %\*% m </source-file>


Data frames
-----------

Data frames are lists that have a rectangular shape (they look like, and
can be used a like matrices, but don't have to be of a single "mode" --
in particular you can mix numbers, factors (see below), dates, ...).

We'll talk more about data frames when we start dealing with data.

Factors
-------

Factors are used to describe items that can have a known set of values
(gender, social class, etc.) -- *categorical variables* in statistical
terms. We will also talk more about them later.

Control structures
==================

Control structures in R include:

-   loops: we will use `for`, `lapply` and `apply`, among others.
    `lapply` stands for **l**ist **apply**.


-   conditionals: `if` and `ifelse`. Use `ifelse` with care!


`   print(x^2)`

}

for (x in v){

`   if(x>=4) {`\
`       print(x^2)`\
`   }`

} </source-file>


R uses `==` to test equality, and `!=` to test inequality. (R will often
guess and warn you if you wrongly try to use `=`, but not always ...)

Use `&` for "and", and `|` for "or" **when testing vectors in parallel**
(use `&&` and `||` for testing single conditions: if this makes no sense
to you, stick to `&` and `|`).

Syntax
------

You may have noticed that we sometimes just state something in order to
print its value. This does not always work inside of loops. It's better
practice to always say `print`, when that's what you want.

Names
=====

R's primary objects often have associated "attributes". The information
that tells R what shape a matrix (or higher-dimensional array) is is an
attribute. R also has "name" attributes: `names`, `rownames` and
`colnames`.

You can select single elements from an R object using the element
operator [](.html), and subsets using the subset operator `[]`. If
the object has dimensions, you can separate them with a comma.

You can also select things by name, using the syntax `v["name"]` or
`v[n]`, if `n` is a variable that contains the name. In general it's a
good idea to use names instead of numbers whenever you can, because (1)
your code will be easier to read (`x["temperature"]` instead of `x[21]`)
and (2) your code will be more robust (i.e., if you modify something so
that temperature is now in position 22 rather than 21).

head(InsectSprays) names(InsectSprays)

1.  Select the first list element of InsectSprays

InsectSprays[1](1.html)

1.  Select a subset of InsectSprays containing only the first list
    element

InsectSprays\[1\]

1.  Select the first column of InsectSprays

InsectSprays\[, 1\]

1.  Select part of the first column of InsectSprays

InsectSprays\[1:10, 1\]

1.  Select the first list element of InsectSprays by name

InsectSprays["count"]("count".html)

1.  Use a convenient but sometimes dangerous short-cut for this

InsectSprays\$count </source-file>


Arcane
======

You may have been surprised by the column-selection results. We used the
subset operator, but got a single element instead. R noticed we only
selected one thing, and "collapsed" the object for our "convenience".
This sort of thing is a common problem in R, probably due to its rather
ancient history, and the tension between structure and convenience
(particularly convenience for interactive use).

In programs, it is bad practice to let R do this (because it will
confuse the program when the structure of your results changes). In this
case, you can avoid it by selecting from the list. Another trick that
works is this:


1.  A data frame

InsectSprays\[, 1:2\]

1.  An inappropriate "collapse" to a simpler form

InsectSprays\[, 1\]

1.  Avoid inappropriate collapse

InsectSprays\[, 1, drop=FALSE\] </source-file>

