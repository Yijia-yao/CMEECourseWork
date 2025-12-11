# ===== SwS10_complete.R =====


# Stats with Sparrows - 10

# -----------------------------
# Clear the environment & set the directory
# -----------------------------
rm(list=ls()) 

# Create three datasets with different variances (1, 10, 100)
# rnorm() requires sample size, mean, and sd
y1 <- rnorm(10, mean = 0, sd = sqrt(1))
var(y1)

y2 <- rnorm(10, mean = 0, sd = sqrt(10))
var(y2)

y3 <- rnorm(10, mean = 0, sd = sqrt(100))
var(y3)

# Create x variable for plotting
x <- rep(0, 10)

# Create 1x3 plotting window
par(mfrow = c(1, 3))

# Plot three datasets with different variances
plot(x, y1, xlim = c(-0.1, 0.1), ylim = c(-12, 12), pch = 19, cex = 0.8, col = "red")
abline(v = 0); abline(h = 0)

plot(x, y2, xlim = c(-0.1, 0.1), ylim = c(-12, 12), pch = 19, cex = 0.8, col = "blue")
abline(v = 0); abline(h = 0)

plot(x, y3, xlim = c(-0.1, 0.1), ylim = c(-12, 12), pch = 19, cex = 0.8, col = "darkgreen")
abline(v = 0); abline(h = 0)


# ----------------------------------------------------------
# VISUALIZE SUM OF SQUARED DEVIATIONS
# ----------------------------------------------------------

par(mfrow = c(1, 3))

plot(x, y1, xlim = c(-12, 12), ylim = c(-12, 12), pch = 19, cex = 0.8, col = "red")
abline(v = 0); abline(h = 0)
for (i in 1:length(y1)) {
  polygon(x = c(0, 0, y1[i], y1[i]), y = c(0, y1[i], y1[i], 0), col = rgb(1, 0, 0, 0.2))
}

# For y2
plot(x, y2, xlim = c(-12, 12), ylim = c(-12, 12), pch = 19, cex = 0.8, col = "blue")
abline(v = 0); abline(h = 0)
for (i in 1:length(y2)) {
  polygon(x = c(0, 0, y2[i], y2[i]), y = c(0, y2[i], y2[i], 0), col = rgb(0, 0, 1, 0.2))
}

# For y3
plot(x, y3, xlim = c(-12, 12), ylim = c(-12, 12), pch = 19, cex = 0.8, col = "darkgreen")
abline(v = 0); abline(h = 0)
for (i in 1:length(y3)) {
  polygon(x = c(0, 0, y3[i], y3[i]), y = c(0, y3[i], y3[i], 0), col = rgb(0, 1, 0, 0.2))
}


# ----------------------------------------------------------
# COVARIANCE DEMONSTRATION
# ----------------------------------------------------------

rm(list = ls())
par(mfrow = c(1, 3))
x <- c(-10:10)
var(x)

# Positive association
y1 <- x * 1 + rnorm(21, mean = 0, sd = sqrt(1))
cov(x,y1)
plot(x, y1, col = "red", pch = 19, cex = 0.8, main = paste("Cov =", round(cov(x, y1), 2)))

# No association
y2 <- rnorm(21, mean = 0, sd = sqrt(1))
cov(x,y2)
plot(x, y2, col = "blue", pch = 19, cex = 0.8, main = paste("Cov =", round(cov(x, y2), 2)))

# Negative association
y3 <- x * (-1) + rnorm(21, mean = 0, sd = sqrt(1))
cov(x,y3)
plot(x, y3, col = "darkgreen", pch = 19, cex = 0.8, main = paste("Cov =", round(cov(x, y3), 2)))


# ----------------------------------------------------------
# DIFFERENT ASSOCIATION STRENGTHS
# ----------------------------------------------------------

rm(list = ls())
par(mfrow = c(1, 3))
x <- c(-10:10)
var(x)

