---
layout: "../layout/PostLayout.astro"
lesson: 36
toc_num: 37
---
 
## <a name="whl"> </a> Lesson 36:  R 'while' Loops

We've seen R **for** loops in previous lessons, but there's another kind
of loop, `while`.  It keeps iterating until some specified condition
is met.  We don't know how many iterations will be needed, unlike the
`for` case, with a fixed number of iterations.

As our example, consider `AirPassengers`, which consists of number of
air travelers in thousands, in monthly data from January 1949.  As
usual, let's glance at it first:

``` r
> str(airpass)
 Time-Series [1:144] from 1949 to 1961: 112 118 132 129 121 135 148 148 136 119 ...
```

Suppose we wish to know when the cumulative number of passengers first
exceeded 10 million.  A crude way would be to use R's `cumsum`
("cumulative sums") function:

``` r
> cumsum(airpass)
  [1]   112   230   362   491   612   747   895  1043  1179  1298  1402  1520
 [13]  1635  1761  1902  2037  2162  2311  2481  2651  2809  2942  3056  3196
 [25]  3341  3491  3669  3832  4004  4182  4381  4580  4764  4926  5072  5238
 [37]  5409  5589  5782  5963  6146  6364  6594  6836  7045  7236  7408  7602
 [49]  7798  7994  8230  8465  8694  8937  9201  9473  9710  9921 10101 10302
 [61] 10506 10694 10929 11156 11390 11654 11956 12249 12508 12737 12940 13169
 [73] 13411 13644 13911 14180 14450 14765 15129 15476 15788 16062 16299 16577
 [85] 16861 17138 17455 17768 18086 18460 18873 19278 19633 19939 20210 20516
 [97] 20831 21132 21488 21836 22191 22613 23078 23545 23949 24296 24601 24937
[109] 25277 25595 25957 26305 26668 27103 27594 28099 28503 28862 29172 29509
[121] 29869 30211 30617 31013 31433 31905 32453 33012 33475 33882 34244 34649
[133] 35066 35457 35876 36337 36809 37344 37966 38572 39080 39541 39931 40363
```

We see that that occurred in the 59th month.  But though this approach
would be convenient, it also would be wasteful:  We are calculating *all*
the cumulative sums, even though we don't need them all.  In a really
long vector, this could be slow.  Here is a less wasteful way:

``` r
 tot <- 0
> i <- 0
> while (i <= length(airpass) && tot < 10000) {
+    i <- i + 1
+    tot <- tot + airpass[i]
+ }
> i
[1] 59
```

So, the `while` loop keeps iterating until we get the desired
cumulative total.

Key points here:

* The `&&` operator stands for "and".  

* The condition within the `while` says that (a) we are not yet at the
  end of the `airpass` vector, AND (b) our total is still less than
10000.

* Note the need for the condition `i <= length(airpass)`.  It's
  possible that `tot` will never exceed 10000 (not true here, but we
wouldn't know that *a priori*), so we need that condition so that the
loop doesn't iterate forever!

There's more, though.  The `cumsum` function is vectorized, so using
it, though seemingly wasteful, may actually be faster than the loop
