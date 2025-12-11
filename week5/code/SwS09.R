# ===== SwS09_complete.R =====


# Stats with Sparrows - 09

# -----------------------------
# Clear the environment & set the directory
# -----------------------------
rm(list=ls()) 

# ------------------------------------------------------------
# Load data
getwd()      
setwd("D:/Users/lenovo/Desktop/Statistic in R/Week5/data")
getwd() 

d <- read.table("SparrowSize.txt", header = TRUE)

# ------------------------------------------------------------
# Explore linear relationships: correlation between Tarsus and Mass
plot(d$Mass ~ d$Tarsus,
     ylab = "Mass (g)",
     xlab = "Tarsus (mm)",
     pch = 19, cex = 0.4)

# ------------------------------------------------------------
# A line in mathematical form:
# y = a + b*x
# where a = intercept, b = slope

# Demonstration of line equation
x <- c(1:100)
a <- 0.5
b <- 1.5
y <- b * x + a

# Plot the line
plot(x, y, xlim = c(0, 100), ylim = c(0, 100), pch = 19, cex = 0.5)

# ------------------------------------------------------------
# In statistics, we use:
# yi = b0 + b1*xi + εi
# where εi represents the residual (error term)


head(d$Mass)
d$Mass[1]
length(d$Mass)
d$Mass[1770]
tail(d$Mass)

# ------------------------------------------------------------
# Clean data: remove missing values

plot(d$Mass~d$Tarsus, 
     ylab="Mass (g)", 
     xlab="Tarsus (mm)", 
     pch=19, cex=0.4, ylim=c(-5,38), 
     xlim=c(0,22))

plot(d$Mass~d$Tarsus, ylab="Mass (g)", xlab="Tarsus (mm)", pch=19, cex=0.4)

# ------------------------------------------------------------
d1<-subset(d, d$Mass!="NA")
d2<-subset(d1, d1$Tarsus!="NA")
length(d2$Tarsus)

# Fit a linear model: Mass predicted by Tarsus
model1 <- lm(Mass ~ Tarsus, data = d2)
summary(model1)

# ------------------------------------------------------------
# Examine residuals
hist(model1$residuals)
head(model1$residuals)

# ------------------------------------------------------------
# Demonstrate perfect fit (R² = 1) using simulated data
model2 <- lm(y ~ x)
summary(model2)

# ------------------------------------------------------------
# Z-standardization of predictor variable (Tarsus)
d2$z.Tarsus <- scale(d2$Tarsus)

# Fit model using standardized Tarsus
model3 <- lm(Mass ~ z.Tarsus, data = d2)
summary(model3)

# ------------------------------------------------------------
# Visualize the standardized relationship
plot(d2$Mass ~ d2$z.Tarsus, pch = 19, cex = 0.4)
abline(v = 0, lty = "dotted")

# ------------------------------------------------------------
# Look at dataset structure
head(d)
str(d)

# Convert Sex variable to numeric (if not already)
d$Sex <- as.numeric(d$Sex)

# ------------------------------------------------------------
# Plot Wing vs Sex with regression line
plot(d$Wing ~ d$Sex,
     xlab = "Sex",
     xlim = c(-0.1, 1.1),
     ylab = "Wing length")

abline(lm(d$Wing ~ d$Sex), lwd = 2)
text(0.15, 76, "intercept")
text(0.9, 77.5, "slope", col = "red")

# ------------------------------------------------------------
# Compare t-test and linear model for Wing ~ Sex
d4 <- subset(d, d$Wing != "NA")
m4 <- lm(Wing ~ Sex, data = d4)
t4 <- t.test(d4$Wing ~ d4$Sex, var.equal = TRUE)

summary(m4)
t4

# ------------------------------------------------------------
# Linear model diagnostics
# The main assumption: residuals are normally distributed
par(mfrow = c(2, 2))
plot(model3)

# ------------------------------------------------------------
# Compare diagnostic plots with another model
par(mfrow = c(2, 2))
plot(m4)