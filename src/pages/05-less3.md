---
layout: "../layout/PostLayout.astro"
setup: | 
  import YourTurn from "../components/YourTurn.astro"
  import Note from "../components/Note.astro"
  import Warning from "../components/Warning.astro"
  import Tip from "../components/Tip.astro"
lesson: 5
toc_num: 6
---
 
## <a name="less3"> </a> Lesson 5:  On to Data Frames!

Right after vectors, the next major workhorse of R is the *data frame*.
It's a rectangular table consisting of one row for each data point.

Say we have height, weight and age on each of 100 people.  Our data
frame would have 100 rows and 3 columns.  The entry in, e.g., the second
row and third column would be the age of the second person in our data. 
The second row as a whole would be all the data for that second person,
i.e. the height, weight and age of that person.  

**Note that that row would also be cnsidered a vector.  The third column
as a whole would be the vector of all ages in our dataset.**

As our first example, consider the `ToothGrowth` dataset built-in to
R.  Again, you can read about it in the online help by typing

``` r
> ?ToothGrowth
``` (The data turn out to be on guinea pigs, with orange juice or
Vitamin C as growth supplements.)  Let's take a quick look from the
command line.

``` r
> head(ToothGrowth)
   len supp dose
1  4.2   VC  0.5
2 11.5   VC  0.5
3  7.3   VC  0.5
4  5.8   VC  0.5
5  6.4   VC  0.5
6 10.0   VC  0.5
```

R's `head` function displays (by default) the first 6 rows of the
given dataframe.  We see there are length, supplement and dosage
columns, which the curator of the data decided to name `len`, `supp` and 
`dose`.  Each of column is an R vector, or in the case of the second
column, a vector-like object called a *factor*, to be discussed
shortly).  

> <span style="color: #b4637a;">Tip:</span>
> To avoid writing out the long words repeatedly, it's handy to
> make a copy with a shorter name.

``` r
> tg <- ToothGrowth
```

Dollar signs are used to denote the individual columns, e.g.
**ToothGrowth$dose** for the dose column.  So for instance, we can print
out the mean tooth length: 

``` r
> mean(tg$len)
[1] 18.81333
```

Subscripts/indices in data frames are pairs, specifying row and column
numbers.  To get the element in row 3, column 1:

``` r
> tg[3,1]
[1] 7.3
```
which matches what we saw above in our `head` example.  Or, use the 
fact that `tg$len` is a vector:

``` r
> tg$len[3]
[1] 7.3
```

The element in row 3, column 1 in the *data frame* `tg` is element 3
in the *vector* `tg$letn`.  This duality between data frames and
vectors is often exploited in R.

<YourTurn>

> **Your Turn:**  The above examples are fundamental to R, so you should
> conduct a few small experiments on your own this time, little variants
> of the above.  The more you do, the better!

</YourTurn>

For any subset of a data frame `d`, we can extract whatever rows and
columns we want using the format

``` r
d[the rows we want, the columns we want]
```

Some data frames don't have column names, but that is no obstacle.  We
can use column numbers, e.g.

``` r
> mean(tg[,1])
[1] 18.81333
```

Note the expression `[,1]`.  Since there is a 1 in the second position,
we are talking about column 1.  And since the first position, before the
comma, is empty, no rows are specified -- so *all* rows are included.
That boils down to: all of column 1.

A key feature of R is that one can extract subsets of data frames, 
just as we extracted subsets of vectors earlier.  For instance,

``` r
> z <- tg[2:5,c(1,3)]
> z
   len dose
2 11.5  0.5
3  7.3  0.5
4  5.8  0.5
5  6.4  0.5
```

Here we extracted rows 2 through 5, and columns 1 and 3, assigning the
result to `z`.  To extract those columns but keep all rows, do

``` r
> y <- tg[ ,c(1,3)]
```

i.e. leave the row specification field empty.

By the way, note that the three columns are all of the same length, a
requirement for data frames.  And what is that common length in this
case?  R's `nrow` function tells us the number of rows in any data
frame:

``` r
> nrow(ToothGrowth)
[1] 60
```

Ah, 60 rows (60 guinea pigs, 3 measurements each).

Or, alternatively:

``` r
> tg <- ToothGrowth
> length(tg$len)
[1] 60
> length(tg$supp)
[1] 60
> length(tg$dose)
[1] 60
```

So now you know four ways to do the same thing.  But isn't one enough?
Of course.  But in this get-acquainted period, reading all four will
help reinforce the knowledge you are now accumulating about R.  So,
*make sure you understand how each of those four approaches produced the
number 60.*

The `head` function works on vectors too:

``` r
>  head(ToothGrowth$len)
[1]  4.2 11.5  7.3  5.8  6.4 10.0
```

Like many R functions, `head` has an optional second argument,
specifying how many elements to print:

``` r
> head(ToothGrowth$len,10)
 [1]  4.2 11.5  7.3  5.8  6.4 10.0 11.2 11.2  5.2  7.0
```

You can create your own data frames -- good for devising little tests of
your understanding -- as follows:

``` r
> x <- c(5,12,13)
> y <- c('abc','de','z')
> d <- data.frame(x,y)
> d
   x   y
1  5 abc
2 12  de
3 13   z
```

Look at that second line!  Instead of vectors consisting of numbers,
one can form vectors of character strings, complete with indexing
capability, e.g.

``` r
> y <- c('abc','de','z')
> y[2]
[1] "de"
```

As noted, all the columns in a data frame must be of the same length.
Here `x` consists of 3 numbers, and `y` consists of 3 character
strings.  (The string is the unit in the latter.  The number of
characters in each string is irrelevant.)

One can use negative indices for rows and columns as well, e.g.

``` r
> z <- tg[,-2]
> head(z)
   len dose
1  4.2  0.5
2 11.5  0.5
3  7.3  0.5
4  5.8  0.5
5  6.4  0.5
6 10.0  0.5
```

<YourTurn>

> **Your Turn:** Devise your own little examples with the `ToothGrowth`
> data.  For instance, write code that finds the number of cases in which
> the tooth length was less than 16.  Also, try some examples with another
> built-in R dataset, `faithful`.  This one involves the Old Faithful
> geyser in Yellowstone National Park in the US.  The first column gives
> duration of the eruption, and the second has the waiting time since the
> last eruption.  As mentioned, these operations are key features of R,
> so devise and run as many examples as possible; err on the side of
> doing too many!

</YourTurn>

### Recap:  What have we learned in this lesson?

As mentioned, the data frame is the fundamental workhorse of R.  It is
made up of columns of vectors (of equal lengths), a fact that often
comes in handy.  

Unlike the single-number indices of vectors, each element in a data
frame has 2 indices, a row number and a column number.  One can specify
sets of rows and columns to extra subframes.

One can use the R `nrow` function to query the number of rows in a
data frame; `ncol` does the same for the number of columns.
