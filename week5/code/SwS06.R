# ===== SwS06_complete.R =====


# Stats with Sparrows - 06

# -----------------------------
# Clear the environment & set the directory
# -----------------------------
rm(list=ls()) 

# Load required package
# WebPower is used for power analysis
install.packages("WebPower")
require(WebPower)

# ------------------------------------------------------------------------
# Effect size calculation
# Historical reference: females have 0.3 m longer horns, SD = 1.2 m
# Cohen's d = difference / standard deviation
d <- 0.3 / 1.2
d


y <- rnorm(51, mean = 1, sd = 1.3)
# Create sequence for plotting (just a helper)
x <- seq(from = 0, to = 5, by = 0.1)

length(x)
# Plot histogram of simulated horn lengths
plot(hist(y, breaks=10))

# Draw mean as a blue vertical line
segments(x0 = mean(y), y0 = 0, x1 = mean(y), y1 = 40, lty = 1, col = "blue")

# Draw mean + 0.25 SD (effect size) as red line
segments(x0 = mean(y) + 0.25 * sd(y), y0 = 0, x1 = mean(y) + 0.25 * sd(y), y1 = 40, lty = 1, col = "red")

# ------------------------------------------------------------------------
# Power analysis for two-sample t-test
# Want 80% power (0.8), alpha = 0.05 (default)
# Effect size d = 0.25, two-sided test
# We want equal group sizes
wp_result <- wp.t(d = 0.25, power = 0.8, type = "two.sample", alternative = "two.sided")
wp_result
## Output shows n ≈ 252 per group

# ------------------------------------------------------------------------
# Generate a power curve for sample sizes from 20 to 300
res_curve <- wp.t(n1 = seq(20, 300, 20), 
                  n2 = seq(20, 300, 20), 
                  d = 0.25, 
                  type = "two.sample.2n", 
                  alternative = "two.sided")

# Display the result table
res_curve

# Plot the power curve
plot(res_curve, xvar = 'n1', yvar = 'power', 
     main = "Power Curve for Two-Sample t-test", 
     xlab = "Sample size per group", ylab = "Power")

# ------------------------------------------------------------------------
# Key observations from power analysis:
# - Small effect sizes (d = 0.25) require large sample sizes (~252 per group) to achieve 80% power
# - Power increases with larger sample sizes
# - If SD is smaller or effect size larger, required sample size decreases
# - Use this workflow to plan studies to avoid underpowered experiments

