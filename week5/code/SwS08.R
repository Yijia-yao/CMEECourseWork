# ===== SwS08_complete.R =====


# Stats with Sparrows - 08

# -----------------------------
# Clear the environment & set the directory
# -----------------------------
rm(list=ls()) 

# ------------------------------------------------------------
# Create vectors x and y
x <- c(1, 2, 3, 4, 8)
y <- c(4, 3, 5, 7, 9)

x
mean(x)
var(x)

y
mean(y)
var(y)

# ------------------------------------------------------------
# Run a simple linear model
# y = b0 + b1*x + error
model1 <- lm(y ~ x)
model1

# Get a detailed summary of the model
summary(model1)

# ------------------------------------------------------------
# Accessing model components
coefficients(model1)   # Intercept and slope
resid(model1)          # Residuals
mean(resid(model1))    # Mean of residuals
var(resid(model1))     # Variance of residuals
length(resid(model1))  # Number of residuals (same as number of data points)

summary(model1)
# ------------------------------------------------------------
# Plot data and fitted regression line
plot(y ~ x, pch = 19, xlim = c(0, 8.5), ylim = c(0, 9.5))
segments(0, -30, 0, 30, lty = 3)
segments(-30, 0, 30, 0, lty = 3)

# Retrieve coefficients and draw regression line
coefficients(model1)
abline(2.62, 0.83)

# ------------------------------------------------------------
# Simulating a larger dataset
# Create x values ranging from -10 to 10
x <- seq(from = -10, to = 10, by = 0.2)
x

# Define intercept (a) and slope (b)
y <- 7.1 - 0.2 * x
y

# ------------------------------------------------------------
# Run linear model on the simulated data
summary(lm(y ~ x))

# Plot the perfect relationship (no error)
plot(y ~ x)

# ------------------------------------------------------------
# Add random variation to y using uniform random numbers
# runif() generates random numbers between 0 and 1
y <- 7.1 - 0.2 * x + runif(length(x))

# Fit linear model with random noise
summary(lm(y ~ x))
