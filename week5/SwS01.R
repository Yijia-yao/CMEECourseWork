# ===== SwS01_complete.R =====


# Stats with Sparrows - 01

# -----------------------------
# Clear the environment & set the directory
# -----------------------------
rm(list=ls()) 
getwd()      
setwd("D:/Users/lenovo/Desktop/Statistic in R/Week5/data")
getwd()      


# Basic operations and variables
x <- 5
y <- 2
x2 <- x^2
a <- x2 + x
z <- sqrt(x2 + y^2)
# logical judgment
3 > 2
4 < 2


# Create a vector
myNumericVector <- c(1.3,2.5,1.9,3.4,5.6,1.4,3.1,2.9)
myCharacterVector <- c("low","low","high","high")
myLogicalVector <- c(TRUE,FALSE,TRUE,FALSE)
str(myNumericVector)


# reading data
d <- read.table("SparrowSize.txt", header = TRUE)
str(d)
head(d)
summary(d)


# Understanding of Data Structure
# Number of captures per year
table(d$Year)
# Number of captures per bird
table(table(d$BirdID))


# Simplify Statistics with dplyr
library(dplyr)
BirdIDCount <- d %>% count(BirdID, BirdID, sort = TRUE)
BirdIDCount %>% count(n)


# Save the workspace
save.image("SwS01.RData")
