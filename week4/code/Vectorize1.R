# Function: Compare the speed of loop and vectorized summation


# Create a 1000x1000 matrix
M <- matrix(runif(1000000), 1000, 1000)

# Create a 1000x1000 matrix
SumAllElements <- function(M) {
  Dimensions <- dim(M)
  Tot <- 0
  for (i in 1:Dimensions[1]) {
    for (j in 1:Dimensions[2]) {
      Tot <- Tot + M[i, j]
    }
  }
  return(Tot)
}

print("The time of using the loop:")
print(system.time(SumAllElements(M)))

print("The time for using the built-in vectorization function:")
print(system.time(sum(M)))
