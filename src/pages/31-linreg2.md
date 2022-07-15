---
layout: "../layout/PostLayout.astro"
lesson: 31
toc_num: 32
---
 
## <a name="linreg2"> </a> Lesson 31:  Linear Regression Analysis, II

Continuing our look at linear regression analysis using R, let's look at
the famous [bike sharing
data](ttps://archive.ics.uci.edu/ml/datasets/bike+sharing+dataset).
(See the latter site for the documentation; e.g. temperature has been
scaled, rather than measured in degrees.)
It's in a **.zip** file, so it will need a little extra preprocessing:

```r
# fetch from Web, and store the downloaded data to the file 'bike.sip'
> download.file('https://archive.ics.uci.edu/ml/machine-learning-databases/00275/Bike-Sharing-Dataset.zip','bike.zip')
> unzip('bike.zip')  # out come the files 'day.csv' and 'hour.csv'
> day <- read.csv('day.csv',header=TRUE)
> head(day)  # always take a look around!
  instant     dteday season yr mnth holiday weekday workingday weathersit
1       1 2011-01-01      1  0    1       0       6          0          2
2       2 2011-01-02      1  0    1       0       0          0          2
3       3 2011-01-03      1  0    1       0       1          1          1
4       4 2011-01-04      1  0    1       0       2          1          1
5       5 2011-01-05      1  0    1       0       3          1          1
6       6 2011-01-06      1  0    1       0       4          1          1
      temp    atemp      hum windspeed casual registered  cnt
1 0.344167 0.363625 0.805833 0.1604460    331        654  985
2 0.363478 0.353739 0.696087 0.2485390    131        670  801
3 0.196364 0.189405 0.437273 0.2483090    120       1229 1349
4 0.200000 0.212122 0.590435 0.1602960    108       1454 1562
5 0.226957 0.229270 0.436957 0.1869000     82       1518 1600
6 0.204348 0.233209 0.518261 0.0895652     88       1518 1606
```

By the way, the weather variables have been rescaled to the interval
[0,1].  A value of 0.28, for instance, means 28% of the way from the
minimum to the maximum value of this variable.

One new concept here is the presence of *indicator* variables, more
informally known as *dummy variables*.  These are variables taking only
the values 0 and 1, with a 1 "indicating" that some trait is present.
For instance, the **holiday** variable is either 1 or 0, depending on
whether that day was a holiday (which might affect the demand for bikes
that day).

Those who manage this bike sharing service may wish to predict future
demand for bikes, say the next day, to aid in their planning.  As an
example, let's try to predict the number of casual riders from some
weather variables and the dummy variable **workingday**.

```r
> day1 <- day[,c(8,10,12:14)]
> head(day1)
  workingday     temp      hum windspeed casual
1          0 0.344167 0.805833 0.1604460    331
2          0 0.363478 0.696087 0.2485390    131
3          1 0.196364 0.437273 0.2483090    120
4          1 0.200000 0.590435 0.1602960    108
5          1 0.226957 0.436957 0.1869000     82
6          1 0.204348 0.518261 0.0895652     88
> lmout <- lm(casual ~ .,data=day1)
> lmout
...
Coefficients:
(Intercept)   workingday         temp          hum    windspeed  
     1063.6       -806.6       2149.5       -812.7      -1145.3  
 
```

The expression "casual ~ ." means, "regress **casual** against all the
other variables in this dataset.

These numbers make sense.  The negative coefficient for **workingday**
says that, all else equal, there tend to be fewer casual riders on a
work day. 

By the way, we probably should expect fewer riders on very
cold or very hot days, so we may wish to add a quadratic term to the
model, say by doing

```r
day1$temp2 <- temp^2  # the caret symbol means exponentiation, 
                      # i.e. 2nd power here
```

This would add the indicated column to **day1**.  But we will not pursue
this for now.

One of the very important features of R is *generic functions*.  These
are functions that take on different roles for objects of different
classes.  One such example is the **plot** function we saw earlier.

Try typing "plot(lmout)" at the R prompt.  You will be shown several
plots desribing the fitted regression model.  What happened was that the
function **plot** is just a placeholder.  When we type "plot(lmout)" R
says, "Hmm, what kind of object is **lmout**?  Oh, it's of class
**'lm'**.  So I'm going to transfer (*dispatch*) this call to one
involving a special plot function for that class, **plot.lm**."  This is
in contrast to our previous calls to **plot**, which were invoked on
vectors; those calls were dispatched to **plot.default**.

Another generic function is **summary**:

```r
> summary(Nile)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  456.0   798.5   893.5   919.4  1032.5  1370.0 
> summary(lmout)
...
Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)  1063.55     101.37  10.492  < 2e-16 ***
workingday   -806.63      33.41 -24.143  < 2e-16 ***
temp         2149.52      86.32  24.901  < 2e-16 ***
hum          -812.74     112.98  -7.194 1.57e-12 ***
windspeed   -1145.31     208.55  -5.492 5.51e-08 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
...
```

In the first case, the call to **summary**, invoked on a vector, was
dispatched to **summary.default**, while in the second the transfer was
to **summary.lm**.  In both cases, whoever it was in the R development
team who wrote these functions decided what summary information should
be printed out automatically.

Again, the purpose of this tutorial is to present R, not statistics.
The interested reader should consult a statistics book regarding
*p-values* and *confidence intervals.*  The former are show in the last
column of the above summary.  An approximate 95% confidence interval
for, say, the population coefficient of humidity is -812.74 plus or
minus 1.96 times the *standard error*, 112.98.  Note carefully that
p-values have long been considered to be poor methodology; see 
the [ASA statement](https://amstat.tandfonline.com/doi/full/10.1080/00031305.2016.1154108).

Another important generic function is **predict**.  Say we want to
predict **casual** for a work day in which **temp**, **hum** and
**windspeed** are 0.26, 0.55, 0.18, respectively.

```r
> newCase <- data.frame(workingday=1, temp=0.26, hum=0.55, windspeed=0.18)
> predict(lmout,newCase)
       1 
162.6296 
```

The **predict** function, which here is **predict.lm**, assumes that the
new cases to be predicted are supplied as a data frame, with the same
column names as with the original data.
