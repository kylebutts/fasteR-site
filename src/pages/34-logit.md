---
layout: "../layout/PostLayout.astro"
lesson: 34
toc_num: 35
---
 
## <a name="logit"> </a> Lesson 34: The Logistic Model

In our earlier examples of regression analysis, we were predicting a
continuous variable such as human weight.  But what if we wish to
predict a *dichotomous* varible, i.e. one recording which of two
outcomes occurs?

Consider the Pima dataset from earlier examples.  Say we are predicting
whether someone has -- or will later develop -- diabetes.  This is coded
in the **test** column of the dataset, 1 for having the disease, 0 for
not.

As a simple example, say we try to predict **test** from the variables
**bim** and **age**.  A linear model would be

mean test = &beta;<sub>0</sub> + &beta;<sub>1</sub> bmi + &beta;<sub>2</sub> age

Remember, **test** takes on the values 1 and 0.  What happens when we
take the average of a bunch of 1s and 0s?  The answer is that we get the
proportion of 1s.  For instance, the mean of the numbers 1,0,1,1 is 3/4,
which is exactly the proportion of 1s in that data.

In statististical terms, what the above equation is doing is expressing
the probability of a 1 -- i.e. the probability of having diabetes --
in terms of Body Mass Index and age.

Not a bad model, but one troubling point is that the right-hand side
could evaluate to a number less than 0 or greater than 1, which would be
impossible for a probability.  In order to deal with that problem, we
might use a *logistic* model, as follows.

Define the logistic function to be 

l(t) = 1 / (1 + e<sup>-t</sup>)

We then modify the above equation to

probability of diabetes = l(&beta;<sub>0</sub> + &beta;<sub>1</sub> bmi + &beta;<sub>2</sub> age)

As before, the statistical details are beyond the scope of this
R tutorial, but here is how you estimate the coefficients
&beta;<sub>i</sub> using R:

```r
> glout <- glm(test ~ bmi + age, data=pima, family=binomial)
> summary(glout)
...
Coefficients:
            Estimate Std. Error z value Pr(>|z|)    
(Intercept) -5.40378    0.51530 -10.487  < 2e-16 ***
bmi          0.09825    0.01248   7.874 3.45e-15 ***
age          0.04561    0.00694   6.571 4.98e-11 ***
...
```

Let's explore those estimated &beta;<sub>i</sub> a bit.  Consider 
women with about average BMI, say 32, and compare 30-year-olds to those
of age 40.  

```r
> l <- function(t) 1 / (1 + exp(-t))
> l(-5.40378 + 32*0.09825 + 30*0.04561)
[1] 0.2908045
> l(-5.40378 + 32*0.09825 + 40*0.04561)
[1] 0.3928424
```

So, the risk of diabetes increases substantial over that 10-year period,
but this population and BMI level.
