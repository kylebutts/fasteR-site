---
layout: "../layout/PostLayout.astro"
lesson: 11
toc_num: 12
---
 
## <a name="less6"> </a> Lesson 11:  The R List Class

We saw earlier how handy the **tapply** function can be.  Let's look at
a related one, **split**.

Earlier we mentioned the built-in dataset **mtcars**, a data frame.
Consider **mtcars$mpg**, the column containing the miles-per-gallon
data.  Again, to save typing and avoid clutter in our code, let's make a
copy first:

```r
> mtmpg <- mtcars$mpg
```

Suppose we wish to split the original vector into three vectors, 
one for 4-cylinder cars, one for 6 and one for 8.  We *could* do

```r
> mt4 <- mtmpg[mtcars$cyl == 4]
```

and so on for **mt6** and **mt8**.

> **Your Turn:**  In order to keep up, make sure you understand how that
> line of code works, with the TRUEs and FALSEs etc.  First print out the
> value of **mtcars$cyl == 4**, and go from there.


But there is a cleaner way:

```r
> mtl <- split(mtmpg,mtcars$cyl)
> mtl
$`4`
 [1] 22.8 24.4 22.8 32.4 30.4 33.9 21.5 27.3 26.0 30.4 21.4

$`6`
[1] 21.0 21.0 21.4 18.1 19.2 17.8 19.7

$`8`
 [1] 18.7 14.3 16.4 17.3 15.2 10.4 10.4 14.7 15.5 15.2 13.3 19.2 15.8 15.0
> class(mtl)
[1] "list"
```

In English, the call to **split** said, "Split **mtmpg** into multiple
vectors, with the splitting criterion being the correspond
values in **mtcars$cyl**."


Now **mtl**, an object of R class **"list"**, contains the 3 vectors.
We can access them individually with the dollar sign notation:

```r
> mtl$`4`
 [1] 22.8 24.4 22.8 32.4 30.4 33.9 21.5 27.3 26.0 30.4 21.4
```

Or, we can use indices, though now with double brackets:

```r
> mtl[[1]]
 [1] 22.8 24.4 22.8 32.4 30.4 33.9 21.5 27.3 26.0 30.4 21.4
```

Looking a little closer:

```r
> head(mtcars$cyl)
[1] 6 6 4 6 8 6 
``` 

We see that the first car had 6 cylinders, so the
first element of **mtmpg**, 21.0, was thrown into the `6` pile, i.e.
**mtl[[2]]** (see above printout of **mtl**), and so on.

And of course we can make copies for later convenience:

```r
> m4 <- mtl[[1]]
> m6 <- mtl[[2]]
> m8 <- mtl[[3]]
```

Lists are especially good for mixing types together in one package:

```r
> l <- list(a = c(2,5), b = 'sky')
> l
$a
[1] 2 5

$b
[1] "sky"
```

Note that here we can give names to the list elements, 'a' and 'b'.  In
forming **mtl** using **split** above, the names were assigned
according to the values of the vector beiing split.  (In that earlier
case, we also needed backquotes ``   ``, since the names were numbers.)


If we don't like those default names, we can change them:

```r
> names(mtl) <- c('four','six','eight')
> mtl
$four
 [1] 22.8 24.4 22.8 32.4 30.4 33.9 21.5 27.3 26.0 30.4 21.4

$six
[1] 21.0 21.0 21.4 18.1 19.2 17.8 19.7

$eight
 [1] 18.7 14.3 16.4 17.3 15.2 10.4 10.4 14.7 15.5 15.2 13.3 19.2 15.8
15.0
```

What if we want, say, the MPG for the third car in the 6-cylinder
category?

```r
> mtl[[2]][3]
[1] 21.4
```

The point is that **mtl[[2]]** is a vector, so if we want element 3 of
that vector, we tack on [3].

Or,

```r
> mtl$six[3]
[1] 21.4
``` 

By the way, it's no coincidence that a dollar sign is used for
delineation in both data frames and lists; data frames *are* lists.
Each column is one element of the list.  So for instance,

```r
> mtcars[[1]]
 [1] 21.0 21.0 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 17.8 16.4 17.3 15.2 10.4
[16] 10.4 14.7 32.4 30.4 33.9 21.5 15.5 15.2 13.3 19.2 27.3 26.0 30.4 15.8 19.7
[31] 15.0 21.4
```

Here we used the double-brackets list notation to get the first element
of the list, which is the first column of the data frame.

> **Your Turn** Try using **split** on the ToothGrowth data, say splitting
> into groups according to the supplement, and finding various quantities.
