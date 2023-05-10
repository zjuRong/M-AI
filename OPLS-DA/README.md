# OPLS-DA model
The function of this model is to obtain the ranking of the contribution of variables to the groups of two or more groups, and finally identify the metabolites that play an important role in grouping.

## Development environment
* R version 4.2.2 (2022-10-31)

## Prerequisites

```R
library(ropls)
library(ggrepel)
library(ggplot2)
library(gridExtra)
```


## Data structure

![data](input.png#pic_center)


## Grouping 

In this section, we only need to fill in the corresponding group information clearly in the data, and the parameters do not need to be changed
### 1 two-category data.[./OPLSDA.R]
### 2 multi-grouping data. [./OPLSDA_M.R]
## Output ROC
![ROC](Rplot1.png#pic_center)
