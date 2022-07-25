---
layout: "../layout/PostLayout.astro"
setup: | 
  import YourTurn from "../components/YourTurn.astro"
  import Note from "../components/Note.astro"
  import Warning from "../components/Warning.astro"
  import Tip from "../components/Tip.astro"
lesson: 19
toc_num: 20
---
 
## <a name="edt"> </a> Lesson 19:  Text Editing and IDEs

In trying out our function `zeroToNAs` above, you probably used your
computer's mouse to copy-and-paste from this tutorial into your machine.
Your screen would then look like this:

```
> zerosToNAs <- function(d,cols) 
+ {
+    zeroIndices <- which(d[,cols] == 0)
+    d[zeroIndices,cols] <- NA
+    d
+ }
```

But this is unwieldy.  Typing it in line by line is laborious and
error-prone.  And what if we were to change the code?  Must we type in
the whole thing again?  We really need a *text editor* for this.  Just
as we edit, say, reports, we do the same for code.  

Here are your choices:

1. If you are already using an IDE, say RStudio, you simply edit
in the designated pane.

2.  If you are using an external editor, say vim or emacs,
just open a new file and use that workspace.

3.  For  those not using these, we'll just use R's built-in `edit`
    function.  

Option 3 is fine for now, but eventually you'll want to use either
Option 1 or 2.  You may wish to start with one of those options now,
before going further. 

We have details on getting start with RStudio in the <a
href="#ide">Appendix</a> at the end of this document.  

<Warning>

> **Warning:** 
> As noted earlier, one major R Users Group described RStudio as
> "overwhelming." But it is quite easy if you resist the temptation (or
> the exhortations of others) to learn it all at once.  As long as you
> stick to the basics in the Appendix, you'll find it quite easy; you can
> learn the advanced tricks later.

</Warning>

Consider the following toy example:

``` r
f <- function(x,y)
{
   s <- x + y
   d <- x - y
   c(s,d)
}
```

It finds the sum and difference of the inputs, and returns them as a
two-element vector.

If you are using RStudio or an external editor, copy-and-paste the above
code into the workspace of an empty file.  

Or, to create `f` using `edit`, we would do the following:

``` r
> f <- edit()
```

This would invoke the text editor, which will depend on your machine.
It will open your text editor right there in your R window.  Type the
function code, then save it, using the editor's Save command.  

**IMPORTANT:** Even if you are not using `edit`, it's important to
know what is happening in that command above.

a.  `edit` itself is a function.  Its return value is the code you
typed in!  

b.  That code is then assigned to `f`, which you can now call

If you want to change the function, in the RStudio/external editor case,
just edit it there.  In the `edit` case, type

``` r
> f <- edit(f)
```

This again opens the text editor, but this time with the current `f`
code showing.  You edit the code as desired, then as before, the result
is reassigned to `f`.

How do you then run the code, say for computing `f(5,2)`?

* If you had created `f()` using `edit()`, then execute as usual:


``` r
> f(5,2)
```

* If you had used an external text editor, say saving the code into the
  file `a.R`, then

``` r
> source('a.R')
``` 

loads file, and then you run as above.

* In RStudio, click on Source, then run as above.
