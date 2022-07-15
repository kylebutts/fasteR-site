---
layout: "../layout/PostLayout.astro"
lesson: 7
toc_num: 8
---
 
## <a name="extractdf"> </a> Lesson 7:  Extracting Rows/Columns from Data Frames

(The reader should cover this lesson especially slowly and carefully.
The concepts are simple, but putting them together requires careful
inspection.)

First, let's review what we saw in a previous lesson:

```r
> which1200 <- which(Nile > 1200)
> Nile[which1200]
[1] 1210 1230 1370 1210 1250 1260 1220
```

There, we saw how to extract *vector elements*.  We can do something
similar to extract *data frame rows or columns*.  Here is how:

Continuing the Vitamin C example, let's compare mean tooth length for
the two types of supplements.  Here is the code:

```r
> whichOJ <- which(tg$supp == 'OJ')
> whichVC <- which(tg$supp == 'VC')
> mean(tg[whichOJ,1])
[1] 20.66333
> mean(tg[whichVC,1])
[1] 16.96333
```

In the first two lines above, we found which rows in **tg** (or
equivalently, which elements in **tg$supp**) had the OJ supplement, and
recorded those row numbers in **whichOJ**.  Then we did the same for VC.

Now, look at the expression **tg[whichOJ,1]**.  Remember, data frames
are accessed with two subscript expressions, one for rows, one for
colums, in the format

```r
d[the rows we want, the columns we want]
```

So, **tg[whichOJ,1]** says to restrict attention to the OJ rows, and
only column 1, tooth length.  We then find the mean of those restricted
numberss.  This turned out to be 20.66333.  Then do the same for VC.

Again, if we are pretty experienced, we can skip steps:

```r
> tgoj <- tg[tg$supp == 'OJ',]
> tgvc <- tg[tg$supp == 'VC',]
> mean(tgoj$len)
[1] 20.66333
> mean(tgvc$len)
[1] 16.96333
```

Either way, we have the answer to our original question:  Orange juice appeared
to produce more growth than Vitamin C.  (Of course, one might form a
confidence interval for the difference etc.)

### Recap: What have we learned in this lesson?

Just as we learned earlier how to use a sequence of TRUE and FALSE
values to extract a parts of a vector, we now see how to do the
analogous thing for data frames:  **We can use a sequence of TRUE and FALSE
values to extract a certain rows or columns from a data frame.**

It is imperative that the reader fully understand this lesson before
continuing, trying some variations of the above example on his/her own.
We'll be using this technique often in this tutorial, and it is central
to R usage in the real world.

> **Your turn:**  Try some of these operations on R's built-in
> **faithful** dataset.  For instance, find the number of eruptions for
> which the waiting time was more than 80 minutes.
