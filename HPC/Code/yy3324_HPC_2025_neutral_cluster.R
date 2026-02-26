# CMEE 2024 HPC exercises R code pro forma
# For neutral model cluster run

rm(list = ls())

source("Code/yy3324_HPC_2025_main.R")

# -------- PBS array index (1..100) --------
iter <- Sys.getenv("PBS_ARRAY_INDEX")
if (iter == "") {
  # allow local test
  iter <- "1"
}
iter <- as.integer(iter)

if (is.na(iter) || iter < 1 || iter > 100) {
  stop("PBS_ARRAY_INDEX must be an integer in 1..100 (or set it for local testing).")
}

set.seed(20000 + iter)

# -------- Map iter to community size (matches your main.R Q26 assumptions) --------
# 1-25: 500
# 26-50: 1000
# 51-75: 2500
# 76-100: 5000
size <- if (iter <= 25) {
  500
} else if (iter <= 50) {
  1000
} else if (iter <= 75) {
  2500
} else {
  5000
}

# -------- Parameters (choose values consistent with the worksheet style) --------
speciation_rate <- 0.1
wall_time_minutes <- 11.5 * 60       # Set slightly below PBS walltime (12h) so jobs terminate cleanly and save results before scheduler kill
interval_rich <- 1                   # record richness each generation during burn-in
interval_oct <- 20                   # record octave every 20 generations
burn_in_generations <- 2000          # burn-in period (adjust if your handout specifies different)

if(!dir.exists("Data")) dir.create("Data", recursive = TRUE)
output_file_name <- file.path("Data", sprintf("neutral_%03d.rda", iter))

neutral_cluster_run(
  speciation_rate = speciation_rate,
  size = size,
  wall_time = wall_time_minutes,
  interval_rich = interval_rich,
  interval_oct = interval_oct,
  burn_in_generations = burn_in_generations,
  output_file_name = output_file
)
