# Use "break" to exit the loop in advance


i <- 0
while (i < Inf) {
  if (i == 10) {
    break  # Terminate the loop when the conditions are met
  } else {
    cat("i Equal to", i, "\n")
    i <- i + 1
  }
}

print("break.R Run completed！")
