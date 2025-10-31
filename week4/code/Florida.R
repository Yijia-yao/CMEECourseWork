# test whether the temperature in Florida rises over time (Permutation test)


rm(list = ls())
load("../data/KeyWestAnnualMeanTemperature.RData")
# Check data
ls()
class(ats)
head(ats)

plot(ats)

#Set parameters
args <- commandArgs(trailingOnly = TRUE)
nperm <- if (length(args) >= 1) as.integer(args[1]) else 10000
seed  <- if (length(args) >= 2) as.integer(args[2]) else 12345

r_obs <- cor(ats$Year, ats$Temp, method = "pearson")
r_obs

#permutation test
nperm <- 10000
r_perm <- numeric(nperm)
for (i in seq_len(nperm)) {
  r_perm[i] <- cor(ats$Year, sample(ats$Temp))
}


#p-alue
p_one_sided <- (sum(r_perm >= r_obs) + 1) / (nperm + 1)
p_two_sided <- (sum(abs(r_perm) >= abs(r_obs)) + 1) / (nperm + 1)

cat("One-sided p-value:", p_one_sided, "\n")
cat("Two-sided p-value:", p_two_sided, "\n")

output_dir <- "../results"
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

# plot and output PDF
# ---------------------------
output_pdf <- file.path(output_dir, "Florida_results.pdf")

pdf(output_pdf, width = 7, height = 8)

# Figure 1: Trend of Temperature changes
par(mfrow = c(2, 1), mar = c(4, 4, 3, 1))
plot(ats$Year, ats$Temp, type = "l", col = "steelblue", lwd = 2,
     xlab = "Year", ylab = "Mean Annual Temperature (°C)",
     main = "Key West Annual Mean Temperature (1901–2000)")
abline(lm(Temp ~ Year, data = ats), col = "darkred", lwd = 2)
legend("topleft", legend = sprintf("r = %.3f", r_obs), bty = "n")

# Figure 2: Distribution of Permutation Results
hist(r_perm, breaks = 40, col = "lightgray", border = "white",
     main = sprintf("Permutation Test (n = %d)", nperm),
     xlab = "Randomized Correlation Coefficients")
abline(v = r_obs, col = "red", lwd = 2)
legend("topright",
       legend = sprintf("Observed r = %.3f\nOne-sided p = %.4f", r_obs, p_one_sided),
       bty = "n")

dev.off()

png("../results/Florida_TempTrend.png", width = 800, height = 600)
plot(ats$Year, ats$Temp, type="l", main="Key West Annual Mean Temperature")
dev.off()

png("../results/Florida_PermutationDist.png", width = 800, height = 600)
hist(r_perm, main="Permutation Distribution", xlab="Correlation Coefficient")
abline(v = r_obs, col="red", lwd=2, lty=2)
dev.off()


