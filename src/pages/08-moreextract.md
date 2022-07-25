---
layout: "../layout/PostLayout.astro"
setup: | 
  import YourTurn from "../components/YourTurn.astro"
  import Note from "../components/Note.astro"
  import Warning from "../components/Warning.astro"
  import Tip from "../components/Tip.astro"
lesson: 8
toc_num: 9
---
 
## <a name="moreextract"> </a> Lesson 8:  More Examples of Extracting Rows, Columns

Often we need to extract rows or columns from a data frame, subject to
more than one condition.  For instance, say we wish to extract from
**tg** the sub-data frame consisting of OJ and length less than 8.8.  

We could do this, using the ampersand symbol `&`, which means a logical
AND operation:

``` r
> tg[tg$supp=='OJ' & tg$len < 8.8,]
   len supp dose
37 8.2   OJ  0.5
```

Ah, it turns out that only one case satisfied both conditions.  

If we want all rows that satisfy at least one of the conditions, not
necessarily both, then we use the OR operator, `|`.  Say we want to
obtain all rows in which either `len` is greater than 28 or the
treatment dose was 1.0 or both:

``` r
> tg[tg$len > 28 | tg$dose == 1.0,]
    len supp dose
11 16.5   VC    1
12 16.5   VC    1
13 15.2   VC    1
14 17.3   VC    1
15 22.5   VC    1
16 17.3   VC    1
17 13.6   VC    1
18 14.5   VC    1
19 18.8   VC    1
20 15.5   VC    1
23 33.9   VC    2
26 32.5   VC    2
30 29.5   VC    2
41 19.7   OJ    1
42 23.3   OJ    1
43 23.6   OJ    1
44 26.4   OJ    1
45 20.0   OJ    1
46 25.2   OJ    1
47 25.8   OJ    1
48 21.2   OJ    1
49 14.5   OJ    1
50 27.3   OJ    1
56 30.9   OJ    2
59 29.4   OJ    2
```

By the way, note that the original row numbers are displayed too.  For
example, the first case satisfying the conditions was row number 11 in
the original data frame `tg`.

``` r
> w <- tg[tg$len > 28 | tg$dose == 1.0,]
```

Again, I chose the name `w` arbitrarily.  Names must begin with a
letter, and consist only of letters, digits and a few special
characters such as `-` or `.`

Note that `w` is a new data frame, on which we can perform the usual
operations, e.g.

``` r
> head(w)
    len supp dose
11 16.5   VC    1
12 16.5   VC    1
13 15.2   VC    1
14 17.3   VC    1
15 22.5   VC    1
16 17.3   VC    1
> nrow(w)
[1] 25
```

We may only be interested in say, *how many* cases satisfied the given
conditions.  As before, we can use `nrow` for that, as seen here.

As seen early, we can also extract columns.  Say our analysis will use
only tooth length and dose.  We write `c(1,3)` in the "what columns we
want" place, indicating columns 1 and 3:

``` r
> lendose <- tg[,c(1,3)]
> head(lendose)
   len dose
1  4.2  0.5
2 11.5  0.5
3  7.3  0.5
4  5.8  0.5
5  6.4  0.5
6 10.0  0.5
```

From now on, we would work with `lendose` instead of `tg`.

It's a little nicer, though, the specify the columns by name instead of
number:

``` r
> lendose <- tg[,c('len','dose')]
> head(lendose)
   len dose
1  4.2  0.5
2 11.5  0.5
3  7.3  0.5
4  5.8  0.5
5  6.4  0.5
6 10.0  0.5
```

The logical operations work on vectors too.  For example, say in the
**Nile** data we wish to know how many years had flows in the extremes,
say below 500 or above 1200:

``` r
> exts <- Nile[Nile < 800 | Nile > 1300]
> head(exts)
[1] 1370  799  774  694  701  692
> length(exts)
[1] 27
```

By the way, if this count were our only interest, i.e. we have no
further use for `exts`, we can skip assigning to `exts`, and do
things directly:

``` r
> length(Nile[Nile < 800 | Nile > 1300])
[1] 27
```

This is fine for advanced, experienced R users, but really, "one step at
a time" is better for beginners.

### Recap:  What we've learned in this lesson

Here we got more practice in manipulating data frames, and were
introduced to the logical operators `&` and `|`.  We also saw another
example of using `nrow` as a means of counting how many rows satisfy
given conditions.

Again, these are all "bread and butter" operations that arise quite
freqently in real world R usage.

By the way, note how the essence of R is "combining little things in
order to do big things," e.g. combining the subsetting operation, the
'&' operator, and `nrow` to get a count of rows satisfying given
conditions.  This too is the "bread and butter" of R.  It's up to you,
the R user, to creatively combine R's little operations (and later, some
big ones) to achieve whatever goals you have for your data.  *Programming
is a creative process*.  It's like a grocery store and cooking:  The
store has lots of different potential ingredients, and you decide which
ones to buy and combine into a meal.

<YourTurn>

> **Your turn:**  Try some of these operations on R's built-in
> `faithful` dataset.  For instance, find the number of eruptions for
> which `eruptions` was greater than 3 and waiting time was more than 80
> minutes.

</YourTurn>

