---
layout: "../layout/PostLayout.astro"
setup: | 
  import YourTurn from "../components/YourTurn.astro"
  import Note from "../components/Note.astro"
  import Warning from "../components/Warning.astro"
  import Tip from "../components/Tip.astro"
lesson: 3
toc_num: 4
---
 
## <a name="vecidxs"> </a> Lesson 3:  Vectors and Indices

Say we want to find the mean river flow after year 1950.  

The above output said that the `Nile` series starts in 1871.  That
means 1951 will be the 81st year, and the 100th will be 1970.  How do we
designate the 81st through 100th elements in this data?

Individual elements can be accessed using *subscripts* or *indices*
(singular is *index*), which are specified using brackets, e.g. 

``` r
> Nile[2]
[1] 1160
```

for the second element (the output we saw earlier shows that the second
element is indeed 1160).  The value 2 here is the index.

The `c` ("concatenate") function builds a vector, stringing several
numbers together.  E.g. we can get the 2nd, 5th and 6th elements of
**Nile**:

``` r
> Nile[c(2,5,6)]
[1] 1160 1160 1160
```

If we wish to build a vector of *consecutive* numbers, we can use the
"colon" notation:

``` r
> Nile[c(2,3,4)]
[1] 1160  963 1210
> Nile[2:4]
[1] 1160  963 1210
```

As you can see, 2:4 is shorter way to specify the vector c(2,3,4).


So, 81:100 means all the numbers from 81 to 100.  Thus
**Nile[81:100]** specifies the 81st through 100th elements in the `Nile`
vector.

Then to answer the above question on the mean flow during 1951-1971, we
can do

``` r
> mean(Nile[81:100])
[1] 877.05
```

> **NOTE:** Observe how the above reasoning process worked.  We had a
> goal, to find the mean river flow after 1950.  We knew we had some tools
> available to us, namely the `mean` function and R vector indices.  We
> then had to figure out a way to combine these tools in a manner that
> achieves our goal, which we did.  
> 
> This is how use of R works in general.  As you go through this tutorial,
> you'll add more and more to your R "toolbox."  Then for any given goal,
> you'll rummage around in that toolbox, and eventually figure out the
> right set of tools for the goal at hand.  Sometimes this will require
> some patience, but you'll find that the more you do, the more adept you
> become.

If we plan to do more with that time period, we should make a copy of
it:

``` r
> n81100 <- Nile[81:100]
> mean(n81100)
[1] 877.05
> sd(n81100)
[1] 125.5583
```

The function `sd` finds the standard deviation.  

Note that we used R's *assignment operator* here to copy ("assign")
those particular  `Nile` elements to `n81100`.  (In most situations,
you can use `=` instead of `<-`, but why worry about what the exceptions
might be?  They are arcane, so it's easier just to always use `<-`.
And though "keyboard shortcuts" for this are possible, again let's just
stick to the basics for now.)

Note too that though we will speak of the above operation as having
"extracted" the 81st through 100th elements of `Nile`, we have merely
made a copy of those elements.  The original vector `Nile` remains
intact.

> <span style="color: #b4637a;">Tip:</span>
> We can pretty much choose any name we want; `n81100` just was chosen
> to easily remember this new vector's provenance.  (But names can't
> include spaces, and must start with a letter.)

Note that `n81100` now is a 21-element vector.  Its first element is
now element 81 of `Nile`:

``` r
> n81100[1]
[1] 744
> Nile[81]
[1] 744
```

Keep in mind that although `Nile` and `n81100` now have identical
contents, they are *separate* vectors; if one changes, the other will
not.

<YourTurn>

> **Your Turn:** Devise and try variants of the above, say finding the
> mean over the years 1945-1960.

</YourTurn>

Another oft-used function is `length`, which gives the number of
elements in the vector, e.g.

``` r
> length(Nile)
[1] 100
```

Can you guess the value of `length(n81100)`?  Type this expression in
at the `>` prompt to check your answer.

Leave R by typing `q()` or ctrl-d.  (Answer no to saving the workspace.)

### Recap: What have we learned in these first two lessons?

* Starting and existing R.

* Some R functions:  `mean`, `hist`, `length`.

* R vectors, and vector indices.

* Extracting vector subsets.

* Forming vectors, using `c()` and `:`.

Not bad for Lesson 1!  And needless to say, you'll be using all of these
frequently in the subsequent lessons and in your own usage of R.
