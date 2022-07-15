---
layout: "../layout/PostLayout.astro"
lesson: 29
toc_num: 30
---
 
## <a name="txt"> </a> Lesson 29:  Simple Text Processing, I

These days, text processing is big in the Data Science field, e.g. in
Natural Language Processing applications.  In this lesson, we'll do a
simple yet practical example, in order to illustrate some key functions
in base-R.  (R has many packages for advanced text work, such as **tm**.)

Our example will cover reading in a file of text, and compiling a word
count, i.e. calculating the number of times each word appears.  This
kind of task is at the core of many text classification algorithms.

The file is
[here](https://raw.githubusercontent.com/matloff/fasteR/master/data/aboutR.txt).
It's basically the About section of the [R Project home
page](https://www.r-project.org/).  Here are the first few lines:

```

What is R?

Introduction to R

   R is a language and environment for statistical computing and graphics.
```

Now, how can we read the file?  For instance, **read.table** won't work,
as it expects the same number of nonblank fields on each line.  As you
can see above, our file has a variable number of such fields per line.

Instead, we read the lines of the file via a function named, not
surprisingly, **readLines**:

```r
> abt <- readLines('https://raw.githubusercontent.com/matloff/fasteR/master/data/aboutR.txt')
```

So, what exactly is in **abt** now?  Let's turn to our usual inspection
tools, **str** and **head**.

```r
> str(abt)
 chr [1:70] "" "What is R?" "" "Introduction to R" "" ...
```

So, **abt** is a vector of 70 elements, of type character.  Each element
of this vector is one line from the file:

```
> head(abt)
[1] ""                                                                          
[2] "What is R?"                                                                
[3] ""                                                                          
[4] "Introduction to R"                                                         
[5] ""                                                                          
[6] "   R is a language and environment for statistical computing and graphics."
```

The first line in the file was empty, so **abt[1]** is "", and so on.

Now, to count the number of words in the file, we'll need a way to count
the number in each line, which we will then sum.  R's **strsplit**
function will serve us well here, e.g. for line 4:

```r
> y <- strsplit(abt[4],' ')
> y
[[1]]
[1] "Introduction" "to"           "R"   
```

(That second argument, ' ', means we want the blank character to be our
splitting delimiter.

Good, it split the line into the three words on that line,
"Introduction", "to", and "R".  

But be careful!  What is that [[1]] doing there?  Remember, the double
bracket notation is for R lists.  So, **strsplit** has split **abt[4]**
a list with one element, and that element is in turn the three-element
character vector **c("Introduction","to","R")**.  So for instance,

```r
> y[[1]][2]
[1] "to"
> y[[1]][3]
[1] "R"
```

Why the R list form?  Well, **strsplit** can be applied to the entire
character vector **abt**, yielding a list of 70 elements; the i-th such
element will contain the split form of the i-th line in the file, e.g.
line 6:

```r
> w <- strsplit(abt,' ')
> w[[6]]  # example
 [1] ""            ""            ""            "R"           "is"         
 [6] "a"           "language"    "and"         "environment" "for"        
[11] "statistical" "computing"   "and"         "graphics."  
```

Yep, that's the split form of line 6.

The material beginning with the # sign is what is called a *comment* in
the programming world.  It does not get executed by R, but it is a memo
to us, the programmer, a note to help us remember what we did.  

Comments are extremely important.  When we read our code six months from
now, we will have forgotten most of it, so comments help us reorient.
The same holds if someone else reads our code.  Comments -- *meaningful*
comments -- are key to good coding.  More on this in a future lesson.

But we also see another snag.  The above output tells us that R took
line 6, which has 11 words, and split into 14 words -- the first 3 of
which are empty words "".  This is because the first three characters in
line 6 are blanks.  When there is more than one consecutive blank, 
the **strsplit** function treats the excess blanks as
"words."  (This comes as quite a surprise to Python programmers.)

So, how to fix it?  Answering that question will give us a chance to
learn more about R in general.

For that particular line, we could do, say, is remove those empty
"words" as follows:

```r
> z <- w[[6]]
> z <- z[z != ""]
> z
 [1] "R"           "is"          "a"           "language"    "and"        
 [6] "environment" "for"         "statistical" "computing"   "and"        
[11] "graphics."  
```

R's '!=' means "not equal to."  By the way, '!' means "not" in R, e.g.

```r
> 3 < 8
[1] TRUE
> !(3 < 8)
[1] FALSE
```

So what we did to **z** above followed our usual pattern: 

1.  The expression **z != ""** yields a bunch of TRUEs and FALSEs.

2.  The operation **z[bunch of TRUEs and FALSEs]** extracts those
    elements of **z** at which there are TRUEs, which are exactly the
ones we want to keep here.

* <span style="color: #b4637a;">Tip:</span> 
When you write some code that looks like it will be generally useful,
make a function out of it, and save it for future use.  The above code
to delete the empty "words" sounds like something worth keeping.  So,
let's write it in function form:

```r
extractNonemptyWords <- function(s) 
{
   z <- strsplit(s,' ')[[1]]
   z[z != ""]
}
```

Recall that in R functions, the last computed value is automatically
returned.  The expression **z[z != ""]** evaluates to the set of
nonempty words, and it is returned.

<span style="color: #b4637a;">Tip:</span> 
As mentioned, we should probably save that function for future use.
We could save it using the **save** function as discussed earlier, but it
would be better to save our "home grown" functions in one or more
packages, maybe even submitting them to CRAN.  More on this in a later
lesson.

We'll continue with this example in the next lesson, but first, time for
a **Your Turn** session.

> **Your Turn:** That [[1]] expression in the body of
> **extractNonemptyWords** was crucial!  Try the code without it, and
> see if you can explain the result, which is not what we desire.
> <span style="color: #b4637a;">Tip:</span>  This illustrates a common error
> for beginners and veterans alike.  The error message probably won't be
> helpful!  So keep this frequent error in mind, both when you're
> writing code and viewing cryptic error messages.

We can then call our **extractNonemptyWords** function on each line of
the file, say in a loop.  We'll do this in the next section.

> **Your Turn:** Write a function with call form **delNAs(x)**, that
> returns **x** with NAs deleted.  
