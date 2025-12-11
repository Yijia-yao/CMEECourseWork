# ===== SwS02_complete.R =====


# Stats with Sparrows - 02

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
head(d)
summary(d)
length(d$Tarsus)
hist(d$Tarsus)

# Inspect structure
str(d)
names(d)
head(d)

# Sample size
length(d$Tarsus)

# Histograms, mean, median, and mode
hist(d$Tarsus)

# Mean and median with NA removal
mean(d$Tarsus, na.rm = TRUE)
median(d$Tarsus, na.rm = TRUE)
mode(d$Tarsus)  # Returns the data type, not statistical mode

# Explore histogram with different bin sizes
par(mfrow = c(2, 2))
hist(d$Tarsus, breaks = 3, col = "grey")
hist(d$Tarsus, breaks = 10, col = "grey")
hist(d$Tarsus, breaks = 30, col = "grey")
hist(d$Tarsus, breaks = 100, col = "grey")

# Create rounded Tarsus column (1 decimal)
d$Tarsus.rounded <- round(d$Tarsus, digits = 1)
head(d$Tarsus.rounded)

# Load dplyr
require(dplyr)

# Count occurrences of rounded Tarsus
TarsusTally <- d %>% count(Tarsus.rounded, sort = TRUE)
TarsusTally

# Remove NA values
d2 <- subset(d, d$Tarsus != "NA")
length(d$Tarsus) - length(d2$Tarsus)

# Count again without NAs
TarsusTally <- d2 %>% count(Tarsus.rounded, sort = TRUE)
TarsusTally

# Access first column (values)
TarsusTally[[1]]

# Access second column (counts)
TarsusTally[[2]]

# Access first element of the first column (mode)
TarsusTally[[1]][1]

# Check mean, median, and mode again
mean(d$Tarsus, na.rm = TRUE)
median(d$Tarsus, na.rm = TRUE)
TarsusTally[[1]][1]  # mode

# Range, variance, standard deviation
range(d$Tarsus, na.rm = TRUE)
range(d2$Tarsus, na.rm = TRUE)
var(d$Tarsus, na.rm = TRUE)
var(d2$Tarsus, na.rm = TRUE)

# Manual calculation of variance
sum((d2$Tarsus - mean(d2$Tarsus))^2) / (length(d2$Tarsus) - 1)
var(d2$Tarsus)

# Standard deviation
sqrt(var(d2$Tarsus))
sd(d2$Tarsus)

# Z-scores
zTarsus <- (d2$Tarsus - mean(d2$Tarsus)) / sd(d2$Tarsus)
var(zTarsus)
sd(zTarsus)
hist(zTarsus)

# Generate standard normal distribution
znormal <- rnorm(1e6)
hist(znormal, breaks = 100)
summary(znormal)

# Quantiles and probabilities
qnorm(c(0.025, 0.975))
pnorm(.Last.value)

# Plot z-distribution
par(mfrow = c(1, 2))
hist(znormal, breaks = 100)
abline(v = qnorm(c(0.25, 0.5, 0.75)), lwd = 2)
abline(v = qnorm(c(0.025, 0.975)), lwd = 2, lty = "dashed")
plot(density(znormal))
abline(v = qnorm(c(0.25, 0.5, 0.75)), col = "gray")
abline(v = qnorm(c(0.025, 0.975)), lty = "dotted", col = "black")
abline(h = 0, lwd = 3, col = "blue")
text(2, 0.3, "1.96", col = "red", adj = 0)
text(-2, 0.3, "-1.96", col = "red", adj = 1)

# Boxplot by sex
boxplot(d$Tarsus ~ d$Sex.1, col = c("red", "blue"), ylab = "Tarsus length (mm)")
