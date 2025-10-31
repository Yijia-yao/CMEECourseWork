# Girko.R
# Simulation of Girko's Circular Law and plotting

# Load necessary library
library(ggplot2)

# Function to build an ellipse
build_ellipse <- function(hradius, vradius) {
  npoints <- 250
  a <- seq(0, 2 * pi, length = npoints + 1)
  x <- hradius * cos(a)
  y <- vradius * sin(a)
  return(data.frame(x = x, y = y))
}

# Set matrix size
N <- 250

# Generate a random NxN matrix
M <- matrix(rnorm(N * N), N, N)

# Compute eigenvalues
eigvals <- eigen(M)$values

# Create dataframe for eigenvalues
eigDF <- data.frame("Real" = Re(eigvals), "Imaginary" = Im(eigvals))

# Calculate radius of the circle
my_radius <- sqrt(N)

# Build ellipse dataframe
ellDF <- build_ellipse(my_radius, my_radius)
names(ellDF) <- c("Real", "Imaginary")

# Create results directory if it doesn't exist
if(!dir.exists("results")) {
  dir.create("results")
}

# Plot
p <- ggplot(eigDF, aes(x = Real, y = Imaginary)) +
  geom_point(shape = 3) +  # plot eigenvalues
  geom_hline(yintercept = 0) +
  geom_vline(xintercept = 0) +
  geom_polygon(data = ellDF, aes(x = Real, y = Imaginary), alpha = 1/20, fill = "red") +
  theme_minimal() +
  theme(legend.position = "none") +
  ggtitle("Girko's Circular Law Simulation")

# Save plot
ggsave(filename = "../results/Girko.pdf", plot = p, width = 7, height = 7)

# Optional: print plot to RStudio or default device
print(p)
