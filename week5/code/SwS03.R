# ===== SwS03_complete.R =====


# Stats with Sparrows - 03

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

# Convert BirdID to factor (categorical)
d$BirdIDFact <- as.factor(d$BirdID)
str(d$BirdIDFact)

# Check mean of BirdID (integer) vs factor
mean(d$BirdID)        # meaningless
mean(d$BirdIDFact)    # returns NA

# Plot Mass by Year as factor (categorical)
plot(d$Mass ~ as.factor(d$Year), xlab="Year", ylab="House sparrow body mass(g)")

# Plot Mass by Year as numeric (continuous)
plot(d$Mass ~ d$Year, xlab="Year", ylab="House sparrow body mass(g)")

# Clear workspace before Blue tit data
rm(list=ls())

# Read blue tit dataset
b <- read.table("BTLD.txt", header=T)
str(b)

# Mean clutch size at 7 days
mean(b$ClutchsizeAge7, na.rm = TRUE)

# Plot laying date vs year (continuous variables)
plot(b$LD.in_AprilDays. ~ b$Year, ylab="Laying date (April days)", xlab="Year",
     pch=19, cex=0.3)

# Add jitter to year for better visualization
plot(b$LD.in_AprilDays. ~ jitter(b$Year), ylab="Laying date (April days)", xlab="Year",
     pch=19, cex=0.3)

# Violin plot using ggplot2
require(ggplot2)
p <- ggplot(b, aes(x=Year, y=LD.in_AprilDays.)) +
  geom_violin()
p


boxplot(b$LD.in_AprilDays.~b$Year, ylab="Laying date (April days)", xlab="Yea
r")

p <- ggplot(b, aes(x=as.factor(Year), y=LD.in_AprilDays.)) +
  geom_violin()
p

# Violin plot using Year as factor (categorical) + descriptive statistics
p <- ggplot(b, aes(x=as.factor(Year), y=LD.in_AprilDays.)) +
  geom_violin()
p + stat_summary(fun.data="mean_sdl", geom="pointrange")