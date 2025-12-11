# Ricker model with random perturbations (Random Ricker)

StochasticRicker <- function(N0 = 1, r = 1, K = 10, sigma = 0.2, generations = 50) {
  # The Ricker model with random error terms
  N <- rep(NA, generations)
  N[1] <- N0
  
  for (t in 2:generations) {
    N[t] <- N[t - 1] * exp(r * (1 - N[t - 1] / K) + rnorm(1, 0, sigma))
  }
  return(N)
}

# Visualization (suppress warnings to keep test log clean)
suppressWarnings(
  plot(StochasticRicker(generations = 50),
       type = "l",
       main = "Stochastic Ricker model",
       xlab = "Generation",
       ylab = "Population size")
)
