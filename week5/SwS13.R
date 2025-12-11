# ===== SwS13_complete.R =====


# Stats with Sparrows - 13

# -----------------------------
# Clear the environment & set the directory
# -----------------------------
rm(list=ls()) 


## --- Repeatability with linear mixed models, and beyond ---
setwd("D:/Users/lenovo/Desktop/Statistic in R/Week5/data")
a <- read.table("Wylde_single.mounted.txt", header=T)
head(a)

library(lme4)

## --- Femur length repeatability ---
lmm1 <- lmer(Femur_length ~ 1 + (1 | ID), data = a)
summary(lmm1)

## --- Calculate Repeatability ---
Repeatability <- 1.257 / (1.257 + 0.0003)
Repeatability

## --- Exercises ---
## (1) Calculate repeatability of tarsus, wing and mass in house sparrows
d <- read.table("SparrowSize.txt", header = TRUE)

library(lme4)

## Tarsus repeatability
lmm_tarsus <- lmer(Tarsus ~ 1 + (1 | BirdID), data = d)
summary(lmm_tarsus)

## Wing repeatability
lmm_wing <- lmer(Wing ~ 1 + (1 | BirdID), data = d)
summary(lmm_wing)

## Mass repeatability
lmm_mass <- lmer(Mass ~ 1 + (1 | BirdID), data = d)
summary(lmm_mass)

## (2) Compare simple linear model vs mixed model (with ID as random effect)
lm_tarsus <- lm(Tarsus ~ Sex.1, data = d)
summary(lm_tarsus)

lmm_tarsus2 <- lmer(Tarsus ~ Sex.1 + (1 | BirdID), data = d)
summary(lmm_tarsus2)

lm_wing <- lm(Wing ~ Sex.1, data = d)
summary(lm_wing)

lmm_wing2 <- lmer(Wing ~ Sex.1 + (1 | BirdID), data = d)
summary(lmm_wing2)

lm_mass <- lm(Mass ~ Sex.1, data = d)
summary(lm_mass)

lmm_mass2 <- lmer(Mass ~ Sex.1 + (1 | BirdID), data = d)
summary(lmm_mass2)

## (3) Add a second random effect (Year)
lmm_tarsus_year <- lmer(Tarsus ~ Sex.1 + (1 | BirdID) + (1 | Year), data = d)
summary(lmm_tarsus_year)

lmm_wing_year <- lmer(Wing ~ Sex.1 + (1 | BirdID) + (1 | Year), data = d)
summary(lmm_wing_year)

lmm_mass_year <- lmer(Mass ~ Sex.1 + (1 | BirdID) + (1 | Year), data = d)
summary(lmm_mass_year)