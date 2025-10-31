# Use custom functions in apply


# Custom function: Calculate the mean, minimum and maximum values of the vector
SomeOperation <- function(v) { # (What does this function do?)
  if (sum(v) > 0) { #note that sum(v) is a single (scalar) value
    return (v * 100)
  } else { 
  return (v)
    }
}

M <- matrix(rnorm(100), 10, 10)
print (apply(M, 1, SomeOperation))
