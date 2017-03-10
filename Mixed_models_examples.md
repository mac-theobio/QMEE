[http://zoonek2.free.fr/UNIX/48_R/14.html Examples from Vincent Zoonekynd]

Formulae:
<pre>
y ~ x                       No random effects
y ~ x + (1|g)               The intercept is a random effect
y ~ x + (1|site/block)      Nested random effects (block within site)
y ~ x + (1|site) + (1|year) Crossed random effects
y ~ x + (1|site:block)      Interaction (only block within site)
y ~ x + (x|g)               Intercept and slope are random effects
y ~ (x|g)                   Zero slope on average (weird!)
y ~ x + (1|g)+(0+x|g)       Independent slope and intercept
</pre>


```
## Loading required package: Matrix
```

```
## 
## Attaching package: 'lme4'
```

```
## The following object is masked from 'package:stats':
## 
##     sigma
```

```
## Error in (function (el, elname) : Element line must be a element_line object.
```

![plot of chunk mmex1.R](figure/mmex1.R-1.png)




```
## 
## Attaching package: 'nlme'
```

```
## The following object is masked from 'package:lme4':
## 
##     lmList
```

```
## Linear mixed-effects model fit by REML
##  Data: sleepstudy 
##        AIC      BIC    logLik
##   1755.628 1774.719 -871.8141
## 
## Random effects:
##  Formula: ~Days | Subject
##  Structure: General positive-definite, Log-Cholesky parametrization
##             StdDev    Corr  
## (Intercept) 24.740241 (Intr)
## Days         5.922103 0.066 
## Residual    25.591843       
## 
## Fixed effects: Reaction ~ Days 
##                 Value Std.Error  DF  t-value p-value
## (Intercept) 251.40510  6.824516 161 36.83853       0
## Days         10.46729  1.545783 161  6.77151       0
##  Correlation: 
##      (Intr)
## Days -0.138
## 
## Standardized Within-Group Residuals:
##         Min          Q1         Med          Q3         Max 
## -3.95355735 -0.46339976  0.02311783  0.46339621  5.17925089 
## 
## Number of Observations: 180
## Number of Groups: 18
```




```
## Error in (function (el, elname) : Element line must be a element_line object.
```

![plot of chunk mmex3.R](figure/mmex3.R-1.png)![plot of chunk mmex3.R](figure/mmex3.R-2.png)![plot of chunk mmex3.R](figure/mmex3.R-3.png)




```
## Linear mixed model fit by REML ['lmerMod']
## Formula: Reaction ~ Days + (Days | Subject)
##    Data: sleepstudy
## 
## REML criterion at convergence: 1743.6
## 
## Scaled residuals: 
##     Min      1Q  Median      3Q     Max 
## -3.9536 -0.4634  0.0231  0.4634  5.1793 
## 
## Random effects:
##  Groups   Name        Variance Std.Dev. Corr
##  Subject  (Intercept) 612.09   24.740       
##           Days         35.07    5.922   0.07
##  Residual             654.94   25.592       
## Number of obs: 180, groups:  Subject, 18
## 
## Fixed effects:
##             Estimate Std. Error t value
## (Intercept)  251.405      6.825   36.84
## Days          10.467      1.546    6.77
## 
## Correlation of Fixed Effects:
##      (Intr)
## Days -0.138
```
