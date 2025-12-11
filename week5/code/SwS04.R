# ===== SwS04_complete.R =====


# Stats with Sparrows - 04

# -----------------------------
# Clear the environment & set the directory
# -----------------------------
rm(list=ls()) 
getwd()      
setwd("D:/Users/lenovo/Desktop/Statistic in R/Week5/data")
getwd()      
# reading data
d <- read.table("SparrowSize.txt", header = TRUE)
str(d)

# Subset data to remove NAs in Tarsus
d1 <- subset(d, d$Tarsus != "NA")

# Calculate standard error (SE) for Tarsus
seTarsus <- sqrt(var(d1$Tarsus) / length(d1$Tarsus))
seTarsus

# Calculate SE for Tarsus in the year 2001
d12001 <- subset(d1, d1$Year == 2001)
seTarsus2001 <- sqrt(var(d12001$Tarsus) / length(d12001$Tarsus))
seTarsus2001

# Clear workspace before simulation
rm(list=ls())

# Simulate data: 500 measurements of dragon tail lengths
# Mean = 3.8, standard deviation = 2
TailLength <- rnorm(500, mean=3.8, sd=2)

# Check the simulated data
summary(TailLength)
length(TailLength)
var(TailLength)
sd(TailLength)
hist(TailLength)

# Prepare plot showing mean ± SE with increasing sample size
x <- 1:length(TailLength)
y <- mean(TailLength) + 0*x  # Create a vector of the grand mean
plot(x, y, cex=0.03, ylim=c(2,5), xlim=c(0,500), 
     xlab="Sample size n", ylab="Mean of tail length ±SE (m)", col="red")

# Initialize vectors for means and standard errors
SE <- c(1)
mu <- c(1)

# For loop to calculate mean and SE for each sample size
for (n in 1:length(TailLength)) {
  d <- sample(TailLength, n, replace=FALSE)  # Randomly draw n samples
  mu[n] <- mean(TailLength)                  # Store the mean
  SE[n] <- sd(TailLength)/sqrt(n)            # Store the standard error
}

# Inspect first few values
head(SE)
head(mu)
length(SE)
length(mu)

# Plot standard error bars
up <- mu + SE
down <- mu - SE
x <- 1:length(SE)
segments(x, up, x1=x, y1=down, lty=1)

# Re-simulate smaller dataset: 201 samples
rm(list=ls())
TailLength <- rnorm(201, mean=3.8, sd=2)
length(TailLength)

# Prepare plot
x <- 1:201
y <- mean(TailLength) + 0*x
plot(x, y, cex=0.03, ylim=c(3,4.5), xlim=c(0,201), 
     xlab="Sample size n", ylab="Mean of tail length ±SE (m)", col="red")

# Specify sample size sequence
n <- seq(from=1, to=201, by=10)

# Initialize vectors for means and SEs
SE <- c(1)
mu <- c(1)

# Calculate mean and SE for each sample size
for (i in 1:length(n)) {
  d <- sample(TailLength, n[i], replace=FALSE)
  mu[i] <- mean(TailLength)
  SE[i] <- sd(TailLength)/sqrt(n[i])
}

# Plot the grand mean line, points, and SE bars
up <- mu + SE
down <- mu - SE
plot(x, y, cex=0.03, ylim=c(3,4.5), xlim=c(0,201), 
     xlab="Sample size n", ylab="Mean of tail length ±SE (m)", col="red")
points(n, mu, cex=0.3, col="red")
segments(n, up, x1=n, y1=down, lty=1)
