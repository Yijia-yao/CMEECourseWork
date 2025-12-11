# Deterministic Ricker population model

Ricker <- function(N0 = 1, r = 1, K = 10, generations = 50) {
  # Run Ricker model simulation
  # Returns a vector of length generations
  
  N <- rep(NA, generations)
  N[1] <- N0
  
  for (t in 2:generations) {
    N[t] <- N[t - 1] * exp(r * (1.0 - (N[t - 1] / K)))
  }
  
  return(N)
}

# Plot the result
suppressWarnings(
  plot(Ricker(generations = 50),
       type = "l",
       main = "Ricker model (deterministic)",
       xlab = "Generation",
       ylab = "Population size")
)
