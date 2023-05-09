# LASSO model
The function of this model is to obtain the ranking of the contribution of variables to the groups of two or more groups, and finally identify the metabolites that play an important role in grouping.

## Development environment
* R version 4.2.2 (2022-10-31)

## Prerequisites

```R
install.packages('glmnet')
install.packages('pROC')
```


## data structure

![data](input.png#pic_center)


## grouping parameter setting

In this section, we need to set the parameters of the modeling process in the program to make our model conform to our group analysis.
```R
# build LASSO model
lasso.fit <- glmnet(x, y, family="binomial", alpha=1)

# Find optimized lambda value
cv.fit <- cv.glmnet(x, y, family="binomial", alpha=1)
best.lambda <- cv.fit$lambda.min

# Train LASSO model
lasso.fit.best <- glmnet(x, y, family="binomial", alpha=1, lambda=best.lambda)
```

### 1 two-category data. family="binomial". [LASSO.R](LASSO.R)
### 2 multi-grouping data. family="multinomial". [LASSO_M.R](LASSO_M.R)

## output ROC
![ROC](Rplot.png#pic_center)
