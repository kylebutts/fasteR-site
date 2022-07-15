---
layout: "../layout/PostLayout.astro"
lesson: 28
toc_num: 29
---
 
## <a name="appfam"> </a> Lesson 28:  Should You Use Functional Programming?

Earlier in this tutorial, we've found R's `tapply` function to be
quite handy.  There are several others in this family, notably
 `apply`, `lapply` and `sapply`.  In addition, there are other
related functions, such as `do.call` and `Reduce()`.  And there are
a number of counterparts in the Tidyverse `purrr` package.
All of these go under the aegis of `functional programming` (FP).

To many, FP is intended as a higher-level replacement for loops, and
some members of the R community view that as desirable, even a must.  I
personally take a more moderate point of view, but before discussing the
controversy, let's see how FP works as a loop-replacement.

As a simple example, say we have a nonnegative integer vector `x`, and
want code that counts doubles each element that is greater than 9.
Of course, this is something we should not use a loop with in the first
place.  We should take advantage of R's vectorization capabilities:

``` r
x <- ifelse(x > 9,2*x,x)

```

But let's ignore vectorization, for the sake of illustrating the issues,
and write up a loop version:

``` r
for (i in 1:5) if (x[i] > 9) x[i] <- 2 * x[i]
```

Now, how would we replace this loop by a call to R's `sapply` function?
The latter has the call form

``` r
sapply(X,FUN)
```

where `X` is an R factor and `FUN` is a function.  We will assume
here that `FUN` returns a number, not a vector or other R object.  The
action of the function is to apply `FUN` on each element of `X`,
producing a new vector.  (It of course can be reassigned to the old
one.)

The key is defining `FUN`:

``` r
doubleIt <- function(z) if(z > 9) return(2*z) else return(z)
sapply(x,doubleIt)
```

Let's check:

``` r
> x <- c(5,12,13,8,88)
> x <- sapply(x,doubleIt)
> x
[1]   5  24  26   8 176
```

Or, we can use what is called an `anonymous` function:

``` r
> x <- c(5,12,13,8,88)
> x <- sapply(x,function(z) if(z > 9) return(2*z) else return(z))
> x
[1]   5  24  26   8 176
```

Instead of defining the function separately, we define it right there in
the second argument of `sapply`.  
 
Now let's consider something more elaborate.  Recall our earlier
baseball player example, in which we wanted to fit separate regression
lines to each of the four player position categories.  We used a loop,
which for convenience I'll duplicate here:

``` r
rownums <- split(1:nrow(mlb),mlb$PosCategory)
posNames <- c('Catcher','Infielder','Outfielder','Pitcher')
m <- data.frame()
for (pos in posNames) {
  lmo <- lm(Weight ~ Age, data = mlb[rownums[[pos]],])
  newrow <- lmo$coefficients
  m <- rbind(m,newrow)
}
```

How might we do this in FP?  We've seen the `tapply` function a couple
of times already.  Now let's turn to `lapply` ("list apply").  The
call form is

``` r
lapply(VectorOrList,FUN)
```

This first argument must be a vector or list, and the second argument
must be the name of a one-argument function.  This calls
`FUN` on each element of `VetorcOrList`, placing the
return values in a new list.

How might we use that here?  Well, `lapply`, as the name implies, is
aimed at working on lists.  Do we have any?  Why yes, `rownums` is a
list!

And indeed, we do want to take some action on each element of that list:
We want to fit a linear regression model to the rows in that element.
It is natural, then, to take for `FUN` the following function:

``` r
zlm <- function(rws) lm(Weight ~ Age, data=mlb[rws,])$coefficients
```

Here `rws` is a set of row numbers, e.g. those for the pitchers.  This
function calls `lm` on those rows, i.e. on the data `mlb[rws,]`,
then extracts the regression coefficients.

The code then is

``` r
> zlm <- function(rws) lm(Weight ~ Age, data=mlb[rws,])$coefficients
> w <- lapply(rownums,zlm)
```

The call to `lapply` then says, run `zlm` on each set of rows we see
in `rownums`, placing the coefficient vectors in an output list.
Specifically: Recall that the first element of `rownums` was
`rownums[['catcher']]`.  So, first `lapply` will make the call

``` r
zlm(rownums[['Catcher']])
```

which will fit the desired regression model on the catcher data.  Then
`lapply` will do

``` r
zlm(rownums[['Infielder']])
```

and so on.  The outputs of the four `lm` calls will be returned in an
R list, which we have assigned to `w` above.  Let's check the first
one:

``` r
> w[[1]]
(Intercept)         Age 
180.8280290   0.7949252 
``` 
jibing with `m[1,]` in our data-frame/loop appraoch above.

Well, then, what did we accomplish -- if anything -- by using `lapply`
here rather than our earlier approach using a loop?  Certainly the
 `lapply` version did make for more compact code, just 2 lines.  But we
had to think a harder to come up with the idea.  Also, printing it
out is less compact:

``` r
> w
$Catcher
(Intercept)         Age 
180.8280290   0.7949252 

$Infielder
(Intercept)         Age 
170.2465739   0.8589593 

$Outfielder
(Intercept)         Age 
176.2884016   0.7883343 

$Pitcher
(Intercept)         Age 
185.5993689   0.6543904 
```

(Actually, we can use `sapply` here instead of `lapply`, with a
nicer printing.)

So, should beginning R coders use FP?  Actually, even I, with decades of
coding experience, take a moderate approach.  The criterion for
loop-based (LB) code vs.  FP should be to ask these questions:

* Would FP code be easier to write than LB in this case?

* Would FP code be easier to debug than LB in this case?

* Would FP code be easier to read -- either by others, or by myself 6
  months from now -- than LB in this case?

For the code in this tutorial in which we've used `tapply`, I believe
the answers to the above questions are definitely Yes.  But for the
`lapply` example above, I would say the answer is No -- *especially
for beginning coders*, but even for myself.  

Beginners are in the process of learning functions.  FP by definition is
based on writing functions, thus making FP a more abstract and difficult
process.  And I certainly disagree with the doctrinnaire view of some
that one should never write loops.

My recommendation is to take things on a case-by-case basis.

Now, let's turn to another central function in the `apply` family.
Not surprisingly, it's named`apply`!  It is usually used on
`matrix` objects (like data frames, but with the contents being all of
the same type, e.g. all numerical), on either rows or columnṡ, but can
be used on data frames too.

The call form is

``` r
apply(d,rc,g)
```

Here R will apply the function `g` to each row (`rc` = 1) or column
(`rc` = 2) of the data `d`.  If the function `g` returns a number,
then `apply` will return a vector.

Let's find the max values for the variables in the `pima` data:

``` r
> apply(pima,2,max)
 pregnant   glucose diastolic   triceps   insulin       bmi  diabetes
age 
    17.00    199.00    122.00     99.00    846.00     67.10      2.42
81.00 
     test 
     1.00 
```

Note that to use the  `apply` family, you can either use a built-in R
function, e.g. `max` here, or one you write yourself, such as `zlm`
above.

The R `apply` family includes other functions as well,  They are quite
useful, but don't use them solely for the sake of avoiding writing a loop.
More compact code may not be easier.
