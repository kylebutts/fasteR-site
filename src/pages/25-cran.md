---
layout: "../layout/PostLayout.astro"
lesson: 25
toc_num: 26
---
 
## <a name="cran"> </a> Lesson 25:  R Packages, CRAN, Etc.

One of the great things about R is that are tens of thousands of
packages that were developed by users and then contributed to
the [CRAN repository](https://cran.r-project.org).  As of December 2020,
there were nearly 17,000 packages there.  If you need to do some special
operation in R, say spatial data analysis, it may well be in there. 
You might take the [CRAN Task Views](https://cran.r-project.org/web/views/) 
as your starting point, or simply use Google, e.g. plugging in the search 
term "CRAN spatial data." 
Other good sources of public R packages are
[Bioconductor](https://www.bioconductor.org/) and useRs' personal GitHub
pages.  

Below, we'll introduce one of the most popular user-contributed
packages, `ggplot2`.  But first, how does one install and load
packages?

First, one needs a place to put the packages.  UseRs often designate a
special folder/directory for their packages (both those they download
and ones they write themselves).  I use `R` in my home directory for
that purpose, but if you don't specify a folder, your package installer
will choose one for you.  It won't matter as long as you are consistent.
I'll assume you don't specify a package folder.

To install, say, `ggplot2`, you can type at the R prompt,

``` r
> install.packages('ggplot2')
```

Or in RStudio, choose Tools | Install Packages...

When you want to use one of your installed packages, you need to tell R
to load it, e.g. by typing at the R prompt,

``` r
> library(ggplot2)
```

In RStudio, click the Packages button and select the one you want; there
may be a delay while R makes a list of all your packages.

Later, you'll write your own R packages.  We won't cover that here, but
there are many good tutorials for this on the Web.
