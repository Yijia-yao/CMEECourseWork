# ===== SwS05_complete.R =====


# Stats with Sparrows - 05

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

# Visualize female vs male body mass
boxplot(d$Mass ~ d$Sex.1, col = c("red", "blue"), ylab="Body mass (g)")

# Perform t-test comparing female and male body mass (full dataset)
t.test1 <- t.test(d$Mass ~ d$Sex.1)
t.test1
## Welch Two Sample t-test
## alternative hypothesis: true difference in means is not equal to 0
## 95% CI shows the range of the difference between male and female body mass

# Subset first 50 rows to see effect of smaller sample size
d1 <- as.data.frame(head(d, 50))
length(d1$Mass)  # confirm sample size

# Perform t-test on small sample
t.test2 <- t.test(d1$Mass ~ d1$Sex)
t.test2
## Likely non-significant due to smaller sample
## Demonstrates that sample size affects ability to detect differences

# Exercises (instructions only, code placeholders)
# 1) Compare wing length, Tarsus, Mass, and Bill between sexes and vs grand-total mean
# Example: t-test for wing length 2001
# d2001 <- subset(d, d$Year == 2001)
# t.test(d2001$Wing ~ d2001$Sex.1)

# 2) Batch tests for each year against grand-total mean (conceptual)
# Use a loop or apply function to iterate over years
# for (yr in unique(d$Year)) { ... }

# 3) Compare first 5 years vs last 6 years for multiple traits
# Create a grouping variable: Group1 = first 5 years, Group2 = last 6 years
# d$Group <- ifelse(d$Year %in% 2000:2004, "First5", "Last6")
# t.test(d$Tarsus ~ d$Group)
# t.test(d$Mass ~ d$Group)
# t.test(d$Wing ~ d$Group)
# t.test(d$Bill ~ d$Group)

# Notes:
# - Focus on effect size, not just p-value
# - Use 95% CI to interpret biological significance
# - Large datasets can detect tiny differences; small samples may fail to detect them
# - Practice creating grouping variables and using t.test in different ways
