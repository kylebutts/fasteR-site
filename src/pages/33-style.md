---
layout: "../layout/PostLayout.astro"
setup: | 
  import YourTurn from "../components/YourTurn.astro"
  import Note from "../components/Note.astro"
  import Warning from "../components/Warning.astro"
  import Tip from "../components/Tip.astro"
lesson: 33
toc_num: 34
---
 
## <a name="style"> </a> Lesson 33:  Tips on R Coding Style and Strategy

Programming is a creative activity, and thus different programmers will
have different coding styles.  Some people feel so strongly that they
will publish there own particular style guides, such as 
[this one](https://google.github.io/styleguide/Rguide.xml) 
by the R community at Google.  Mine is
[here`](https://github.com/matloff/R-Style-Guide).

Needless to say, style is a matter of personal taste.  But:

**Style IS important for any code you intend to use again, for two reasons:**

1. You will quickly forget how your code works.

2.  If you share your code with others, you need to make its workings
    clear to them.

**Equally important is strategy, the way you approach a coding project.**

There is no magic formula on how to write code.  As noted earlier, I
cannot *teach* yow how to code.  I can only show you how the
ingredients work -- loops, variables, functions, if/else etc. -- and you
must creatively put them together into code that achieves goals.  It's
like solving a big puzzle, and like many big puzzles, you may need to
ponder the problem for quite a while, gaining insights here and there
until it's finally done.  Yet, as with coding style, there are strategies
that we all agree on.

So in spite of great individual variation, there are common aspects that
everyone agrees with, which we'll discuss in this lesson.

**Comment your code:**

In any programming course for Computer Science students, this
is absolutely central.  If a student turns in a programming assignment
with few or no comments, it will get a failing grade.  If comments are
needed for clarity and readability for CS students, who are presumably
strong programmers, then R users who are not expert programmers need
comments even more.

A [style
guide](https://www.cs.utah.edu/~germain/PPS/Topics/commenting.html)
at a top university computer science department puts it well:

> Commenting involves placing Human Readable Descriptions inside of
> computer programs detailing what the Code is doing. Proper use of
> commenting can make code maintenance much easier, as well as helping
> make finding bugs faster. Further, commenting is very important when
> writing functions that other people will use. Remember, well
> documented code is as important as correctly working code.

(Also see specific tips on commenting, later in that document.)

*Don't be under the illusion that your code is self-documenting; it
  isn't!  A typical comment might look like this:*

``` r
w <- f(w)
# at this point, the data frame w will consist of the original rows for
# people over age 65 and who are homeowners
```

*At the top of each source file, insert comments giving the reader an
overview of the contents.*

This will typically an overview of the roles of each major function, how
the functions interact with each other, what the main data structures
are, and so on.

I strongly recommend that you write these comments at the top of a file
BEFORE you start coding (and of course modifying it as you do write
code).  This will really help you focus during the coding process.

**Indent your code:**

``` r
if (x < y) {
   x <- y^2
   z <- x + y
}
```

is much easier to read than

``` r
if (x < y) {
x <- y^2
z <- x + y
}
```

**Write your code in top-down fashion:**

If you have a function `f` that is more than, say, a dozen lines long,
break its code into calls to smaller functions, say `g` and `h`.
Then `f` will consist of those calls, plus some "glue" lines to deal
with the return values and so on.  Of course, it's a matter of taste as
to break things up that way, but the point is that it makes your code
both easier to *read* (by others, or by yourself later), and even more
important, easier to *write*.  Breaking up the code like this makes it
read like an outline.

**Don't skimp on attending to the "corner cases":**

Computer Science people talk about "corner cases," meaning special
situations in which code may fail in spite of being generally sound.

For instance, consider this code:

``` r
> i <- 5
> 1:i
[1] 1 2 3 4 5
```

But what about the special case in which `i = 0`?

``` r
> i <- 0
> 1:i
[1] 1 0
```

This may not be what you wanted.  You probably should insert a check,
say

``` r
if (i >= 1) i:5
```

and maybe also code to handle the erroneous case.  This will depend on
the situation, but the main point is to be aware of possible corner
cases.

**Use a debugging tool:**

More on this in a later lesson!
