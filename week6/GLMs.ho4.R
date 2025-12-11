# ===== GLMs.ho4.R =====


# GLMs - 04

rm(list=ls())
getwd()
setwd("D:/Users/lenovo/Desktop/Statistic in R/Week6/handout/tuesday and wednesday")

d <- read.table("ObserverRepeatability.txt", header=TRUE, fill = TRUE, quote = "", comment.char = "")
str(d)

# Data cleaning
d <- subset(d, d$Tarsus<=40)
d <- subset(d, d$Tarsus>=10)
d[is.na(d$Tarsus), ]
d <- na.omit(d)
d$Tarsus <- as.numeric(d$Tarsus)
hist(d$Tarsus)

# Descriptive statistics
summary(d$Tarsus)
var(d$Tarsus)
summary(d$BillWidth)
var(d$BillWidth)

# Load required packages
require(lme4)
require(lmtest)

# Mixed models for tarsus
mT1 <- lmer(Tarsus ~ 1 + (1|StudentID), data=d)
mT2 <- lmer(Tarsus ~ 1 + (1|StudentID) + (1|GroupN), data=d)

# Likelihood ratio test
lrtest(mT1, mT2)

# Summary of final model
summary(mT1)
