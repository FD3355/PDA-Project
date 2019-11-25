---
title: "R Notebook"
output: html_notebook
---

This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook. When you execute code within the notebook, the results appear beneath the code. 

Try executing this chunk by clicking the *Run* button within the chunk or by placing your cursor inside it and pressing *Ctrl+Shift+Enter*. 

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
library(dplyr)
library(lme4)
library(effects)
library(corrplot)
library(knitr)
library(ggplot2)
#install.packages('pROC')
library(pROC)
library(MASS)
library(class)
#library(klaR)
#install.packages('earth')
library(earth)
```

```{r}

Pokemon=read.csv("C:/Users/Frank/Documents/Pokemon.csv")
#Pokemon$type2[is.na(Pokemon$type2)]="none"
levels(Pokemon$type2)=c(levels(Pokemon$type2),"none")
Pokemon$type2[Pokemon$type2==""]="none"

Num_Col=c(26:29,32,34,35,36,37,39:41)
Pokemon_Cor=Pokemon[,Num_Col]
Pokemon_Cor$type1=as.numeric(Pokemon$type1)


corrplot(cor(Pokemon_Cor))

summary(Pokemon_Cor)
```


```{r}
model=earth(defense~is_legendary+generation+percentage_male+weight_kg+height_m+experience_growth+speed,Pokemon[complete.cases(Pokemon),])
model=earth(defense~type1+type2+weight_kg+height_m,Pokemon[complete.cases(Pokemon),])
#expand.bpairs(type1~defense,Pokemon[complete.cases(Pokemon),])
summary(model)
plotmo(model)
```

