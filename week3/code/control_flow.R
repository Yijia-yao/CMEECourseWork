# Examples of if, for, and while control statements


# if
a <- TRUE
if (a == TRUE) {
  print("a is TRUE")
} else {
  print("a is FALSE")
}

# single if
z <- runif(1)
if (z <= 0.5) {
  print("less than 0.5")
}

# for loop (1~10 square)
for (i in 1:10) {
  j <- i * i
  print(paste(i, "The square of this number is", j))
}

# The for loop traverses the string
for (species in c('Heliodoxa rubinoides', 
                  'Boissonneaua jardini', 
                  'Sula nebouxii')) {
  print(paste("Species name:", species))
}

# The for loop traverses the vector
v1 <- c("a","bc","def")
for (i in v1) {
  print(i)
}

# while loop
i <- 0
while (i < 10) {
  i <- i + 1
  print(i^2)
}

print("control_flow.R Run completed！")
