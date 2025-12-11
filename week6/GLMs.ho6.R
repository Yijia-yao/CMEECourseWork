# ===== GLMs.ho6.R =====


# GLMs - 06

rm(list=ls())
getwd()
setwd("D:/Users/lenovo/Desktop/Statistic in R/Week6/handout/friday")

require(usdm)
require(psych)
require(lmerTest)
require(sjPlot)

# Load Park Grass data
parkgrass <- read.csv("../data/parkgrass_ms.csv")
str(parkgrass)

# Explore collinearity
pairs.panels(parkgrass[,-c(1,10,11,12,13)])

# Variance Inflation Factor analysis
vif(parkgrass[,-c(1,10,11,12,13)])
vif(parkgrass[,-c(1,6,10,11,12,13)])
vif(parkgrass[,-c(1,6,7,10,11,12,13)])
vif(parkgrass[,-c(1,6,7,8,10,11,12,13)])
vif(parkgrass[,-c(1,2,6,7,8,10,11,12,13)])

# Model 1: "Do Nothing" approach
M1 <- lm(Harvest ~ scale(CWM.LDMC) + scale(CWM.SLA) + scale(CWM.Seed.Mass) + 
           scale(SpRich) + factor(Ammonium) + factor(Nitrate) + factor(Minerals) + 
           scale(pH), data = parkgrass)
anova(M1)
summary(M1)

# Plot model
plot_model(M1, show.values = TRUE, show.intercept = TRUE)

# Model validation
par(mfrow=c(2,2))
plot(M1)

# Hypothesis testing approach
summary(M1)

# Stepwise removal
M2 <- update(M1, .~. - scale(CWM.LDMC))
anova(M1, M2)

M3 <- update(M2, .~. - scale(SpRich))
anova(M2, M3)

M4 <- update(M3, .~. - factor(Ammonium))
anova(M3, M4)

# Final model interpretation
summary(M3)
plot_model(M3, show.values = TRUE, show.intercept = TRUE)

# Model validation for final model
par(mfrow=c(2,2))
plot(M3)

# AIC approach
M5 <- step(M1, direction = "backward", 
           scope = list(lower = ~1, 
                        upper = ~scale(CWM.LDMC) + scale(CWM.SLA) + scale(CWM.Seed.Mass) + 
                          scale(SpRich) + factor(Ammonium) + factor(Nitrate) + 
                          factor(Minerals) + scale(pH)))

# Information Theoretic Approach - define models
M1_IT <- lm(Harvest ~ scale(CWM.LDMC) + scale(CWM.SLA) + scale(CWM.Seed.Mass) + 
              scale(SpRich) + factor(Ammonium) + factor(Nitrate) + factor(Minerals) + 
              scale(pH), data = parkgrass)

M2_IT <- lm(Harvest ~ scale(CWM.LDMC) + scale(CWM.SLA) + scale(CWM.Seed.Mass) + 
              factor(Ammonium) + factor(Nitrate) + factor(Minerals) + scale(pH), 
            data = parkgrass)

M3_IT <- lm(Harvest ~ scale(SpRich) + factor(Ammonium) + factor(Nitrate) + 
              factor(Minerals) + scale(pH), data = parkgrass)

M4_IT <- lm(Harvest ~ scale(CWM.LDMC) + scale(CWM.SLA) + factor(Ammonium) + 
              factor(Nitrate) + factor(Minerals) + scale(pH), data = parkgrass)

M5_IT <- lm(Harvest ~ scale(CWM.Seed.Mass) + factor(Ammonium) + factor(Nitrate) + 
              factor(Minerals) + scale(pH), data = parkgrass)

M6_IT <- lm(Harvest ~ SpRich + factor(Ammonium) + factor(Nitrate) + factor(Minerals) + 
              scale(pH) + scale(SpRich):factor(Ammonium) + scale(SpRich):factor(Nitrate) + 
              scale(SpRich):factor(Minerals), data = parkgrass)

M7_IT <- lm(Harvest ~ scale(CWM.Seed.Mass) + factor(Ammonium) + factor(Nitrate) + 
              factor(Minerals) + scale(pH) + scale(CWM.Seed.Mass):factor(Ammonium) + 
              scale(CWM.Seed.Mass):factor(Nitrate) + scale(CWM.Seed.Mass):factor(Minerals), 
            data = parkgrass)

M8_IT <- lm(Harvest ~ scale(CWM.LDMC) + factor(Ammonium) + factor(Nitrate) + 
              factor(Minerals) + scale(pH) + scale(CWM.LDMC):factor(Ammonium) + 
              scale(CWM.LDMC):factor(Nitrate) + scale(CWM.LDMC):factor(Minerals), 
            data = parkgrass)

M9_IT <- lm(Harvest ~ scale(CWM.SLA) + factor(Ammonium) + factor(Nitrate) + 
              factor(Minerals) + scale(pH) + scale(CWM.SLA):factor(Ammonium) + 
              scale(CWM.SLA):factor(Nitrate) + scale(CWM.SLA):factor(Minerals), 
            data = parkgrass)

M10_IT <- lm(Harvest ~ factor(Ammonium) + factor(Nitrate) + factor(Minerals) + 
               scale(pH) + factor(Ammonium):factor(Minerals) + factor(Nitrate):factor(Minerals) + 
               factor(Ammonium):scale(pH) + factor(Nitrate):scale(pH) + factor(Minerals):scale(pH), 
             data = parkgrass)

# Calculate AIC and weights
AIC(M1_IT, M2_IT, M3_IT, M4_IT, M5_IT, M6_IT, M7_IT, M8_IT, M9_IT, M10_IT)

# Calculate AIC weights
IT <- AIC(M1_IT, M2_IT, M3_IT, M4_IT, M5_IT, M6_IT, M7_IT, M8_IT, M9_IT, M10_IT)
IT$deltaAIC <- IT$AIC - min(IT$AIC)
IT$weight <- exp(-0.5*IT$deltaAIC)/sum(exp(-0.5*IT$deltaAIC))
IT

# Model averaging
require(MuMIn)

# Fit global model
M_global <- lm(Harvest ~ scale(CWM.LDMC) + scale(CWM.SLA) + scale(CWM.Seed.Mass) + 
                 scale(SpRich) + factor(Ammonium) + factor(Nitrate) + factor(Minerals) + 
                 scale(pH), data = parkgrass, na.action = "na.fail")

# Generate all possible models
allmodels <- dredge(M_global)

# Model averaging
avgmodel <- model.avg(allmodels, subset = delta < 4)
summary(avgmodel)