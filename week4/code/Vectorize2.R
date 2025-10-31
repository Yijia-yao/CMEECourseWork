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

# Visualization
plot(StochasticRicker(generations = 50), type = "l", main = "随机 Ricker 模型", xlab = "世代", ylab = "种群数量")

