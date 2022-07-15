---
layout: "../layout/PostLayout.astro"
lesson: 6
toc_num: 7
---
 
## <a name="less4"> </a> Lesson 6:  R Factor Class

Each object in R has a *class*. The number 3 is of the **'numeric'**
class, the character string 'abc' is of the **'character'** class, and
so on.  (In R, class names are quoted; one can use single or double
quotation marks.) Note that vectors of numbers are of  **'numeric'**
class too; actually, a single number is considered to be a vector of
length 1.  So, **c('abc','xw')**, for instance, is  **'character'**
as well.

> <span style="color: #b4637a;">Tip:</span>
> Computers require one to be very, very careful and very, very precise.
> In that expression **c('abc','xw')** above, one might wonder why it does
> not evaluate to 'abcxw'.  After all, didn't I say that the 'c' stands
> for "concatenate"?  Yes, but the **c** function concatenates *vectors*.
> Here 'abc' is a vector of length 1 -- we have *one* character string,
> and the fact that it consists of 3 characters is irrelevant -- and
> likewise 'xw' is one character string.  So, we are concatenating a
> 1-element vector with another 1-element vector, resulting in a 2-element
> vector.

What about **tg** and **tg$supp** in the Vitamin C example above?  What
are their classes?

```r
> class(tg)
[1] "data.frame"
> class(tg$supp)
[1] "factor"
```

R factors are used when we have *categorical* variables.  If in a
genetics study, say, we have a variable for hair color, that might
comprise four categories:  black, brown, red, blond.  We can find the
list of categories for **tg$supp** as follows:

```r
> levels(tg$supp)
[1] "OJ" "VC"
```

The categorical variable here is **supp**, the name the creator of this 
dataset chose for the supplement column.  We see that there are two categories
(*levels*), either orange juice or Vitamin C.

Note carefully that the values of an R factor must be quoted. Either
single or double quote marks is fine (though the marks don't show
up when we use **head**).

Factors can sometimes be a bit tricky to work with, but the above is
enough for now.  Let's see how to apply the notion in the current
dataset.
