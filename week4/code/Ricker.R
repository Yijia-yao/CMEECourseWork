# 运行确定性 Ricker 种群模型

Ricker <- function(N0 = 1, r = 1, K = 10, generations = 50) {
  # 运行 Ricker 模型模拟
  # 返回长度为 generations 的向量
  
  N <- rep(NA, generations)  # 创建一个全为 NA 的向量
  N[1] <- N0
  
  for (t in 2:generations) {
    N[t] <- N[t - 1] * exp(r * (1.0 - (N[t - 1] / K)))
  }
  
  return(N)
}

# 画图查看结果
plot(Ricker(generations = 50), type = "l", main = "Ricker 模型（确定性）", xlab = "世代", ylab = "个体数量")
