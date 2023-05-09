# load packages
library(glmnet)
library(pROC)

# input data
setwd("C:/data/LASSO")
data=read.csv("data.csv")
y=data$group

x=as.matrix(data[,3:dim(data)[2]])

# build LASSO model
lasso.fit <- glmnet(x, y, family="binomial", alpha=1)

# Find optimized lambda value
cv.fit <- cv.glmnet(x, y, family="binomial", alpha=1)
best.lambda <- cv.fit$lambda.min

# Train LASSO model
lasso.fit.best <- glmnet(x, y, family="binomial", alpha=1, lambda=best.lambda)

# Get the variable coefficient and write out
coef <- coef(lasso.fit.best)

write.csv(coef[,1],"coef_all.csv")

# Scan for non-zero variable coefficients and output
nonzero_coef <- names(which(coef[,best.lambda+1] != 0))

cat("non-zero variable：", nonzero_coef)

# caculate the AUC and ROC
lasso.probs <- predict(lasso.fit.best, newx=x, type="response")
roc <- roc(y, lasso.probs)
auc <- auc(roc)

# 输出ROC曲线和AUC值
plot(roc,col="red",
     legacy.axes = TRUE,
     smooth =TRUE,
     main="ROC for LASSO model",
     print.auc=T,
     thresholds="best", # based on youden index
     print.thres="best") # show the optimum threshold




