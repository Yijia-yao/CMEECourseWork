# ===== SwS11_complete.R =====


# Stats with Sparrows - 11

# -----------------------------
# Clear the environment & set the directory
# -----------------------------
rm(list=ls()) 

# ============================================================
# PART 1: Daphnia Growth Example
# ============================================================

# Load dataset
getwd()      
setwd("D:/Users/lenovo/Desktop/Statistic in R/Week5/data")
getwd() 
daphnia <- read.delim("daphnia.txt")
summary(daphnia)
head(daphnia)
str(daphnia)

# ------------------------------------------------------------
# Check for outliers
# ------------------------------------------------------------
par(mfrow = c(1, 2), mar = c(4, 4, 1, 1))
plot(Growth.rate ~ as.factor(Detergent), data = daphnia)
plot(Growth.rate ~ as.factor(Daphnia), data = daphnia)
par(mfrow = c(1, 1))

# ------------------------------------------------------------
# Homogeneity of variances
# ------------------------------------------------------------
library(dplyr)

daphnia %>%
  group_by(Detergent) %>%
  summarise(variance = var(Growth.rate))

daphnia %>%
  group_by(Daphnia) %>%
  summarise(variance = var(Growth.rate))
# Variance ratio slightly > 4 → borderline, keep in mind when interpreting.

# ------------------------------------------------------------
# Normality check
# ------------------------------------------------------------
dev.off()
hist(daphnia$Growth.rate)
# Distribution roughly normal — acceptable for regression.


# ------------------------------------------------------------
# Calculate means and standard errors for barplots
# ------------------------------------------------------------
seFun <- function(x) sqrt(var(x) / length(x))

detergentMean <- with(daphnia, tapply(Growth.rate, Detergent, mean))
detergentSEM  <- with(daphnia, tapply(Growth.rate, Detergent, seFun))
cloneMean     <- with(daphnia, tapply(Growth.rate, Daphnia, mean))
cloneSEM      <- with(daphnia, tapply(Growth.rate, Daphnia, seFun))

par(mfrow = c(2, 1), mar = c(4, 4, 1, 1))
barMids <- barplot(detergentMean, xlab = "Detergent Type", ylab = "Population Growth Rate", ylim = c(0, 5))
arrows(barMids, detergentMean - detergentSEM, barMids, detergentMean + detergentSEM, code = 3, angle = 90)

barMids <- barplot(cloneMean, xlab = "Daphnia Clone", ylab = "Population Growth Rate", ylim = c(0, 5))
arrows(barMids, cloneMean - cloneSEM, barMids, cloneMean + cloneSEM, code = 3, angle = 90)

# ------------------------------------------------------------
# Fit linear model
# ------------------------------------------------------------
daphniaMod <- lm(Growth.rate ~ Detergent + Daphnia, data = daphnia)
summary(daphniaMod)

# ------------------------------------------------------------
# Fit ANOVA model and Tukey HSD post-hoc test
# ------------------------------------------------------------
detergentMean - detergentMean[1]
cloneMean - cloneMean[1]
daphniaANOVAMod <- aov(Growth.rate ~ Detergent + Daphnia, data = daphnia)
summary(daphniaANOVAMod)

daphniaModHSD <- TukeyHSD(daphniaANOVAMod)
daphniaModHSD

par(mfrow = c(2, 1), mar = c(4, 4, 1, 1))
plot(daphniaModHSD)

# ------------------------------------------------------------
# Model diagnostics
# ------------------------------------------------------------
par(mfrow = c(2, 2))
plot(daphniaMod)

# ============================================================
# Multiple Regression Example - Timber Dataset
# ============================================================

timber <- read.delim("timber.txt")
summary(timber)
str(timber)
head(timber)

# ------------------------------------------------------------
# Outliers
# ------------------------------------------------------------
par(mfrow = c(2, 2))
boxplot(timber$volume)
boxplot(timber$girth)
boxplot(timber$height)

# ------------------------------------------------------------
# Homogeneity of variances
# ------------------------------------------------------------
var(timber$volume)
var(timber$girth)
var(timber$height)

# Standardize predictors (z-scores)
t2 <- subset(timber, !is.na(volume))
t2$z.girth <- scale(timber$girth)
t2$z.height <- scale(timber$height)
var(t2$z.girth)
var(t2$z.height)
plot(t2)

# ------------------------------------------------------------
# Normality check
# ------------------------------------------------------------
par(mfrow = c(2, 2))
hist(t2$volume)
hist(t2$girth)
hist(t2$height)

# ------------------------------------------------------------
# Collinearity
# ------------------------------------------------------------


# Calculate VIF manually
summary(lm(girth ~ height, data = timber))
VIF <- 1 / (1 - 0.27)
VIF
sqrt(VIF)
pairs(timber)
cor(timber)
pairs(t2)
cor(t2)
# ------------------------------------------------------------
# Fit multiple regression model
# ------------------------------------------------------------
timberMod <- lm(volume ~ girth + height, data = timber)
anova(timberMod)
summary(timberMod)

# Model validation plots
plot(timberMod)

# ============================================================
# EXERCISE 1:
# Run the timber model without the outlier (e.g., row 31)
# ============================================================
# Example:
timber_no_outlier <- timber[-31, ]
timberMod2 <- lm(volume ~ girth + height, data = timber_no_outlier)
summary(timberMod2)
plot(timberMod2)

# ============================================================
# EXERCISE 2: Ipomopsis Dataset (Grazing and Root Size)
# ============================================================

plantGrowth <- read.delim("ipomopsis.txt")
summary(plantGrowth)
str(plantGrowth)

# Check assumptions (1–6) as before.
pairs(plantGrowth[, 1:2], 
      col = ifelse(plantGrowth$Grazing == "Ungrazed", "blue", "red"),
      pch = 19)
cor(plantGrowth$Root, plantGrowth$Fruit)

# Fit models
nullMod <- lm(Fruit ~ 1, data = plantGrowth)
maxMod  <- lm(Fruit ~ Root * Grazing, data = plantGrowth)
summary(maxMod)
anova(nullMod, maxMod)

# ============================================================
# EXERCISE 3: Sparrow Dataset (Structural Measurements)
# ============================================================

sparrow <- read.delim("SparrowSize.txt")
summary(sparrow)
str(sparrow)

