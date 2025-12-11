# ===== GLMs.ho5.R =====


# GLMs - 05

rm(list=ls())
getwd()
setwd("D:/Users/lenovo/Desktop/Statistic in R/Week6/handout/thursday")

d <- read.table("SparrowSize.txt", header=TRUE)
str(d)
names(d)
head(d)

# Data cleaning
dat <- na.omit(d)
d1 <- data.frame(d$Tarsus, d$Wing, d$Sex)
pairs(d1, pch=19, cex=0.7)

# Correlation test
cor.test(dat$Wing, dat$Tarsus)

# Variance calculations
var(dat$Tarsus)
var(dat$Wing)
mean(dat$Wing)
mean(dat$Tarsus)

# Load MCMCglmm
install.packages('MCMCglmm')
library(MCMCglmm)

# Bivariate model without covariance
mMaxNoCov <- MCMCglmm(cbind(Tarsus, Wing) ~ trait - 1 + trait:Sex,
                      random = ~ idh(trait):BirdID + idh(trait):Cohort,
                      rcov = ~ idh(trait):units,
                      family = c("gaussian", "gaussian"),
                      data = dat, nitt = 100000, verbose = FALSE)

plot(mMaxNoCov)
summary(mMaxNoCov)

# Full bivariate model with covariance
mFull <- MCMCglmm(cbind(Tarsus, Wing) ~ trait - 1 + trait:Sex,
                  random = ~ us(trait):BirdID + idh(trait):Cohort,
                  rcov = ~ us(trait):units,
                  family = c("gaussian", "gaussian"),
                  data = dat, nitt = 100000, verbose = TRUE)

plot(mFull)

# Check autocorrelation
autocorr(mFull$Sol)
autocorr(mFull$VCV)

# Model summary and interpretation
summary(mFull)

# Reduced model without cohort
m2 <- MCMCglmm(cbind(Tarsus, Wing) ~ trait - 1 + trait:Sex,
               random = ~ us(trait):BirdID,
               rcov = ~ us(trait):units,
               family = c("gaussian", "gaussian"),
               data = dat, nitt = 100000, verbose = FALSE)

# Compare models using DIC
mFull$DIC
m2$DIC