# Weak association
y1 <- x * 0.1 + rnorm(21, mean = 0, sd = sqrt(1))
plot(x, y1, col = "red", pch = 19, cex = 0.8, main = paste("Cov =", round(cov(x, y1), 2)))

# Medium association
y2 <- x * 0.5 + rnorm(21, mean = 0, sd = sqrt(1))
plot(x, y2, col = "blue", pch = 19, cex = 0.8, main = paste("Cov =", round(cov(x, y2), 2)))

# Strong association
y3 <- x * 2 + rnorm(21, mean = 0, sd = sqrt(1))
plot(x, y3, col = "darkgreen", pch = 19, cex = 0.8, main = paste("Cov =", round(cov(x, y3), 2)))


# ----------------------------------------------------------
# CORRELATION VS COVARIANCE
# ----------------------------------------------------------

cov(x, y1)
cor(x, y1)

cov(x, y2)
cor(x, y2)

cov(x, y3)
cor(x, y3)


# ----------------------------------------------------------
# VARIANCE IN Y EFFECT ON CORRELATION
# ----------------------------------------------------------

rm(list = ls())
par(mfrow = c(3, 1))
x <- c(-10:10)
var(x)

# Low variance in y
y1 <- x * 1 + rnorm(21, mean = 0, sd = sqrt(1))
plot(x, y1, col = "red", pch = 19, cex = 0.8,
     main = paste("Cov =", round(cov(x, y1), 2), " Cor =", round(cor(x, y1), 2)))

# Medium variance in y
y2 <- x * 1 + rnorm(21, mean = 0, sd = sqrt(10))
plot(x, y2, col = "blue", pch = 19, cex = 0.8,
     main = paste("Cov =", round(cov(x, y2), 2), " Cor =", round(cor(x, y2), 2)))

# High variance in y
y3 <- x * 1 + rnorm(21, mean = 0, sd = sqrt(100))
plot(x, y3, col = "darkgreen", pch = 19, cex = 0.8,
     main = paste("Cov =", round(cov(x, y3), 2), " Cor =", round(cor(x, y3), 2)))


# ----------------------------------------------------------
# CALCULUS RULES FOR MEAN, VARIANCE, COVARIANCE
# ----------------------------------------------------------

# Rules for Mean
rm(list = ls())

# 1) Mean of a constant
mean(4)

# 2) Adding a constant shifts the mean by that constant
y <- c(-3, 5, 8, -2)
mean(y + 4)
mean(y) + 4

# 3) Multiplying by a constant scales the mean
mean(y * 4)
mean(y) * 4

# 4) Mean of a sum = sum of the means
y1 <- runif(4)
mean(y1 + y)
mean(y1) + mean(y)


# Rules for Variance
# 1) Variance of a constant = 0
a <- c(4, 4, 4, 4)
var(a)

# 2) Adding a constant does not change variance
var(y + 4)

# 3) Multiplying by constant squares variance
var(y * 2)
var(y * 4)

# 4) Variance of sum of independent variables = sum of variances
y2 <- c(-2, -10, 20, 18)
var(y + y2)
var(y) + var(y2)


# Rules for Covariance
rm(list = ls())

# 1) Covariance of two constants = 0
a <- rep(4, 10); b <- rep(6, 10)
cov(a, b)

# 2) Covariance of independent variables ~ 0
x <- runif(10); y <- runif(10)
cov(x, y)

# 3) Covariance is symmetric
cov(y, x)

# 4) Covariance with a constant = 0
a <- rep(4, 10)
cov(x, a)

# 5) Adding constant doesn’t change covariance
cov(x + 5, y)

# 6) Multiplying scales covariance
cov(x * 2, y)

# 7) Cov(x + y, z) = Cov(x, z) + Cov(y, z)
z <- x * 0.4 + 0.1 * runif(10)
cov(x + y, z)
cov(x, z) + cov(y, z)
