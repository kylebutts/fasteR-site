---
layout: "../layout/PostLayout.astro"
setup: | 
  import YourTurn from "../components/YourTurn.astro"
  import Note from "../components/Note.astro"
  import Warning from "../components/Warning.astro"
  import Tip from "../components/Tip.astro"
lesson: 4
toc_num: 5
---
 
## <a name="less2"> </a> Lesson 4:  More on Vectors

Continuing along the Nile, say we would like to know in how many years
the level exceeded 1200.  Let's first introduce R's `sum` function:

``` r
> sum(c(5,12,13))
[1] 30
```

Here the `c` function built a vector consisting of
5, 12 and 13.  That vector was then fed into the `sum` function,
returning 5+12+13 = 30.

By the way, the above is our first example of *function composition*,
where the output of one function, `c` here, is fed as input into
another, `sum` in this case.

We can now use this to answer our question on the `Nile` data:

``` r
> sum(Nile > 1200)
[1] 7
```

The river level exceeded 1200 in 7 years.

**But how in the world did that work?**  Bear with me a bit here.  Let's
look at a small example first:

``` r
> x <- c(5,12,13)
> x
[1]  5 12 13
> x > 8
[1] FALSE  TRUE  TRUE
> sum(x > 8)
[1] 2
```

First, notice something odd here, in the expression `x > 8`. Here
`x` is a vector, 3 elements in length, but 8 is just a number.  It
would seem that it's nonsense to ask whether a vector is greater than a
number; they're different animals.

But R makes them "the same kind" of animal, by extending that number 8
to a 3-element vector 8,8,8.  This is called *recycling*.  This sets up
an element-by-element comparison:  Then, the 5 in `x` is compared to
the first 8, yielding `FALSE` i.e. 5 is NOT greater than 8.  Then 12 is
compared to the second 8, yielding `TRUE`, and then the comparison of 13
to the third 8 yields another `TRUE`.  So, we get the vector
`FALSE`, `TRUE`, `TRUE`.

Fine, but how will `sum` add up some `TRUE`s and `FALSE`s?  The
answer is that R, like most computer languages, treats `TRUE` and `FALSE` as
`1` and `0`, respectively.  So we summed the vector (0,1,1), yielding 2.

Getting back to the question of the number of years in which the Nile
flow exceeded 1200, let's look at that expression again:

``` r
> sum(Nile > 1200)
```

Since the vector `Nile` has length 100, that number 1200 will be
recycled into a vector of one hundred copies of 1200.  The `>`
comparison will then yield 100 `TRUE`s and `FALSE`s, so summing gives us the
number of `TRUE`s, exactly what we want.

<YourTurn>

> **Your Turn:** Try a few other experiments of your choice using `sum`.
> I'd suggest starting with finding the sum of the first 25 elements in
> `Nile`.  You may wish to start with experiments on a small vector, say
> (2,1,1,6,8,5), so you will know that your answers are correct.
> Remember, you'll learn best nonpassively.  Code away!

</YourTurn>

A question related to *how many* years had a flow above 1200 is *which*
years had that property.  Well, R actually has a `which` function:

``` r
> which(Nile > 1200)
[1]  4  8  9 22 24 25 26
```

So the 4th, 8th, 9th etc. elements in `Nile` had the queried property.
(Note that those were years 1875, 1879 and so on.)

In fact, that gives us another way to get the count of the years with
that trait:

``` r
> which1200 <- which(Nile > 1200)
> which1200
[1]  4  8  9 22 24 25 26
> length(which1200)
[1] 7
```

Of course, as usual, my choice of the variable name `which1200` was
arbirary, just something to help me remember what is stored in that
variable.

R's `length` function does what it says, i.e. finding the length of a
vector.  In our context, that gives us the count of years with flow
above 1200.

And, what were the river flows in those 7 years?

``` r
> which1200 <- which(Nile > 1200)
> Nile[which1200]
[1] 1210 1230 1370 1210 1250 1260 1220
```


Finally, something a little fancier.  We can combine steps above:

``` r
> Nile[Nile > 1200]
[1] 1210 1230 1370 1210 1250 1260 1220
```

We just "eliminated the middle man," `which1200`.  The R interpreter
saw our `Nile > 1200`, and thus generated the corresponding TRUEs and
FALSEs.  The R interpreter then treated those TRUEs and 
FALSEs as subscripts in `Nile`, thus extracting the desired data.

Now, we might add here, "Don't try this at home, kids."  For
beginners, it's really easier and more comfortable to break things into
steps.  Once, you become experienced at R, you may wish to start
skipping steps.  

Less bold is the notion of negative indices, e.g.

``` r
> x <- c(5,12,13,8)
> x[-1]  
[1] 12 13  8
```

<YourTurn>

> **Your Turn:** 
> Here we are asking for all of `x` *except* for `x[1]`.  Can you
> guess what `x[c(-1,-4)]` evaluates to?  Guess first, then try it out.

</YourTurn>

### Recap:  What have we learned in this lesson?

Here you've refined your skillset for R vectors, learning R's recycling
feature, and two tricks that R users employ for finding counts of things.

Once again, as you progress through this tutorial, you'll see that these
things are used a lot in R.
