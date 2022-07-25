---
layout: "../layout/PostLayout.astro"
setup: | 
  import YourTurn from "../components/YourTurn.astro"
  import Note from "../components/Note.astro"
  import Warning from "../components/Warning.astro"
  import Tip from "../components/Tip.astro"
lesson: 10
toc_num: 11
---
 
## <a name="less5"> </a> Lesson 10:  Data Cleaning

Most real-world data is "dirty," i.e. filled with errors.  The famous
[New York taxi trip
dataset](https://data.cityofnewyork.us/Transportation/2017-Yellow-Taxi-Trip-Data/biws-g3hs),
for instance, has one trip destination whose lattitude and longitude
place it in Antartica! The impact of such erroneous data on one's statistical
analysis can be anywhere from mild to disabling.  Let's see below how one
might ferret out bad data.  And along the way, we'll cover several new R
concepts.

We'll use the famous Pima Diabetes dataset.  Various versions exist, but
we'll use the one included in `faraway`, an R package compiled
by Julian Faraway, author of several popular books on statistical
regression analysis in R.

I've placed the data file, `Pima.csv`, on
[my Web site](http://heather.cs.ucdavis.edu/FasteR/data/Pima.csv). Here
is how you can read it into R:

``` r
> pima <- read.csv('http://heather.cs.ucdavis.edu/FasteR/data/Pima.csv',header=TRUE)
```

The dataset is in a CSV ("comma-separated values") file.  Here we read
it, and assigned the resulting data frame to a variable we chose to name
**pima**.

Note that second argument, `header=TRUE`.  A header in a file, if one
exists, is in the first line in the file.  It states what names the
columns in the data frame are to have.  If the file doesn't have one,
set `header` to FALSE.  You can always add names to your data frame
later (future lesson).

> <span style="color: #b4637a;">Tip:</span>
> It's always good to take a quick look at a new data frame:

``` r
> head(pima)
  pregnant glucose diastolic triceps insulin  bmi diabetes age test
1        6     148        72      35       0 33.6    0.627  50    1
2        1      85        66      29       0 26.6    0.351  31    0
3        8     183        64       0       0 23.3    0.672  32    1
4        1      89        66      23      94 28.1    0.167  21    0
5        0     137        40      35     168 43.1    2.288  33    1
6        5     116        74       0       0 25.6    0.201  30    0
> dim(pima)
[1] 768   9
```

The `dim` function tells us that there are
768 people in the study, 9 variables measured on each.

Since this is a study of diabetes, let's take a look at the glucose
variable.  R's `table` function is quite handy.

``` r
> table(pima$glucose)

  0  44  56  57  61  62  65  67  68  71  72  73  74  75  76  77  78  79  80  81 
  5   1   1   2   1   1   1   1   3   4   1   3   4   2   2   2   4   3   6   6 
 82  83  84  85  86  87  88  89  90  91  92  93  94  95  96  97  98  99 100 101 
  3   6  10   7   3   7   9   6  11   9   9   7   7  13   8   9   3  17  17   9 
102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 
 13   9   6  13  14  11  13  12   6  14  13   5  11  10   7  11   6  11  11   6 
122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 
 12   9  11  14   9   5  11  14   7   5   5   5   6   4   8   8   5   8   5   5 
142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 
  5   6   7   5   9   7   4   1   3   6   4   2   6   5   3   2   8   2   1   3 
162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 
  6   3   3   4   3   3   4   1   2   3   1   6   2   2   2   1   1   5   5   5 
182 183 184 186 187 188 189 190 191 193 194 195 196 197 198 199 
  1   3   3   1   4   2   4   1   1   2   3   2   3   4   1   1 
```

Be careful here; the first, third, fifth and so on lines are the glucose
values, while the second, fourth, sixth and so on lines are the counts
of women having those values.  For instance, 3 women had the glucose =
68.

Uh, oh!  5 women in the study had glucose level 0.  And 1 had level 44,
etc.  Presumably 0 is not physiologically possible, and maybe not 44
either.

Let's consider a version of the glucose data that at least excludes these 0s.

``` r
> pg <- pima$glucose
> pg1 <- pg[pg > 0]
> length(pg1)
[1] 763
```

As before, the expression `pg > 0` creates a vector of TRUEs and FALSEs.
The filtering `pg[pg > 0]` will only pick up the TRUE cases, and sure
enough, we see that `pg1` has only 763 cases, as opposed to the
original 768.

Did removing the 0s make much difference?  Turns out it doesn't:

``` r
> mean(pg)
[1] 120.8945
> mean(pg1)
[1] 121.6868
```

But still, these things can in fact have  major impact in many
statistical analyses.

R has a special code for missing values, NA, for situations like this.
Rather than removing the 0s, it's better to recode them as NAs.  Let's
do this, back in the original dataset so we keep all the data in
one object:

``` r
> pima$glucose[pima$glucose == 0] <- NA
```

> <span style="color: #b4637a;">Tip:</span>
> That's pretty complicated.  It's clearer to **break things up
> into smaller steps** (I recommend this especially for
> beginners), as follows:

``` r
> glc <- pima$glucose
> z <- glc == 0
> glc[z] <- NA
> pima$glucose <- glc
```

Here is what the code does:

- That first line just makes a copy of the original vector, to avoid
clutter in the code.  
- The second line determines which elements of `glc`
are 0s, resulting in `z` being a vector of TRUEs and FALSEs.  
- The third line then assigns NA to those elements in `glc` corresponding to
the TRUEs. (Note the recycling of `NA`.)
- Finally, we need to have the changes in the original data, so we copy
  `glc` to it.

> <span style="color: #b4637a;">Tip:</span>
> Note again the double-equal sign!  If we wish to test whether, say, `a` and
> `b` are equal, the expression must be `a == b`, not `a = b`; the
> latter would do `a <- b`.  This is a famous beginning programmer's
> error.

As a check, let's verify that we now have 5 NAs in the glucose variable:

``` r
> sum(is.na(pima$glucose))
[1] 5
```

Here the built-in R function `is.na` will return a vector of TRUEs and
FALSEs.  Recall that those values can always be treated as 1s and 0s,
thus summable.  Thus we got our count, 5.

Let's also check that the mean comes out right:

``` r
> mean(pima$glucose)
[1] NA
```

What went wrong?  By default, the `mean` function will *not* skip over
NA values; thus the mean was reported as NA too.  But we can instruct
the function to skip the NAs:

``` r
> mean(pima$glucose,na.rm=TRUE)
[1] 121.6868
```

<YourTurn>

> **Your Turn:**  Determine which other columns in `pima` have
> suspicious 0s, and replace them with NA values.  
> 
> Now, look again at the plot we made earlier of the Nile flow histogram.
> There seems to be a gap between the numbers at the low end and the rest.
> What years did these correspond to?  Find the mean of the data,
> excluding these cases.

</YourTurn>
