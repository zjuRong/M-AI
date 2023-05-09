# load packages
library(glmnet)
library(pROC)

# input data
setwd("C:/data/LASSO")
data=read.csv("data_m.csv")
y=data$group

x=as.matrix(data[,3:dim(data)[2]])

# build LASSO model
lasso.fit <- glmnet(x, y, family="multinomial", alpha=1)

# Find optimized lambda value
cv.fit <- cv.glmnet(x, y, family="multinomial", alpha=1)
best.lambda <- cv.fit$lambda.min

# Train LASSO model
lasso.fit.best <- glmnet(x, y, family="multinomial", alpha=1, lambda=best.lambda)

# Get the variable coefficient and write out
coef <- coef(lasso.fit.best)
ss=lapply(coef, as.matrix)
coef=data.frame(ss)
write.csv(coef,"coef_all_m.csv")

# Scan for non-zero variable coefficients and output
nonzero_coef <- rownames(coef[which(coef[,1] != 0),])

cat("non-zero variable 0 group：", nonzero_coef)

nonzero_coef <- rownames(coef[which(coef[,2] != 0),])

cat("non-zero variable 1 group：", nonzero_coef)

nonzero_coef <- rownames(coef[which(coef[,3] != 0),])

cat("non-zero variable 2 group：", nonzero_coef)

# caculate the AUC and ROC
lasso.probs <- predict(lasso.fit.best, newx=x, type="response")
lasso.probs=data.frame(lasso.probs)
colnames(lasso.probs)=c(0,1,2)

roc <- multiclass.roc(y, lasso.probs)
auc <- auc(roc)

# Visualize the results of the ROC and AUC for 0 group
plot(roc$rocs[[1]][[1]],col="red",
     add=T,
     legacy.axes = TRUE,
     smooth =TRUE,
     main="ROC for LASSO model",
     print.auc=T,
     thresholds="best", # based on youden index
     print.thres="best") # show the optimum threshold

##add other group ROC
plot(roc$rocs[[2]][[1]],col="blue",
     add=T,
     legacy.axes = TRUE,
     smooth =TRUE,
     main="ROC for LASSO model",
     print.auc=T,
     thresholds="best", # based on youden index
     print.thres="best") # show the optimum threshold

plot(roc$rocs[[3]][[1]],col="green",
     add=T,
     legacy.axes = TRUE,
     smooth =TRUE,
     main="ROC for LASSO model",
     print.auc=T,
     thresholds="best", # based on youden index
     print.thres="best") # show the optimum threshold



