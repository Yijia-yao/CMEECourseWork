# CMEE 2024 HPC exercises R code pro forma
# For stochastic demographic model cluster run

rm(list = ls())

# Load model + your helper initialisation functions
source("Code/Demographic.R")
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

set.seed(10000 + iter)

# -------- Model parameters (same as main.R Q1/Q2) --------
growth_matrix <- matrix(c(0.1, 0.0, 0.0, 0.0,
                          0.5, 0.4, 0.0, 0.0,
                          0.0, 0.4, 0.7, 0.0,
                          0.0, 0.0, 0.25, 0.4),
                        nrow = 4, ncol = 4, byrow = TRUE)

reproduction_matrix <- matrix(c(0.0, 0.0, 0.0, 2.6,
                                0.0, 0.0, 0.0, 0.0,
                                0.0, 0.0, 0.0, 0.0,
                                0.0, 0.0, 0.0, 0.0),
                              nrow = 4, ncol = 4, byrow = TRUE)

clutch_distribution <- c(0.06,0.08,0.13,0.15,0.16,0.18,0.15,0.06,0.03)

simulation_length <- 24
n_sims_per_job <- 150   # typical for this worksheet; adjust if your handout specifies differently

# -------- Initial condition mapping (matches your main.R Q5/Q6 assumptions) --------
# 1-25: adults, large (100)
# 26-50: adults, small (10)
# 51-75: mixed/spread, large (100)
# 76-100: mixed/spread, small (10)
if (iter >= 1 && iter <= 25) {
  initial_state <- state_initialise_adult(num_stages = 4, initial_size = 100)
} else if (iter >= 26 && iter <= 50) {
  initial_state <- state_initialise_adult(num_stages = 4, initial_size = 10)
} else if (iter >= 51 && iter <= 75) {
  initial_state <- state_initialise_spread(num_stages = 4, initial_size = 100)
} else {
  initial_state <- state_initialise_spread(num_stages = 4, initial_size = 10)
}

# -------- Run stochastic sims and save --------
results <- vector("list", n_sims_per_job)
for (k in seq_len(n_sims_per_job)) {
  results[[k]] <- stochastic_simulation(
    initial_state = initial_state,
    growth_matrix = growth_matrix,
    reproduction_matrix = reproduction_matrix,
    clutch_distribution = clutch_distribution,
    simulation_length = simulation_length
  )
}

if(!dir.exists("Data")) dir.create("Data", recursive = TRUE)

output_file <- file.path("Data", sprintf("demographic_%03d.rda", iter))
save(results, iter, n_sims_per_job, simulation_length,
     growth_matrix, reproduction_matrix, clutch_distribution,
     file = output_file)
