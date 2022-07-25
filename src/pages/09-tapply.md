---
layout: "../layout/PostLayout.astro"
setup: | 
  import YourTurn from "../components/YourTurn.astro"
  import Note from "../components/Note.astro"
  import Warning from "../components/Warning.astro"
  import Tip from "../components/Tip.astro"
lesson: 9
toc_num: 10
---
 
## <a name="tapply"> </a> Lesson 9:  The tapply Function

<Tip>

> **Tip:** Often in R there is a shorter, more
> compact way of doing things.  That's the case here; we can use the
> magical `tapply` function in the above example.  In fact, we can do it
> in just one line.

</Tip>

``` r
> tapply(tg$len,tg$supp,mean)
      OJ       VC 
20.66333 16.96333 
```

In English:  "Split the vector `tg$len` into two groups, according to
the value of `tg$supp`, then apply `mean` to each group."  Note that
the result was returned as a vector, which we could save by assigning it
to, say `z`:

``` r
> z <- tapply(tg$len,tg$supp,mean)
> z[1]
      OJ 
20.66333 
> z[2]
      VC 
16.96333 
```

By the way, `z` is not only a vector, but also a *named* vector,
meaning that its elements have names, in this case 'OJ' and 'VC'.

Saving can be quite handy, because we can use that result in subsequent
code.

To make sure it is clear how this works, let's look at a small
artificial example:

``` r
> x <- c(8,5,12,13)
> g <- c('M',"F",'M','M')
```

Suppose `x` is the ages of some kids, who are a boy, a girl, then two more
boys, as indicated in `g`.  For instance, the 5-year-old is a girl.

Let's call `tapply`:

``` r
> tapply(x,g,mean)
 F  M 
 5 11 
``` 

That call said, "Split `x` into two piles, according to the
corresponding elements of `g`, and then find the mean in each pile.

Note that it is no accident that `x` and `g` had the same number of
elements above, 4 each.  If on the contrary, `g` had 5 elements, that
fifth element would be useless -- the gender of a nonexistent fifth
child's age in `x`.  Similarly, it wouldn't be right if `g` had had
only 3 elements, apparently leaving the fourth child without a specified
gender.

<Tip>

> **Tip:**
> If `g` had been of the wrong length, we would have gotten an error,
> "Arguments must be of the same length."  This is a common error in R
> code, so watch out for it, keeping in mind WHY the lengths must be the
> same.

</Tip>

Instead of `mean`, we can use any function as that third argument in
**tapply**.  Here is another example, using the built-in dataset
**PlantGrowth**:

``` r
> tapply(PlantGrowth$weight,PlantGrowth$group,length)
ctrl trt1 trt2 
  10   10   10 
```

Here `tapply` split the `weight` vector into subsets according to
the `group` variable, then called the `length` function on each
subset.  We see that each subset had length 10, i.e. the experiment had
assigned 10 plants to the control, 10 to treatment 1 and 10 to treatment
2.

<YourTurn>

> **Your Turn:**  One of the most famous built-in R datasets is
> `mtcars`, which has various measurements on cars from the 60s and 70s.
> Lots of opportunties for you to cook up little experiments here!  You
> may wish to start by comparing the mean miles-per-gallon values for 4-,
> 6- and 8-cylinder cars.  Another suggestion would be to find how many
> cars there are in each cylinder category, using `tapply`.  As usual,
> the more examples you cook up here, the better!

</YourTurn>

By the way, the `mtcars` data frame has a "phantom" column.  

``` r
> head(mtcars)
                   mpg cyl disp  hp drat    wt  qsec vs am gear carb
Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```

That first column seems to give the make (brand) and model of the car.
Yes, it does -- but it's not a column.  Behold:

``` r
> head(mtcars[,1])
[1] 21.0 21.0 22.8 21.4 18.7 18.1
```

Sure enough, column 1 is the mpg data, not the car names.  But we see
the names there on the far left!  The resolution of this seeming
contradiction is that those car names are the *row names* of this data
frame:

``` r
> row.names(mtcars)
 [1] "Mazda RX4"           "Mazda RX4 Wag"       "Datsun 710"         
 [4] "Hornet 4 Drive"      "Hornet Sportabout"   "Valiant"            
 [7] "Duster 360"          "Merc 240D"           "Merc 230"           
[10] "Merc 280"            "Merc 280C"           "Merc 450SE"         
[13] "Merc 450SL"          "Merc 450SLC"         "Cadillac Fleetwood" 
[16] "Lincoln Continental" "Chrysler Imperial"   "Fiat 128"           
[19] "Honda Civic"         "Toyota Corolla"      "Toyota Corona"      
[22] "Dodge Challenger"    "AMC Javelin"         "Camaro Z28"         
[25] "Pontiac Firebird"    "Fiat X1-9"           "Porsche 914-2"      
[28] "Lotus Europa"        "Ford Pantera L"      "Ferrari Dino"       
[31] "Maserati Bora"       "Volvo 142E"         
```

So `'Mazda RX4'` was the `name` of row 1, but not part of the row.

As with everything else, `row.names` is a function, and as you can see
above, its return value here is a 32-element vector (the data frame had
32 rows, thus 32 row names).  The elements of that vector are of class
**'character'**, as is the vector itself.

You can even assign to that vector:

``` r
> row.names(mtcars)[7]
[1] "Duster 360"
> row.names(mtcars)[7] <- 'Dustpan'
> row.names(mtcars)[7]
[1] "Dustpan"
```

Inside joke, by the way.  Yes, the example is real and significant, but
the "Dustpan" thing came from a funny TV commercial at the time.

(If you have some background in programming, it may appear odd to you to
have a function call on the *left* side of an assignment.  This is
actually common in R.  It stems from the fact that `<-` is actually a
function!  But this is not the place to go into that.)

<YourTurn>

> **Your Turn:**  Try some experiments with the `mtcars` data, e.g.
> finding the mean horsepower for 6-cylinder cars.

</YourTurn>

<Tip>

> **Tip:**
> As a beginner (and for that matter later on), you should NOT be obsessed
> with always writing code in the "optimal" way, including in terms of
> compactness of the code.  It's much more important
> to write something that works and is clear; one can always tweak it
> later.  In this case, though, `tapply` actually aids clarity, and it
> is so ubiquitously useful that we have introduced it early in this
> tutorial.  We'll be using it more in later lessons.

</Tip>
