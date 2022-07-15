---
layout: "../layout/PostLayout.astro"
lesson: 18
toc_num: 19
---
 
## <a name="ftnbl"> </a> Lesson 18:  Functions with Blocks 

Blocks are usually key in defining functions.  Let's generalize the
above code in the Loops lesson, writing a function that replaces `0`s by
`NA`s in specified columns in general data frames, not just `pima` as
before.

``` r
     1	zerosToNAs <- function(d,cols)
     2	{
     3	   for (j in cols) {
     4	      NArows <- which(d[,j] == 0)
     5	      d[NArows,j] <- NA
     6	   }
     7	   d
     8	}
```

(We've added line numbers to this display for convenence.)

Here the formal argument `d` is the data frame to be worked on, and
**cols** specifies the columns in which 0s are to be replaced.

The loop goes through `d`, one column at a time.  Since `d[,j] == 0`
means all of column `j` of `d`, then `which(d[,j] == 0)` will give
us the indices in that column of elements that are 0s.  Those indices in
turn mean row numbers in `d`, which we've named `NArows`.  In line
5, then, we replace the 0s we've found in column `j` by NAs.  Before
continuing, work through this little example in your mind:

``` r
> d <- data.frame(x=c(1,0,3),y=c(0,0,13)) 
> d
  x  y
1 1  0
2 0  0
> which(d[,2] == 0)
[1] 1 2  # ah yes; the 0 elements in column 2 are at indices 1 and 2
```

Returning the the above loop code, note that when we reach line 7, we've
already finished the loop, and exited from it.  So, we are ready to
return the new value of `d`.  Recall that we could do this via the
expression `return(d)`, but we can save ourselves some typing by
simply writing `d`.  That value becomes the last value computed, and R
automatically returns that last value.

We could use this in the Pima data:

``` r
> pima <- zerosToNAs(pima,2:6)
```

There is an important subtlety here.  All of this will produce a new
data frame, rather than changing `pima` itself.  That does look odd;
isn't `d` changing, and isn't `d` the same as `pima`?  Well, no;
`d` is only a *separate copy* of `pima`. So, when `d` changes,
`pima` does not.  So, if we want `pima` to change, we must reassign
the output of the function back to `pima`, as we did above.

> **Your Turn**: Write a function with call form `countNAs(dfr)`,
> which prints the numbers of NAs in each column of the data frame
> `dfr`.  You'll need to use the built-in `is.na()` functon; execute
> `is.na(c(5,NA,13,28,NA))` at the R command prompt to see what it
> does.  Test it on a small artificial dataset that you create.
