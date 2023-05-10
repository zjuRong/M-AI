# load packages
library(ropls)
library(ggrepel)
library(ggplot2)
library(gridExtra)
# input data
setwd("C:/data/OPLS-DA")
data=read.csv("data_m.csv")
group=data$group

x=as.matrix(data[,3:dim(data)[2]])

# build model
opls =opls(x,group, predI = 1, orthoI = 2, fig.pdfC = FALSE)
VIP <- getVipVn(opls)
vip_data=cbind(names(VIP),VIP)
vip_data=data.frame(vip_data)
colnames(vip_data)=c("Peak","VIP value")
data <- attributes(opls)
x <- data$scoreMN
y <- data$orthoScoreMN[, 1]
dd <- cbind(x, y)
dd <- cbind(dd, group)
colnames(dd) <- c("x", "y", "group")
summary <- data$summaryDF[, 1:4]
# output data
write.csv(dd, "opls_data_m.csv", row.names = FALSE)
write.csv(vip_data, "VIP_all_m.csv",row.names=F)

# Visualize the results
dd=data.frame(dd)
ggplot(data = dd, (aes(x, y, fill = group, colour = group))) +
  geom_point(size = 2) +
  theme_bw() +
  guides(colour = guide_legend(override.aes = list(size = 2))) +
  stat_ellipse(geom = "polygon", alpha = 0.2) +
  labs(x = "O1", y = "P1", title = "OPLS-DA for data") +
  theme(legend.position = "right") +
  annotation_custom(grob = tableGrob(summary, rows = NULL))
