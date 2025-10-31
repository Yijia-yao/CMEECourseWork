# plotLin.R
# Linear regression plot with mathematical annotations

# Load necessary library
library(ggplot2)

# Generate linear regression data
x <- seq(0, 100, by = 0.1)
y <- -4 + 0.25 * x + rnorm(length(x), mean = 0, sd = 2.5)

# Put data into a dataframe
my_data <- data.frame(x = x, y = y)

# Perform linear regression
my_lm <- summary(lm(y ~ x, data = my_data))

# Create the plot
p <- ggplot(my_data, aes(x = x, y = y, colour = abs(my_lm$residual))) +
  geom_point() +
  scale_colour_gradient(low = "black", high = "red") +
  theme(legend.position = "none") +
  scale_x_continuous(expression(alpha^2 * pi / beta * sqrt(Theta))) +
  # Add regression line
  geom_abline(
    intercept = my_lm$coefficients[1, 1],
    slope = my_lm$coefficients[2, 1],
    colour = "red"
  ) +
  # Add mathematical annotation inside the plot
  annotate("text", x = 60, y = 0, label = "sqrt(alpha) * 2 * pi",
           parse = TRUE, size = 6, colour = "blue") +
  theme_minimal()

# Create results directory if it doesn't exist
if(!dir.exists("results")) {
  dir.create("results")
}

# Save the plot as PDF
ggsave(filename = "../results/MyLinReg.pdf", plot = p, width = 8, height = 5)

# Optional: display plot
print(p)
