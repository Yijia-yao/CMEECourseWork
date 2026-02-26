# CMEE 2024 HPC exercises R code main pro forma
# You don't HAVE to use this but it will be very helpful.
# If you opt to write everything yourself from scratch please ensure you use
# EXACTLY the same function and parameter names and beware that you may lose
# marks if it doesn't work properly because of not using the pro-forma.

name <- "Yijia Yao"
preferred_name <- "Yijia"
email <- "yy3324@imperial.ac.uk"
username <- "yy3324"

# Please remember *not* to clear the work space here, or anywhere in this file.
# If you do, it'll wipe out your username information that you entered just
# above, and when you use this file as a 'toolbox' as intended it'll also wipe
# away everything you're doing outside of the toolbox.  For example, it would
# wipe away any automarking code that may be running and that would be annoying!

# Small utilities (safe)

.ensure_dir <- function(path) {
  if (!dir.exists(path)) dir.create(path, recursive = TRUE)
}

.save_png <- function(filename, width = 600, height = 400) {
  .ensure_dir("Results")
  png(filename = file.path("Results", paste0(filename, ".png")),
      width = width, height = height)
}

.extract_iter_from_filename <- function(path){
  base <- basename(path)
  m <- regmatches(base, regexpr("[0-9]+(?=\\.rda$)", base, perl=TRUE))
  if(length(m) == 0) return(NA_integer_)
  out <- suppressWarnings(as.integer(m))
  if(length(out) == 0 || is.na(out)) return(NA_integer_)
  out
}

# Section One: Stochastic demographic population model


# Question 0
state_initialise_adult <- function(num_stages, initial_size){
  # all individuals in final (adult) stage
  state <- rep(0, num_stages)
  state[num_stages] <- initial_size
  return(state)
}

state_initialise_spread <- function(num_stages, initial_size){
  # spread as evenly as possible, remainder goes to youngest first
  base <- floor(initial_size / num_stages)
  rem <- initial_size - base * num_stages
  state <- rep(base, num_stages)
  if(rem > 0){
    state[1:rem] <- state[1:rem] + 1
  }
  return(state)
}

# Question 1
question_1 <- function(){
  # load deterministic_simulation etc.
  source("Code/Demographic.R")

  growth_matrix <- matrix(c(0.1, 0.0, 0.0, 0.0,
                            0.5, 0.4, 0.0, 0.0,
                            0.0, 0.4, 0.7, 0.0,
                            0.0, 0.0, 0.25, 0.4),
                          nrow=4, ncol=4, byrow=TRUE)

  reproduction_matrix <- matrix(c(0.0, 0.0, 0.0, 2.6,
                                  0.0, 0.0, 0.0, 0.0,
                                  0.0, 0.0, 0.0, 0.0,
                                  0.0, 0.0, 0.0, 0.0),
                                nrow=4, ncol=4, byrow=TRUE)

  projection_matrix <- growth_matrix + reproduction_matrix

  initial_adults <- state_initialise_adult(num_stages=4, initial_size=100)
  initial_spread <- state_initialise_spread(num_stages=4, initial_size=100)

  sim_len <- 24
  ts_adults <- deterministic_simulation(initial_state=initial_adults,
                                        simulation_length=sim_len,
                                        projection_matrix=projection_matrix)
  ts_spread <- deterministic_simulation(initial_state=initial_spread,
                                        simulation_length=sim_len,
                                        projection_matrix=projection_matrix)

  .save_png("question_1", width = 600, height = 400)
  plot(0:sim_len, ts_adults, type="l", xlab="Time step", ylab="Population size",
       main="Deterministic population size: different initial conditions")
  lines(0:sim_len, ts_spread, lty=2)
  legend("topleft",
         legend=c("100 adults (all in final stage)", "100 spread across stages"),
         lty=c(1,2), bty="n")
  Sys.sleep(0.1)
  dev.off()

  return(paste(
    "The initial life-stage distribution changes early growth because reproduction and survival",
    "depend on stage. Starting with all adults produces immediate recruitment and can give faster",
    "initial increase, while a spread population may have fewer adults at time 0 so initial growth",
    "can be slower. However, as the deterministic system approaches its stable stage distribution,",
    "both trajectories converge to the same long-term growth pattern (same asymptotic rate), with",
    "differences mainly in the transient phase."
  ))
}

# Question 2
question_2 <- function(){
  source("Code/Demographic.R")

  growth_matrix <- matrix(c(0.1, 0.0, 0.0, 0.0,
                            0.5, 0.4, 0.0, 0.0,
                            0.0, 0.4, 0.7, 0.0,
                            0.0, 0.0, 0.25, 0.4),
                          nrow=4, ncol=4, byrow=TRUE)

  reproduction_matrix <- matrix(c(0.0, 0.0, 0.0, 2.6,
                                  0.0, 0.0, 0.0, 0.0,
                                  0.0, 0.0, 0.0, 0.0,
                                  0.0, 0.0, 0.0, 0.0),
                                nrow=4, ncol=4, byrow=TRUE)

  clutch_distribution <- c(0.06,0.08,0.13,0.15,0.16,0.18,0.15,0.06,0.03)

  initial_adults <- state_initialise_adult(num_stages=4, initial_size=100)
  initial_spread <- state_initialise_spread(num_stages=4, initial_size=100)

  sim_len <- 24
  ts_adults <- stochastic_simulation(initial_state=initial_adults,
                                     growth_matrix=growth_matrix,
                                     reproduction_matrix=reproduction_matrix,
                                     clutch_distribution=clutch_distribution,
                                     simulation_length=sim_len)

  ts_spread <- stochastic_simulation(initial_state=initial_spread,
                                     growth_matrix=growth_matrix,
                                     reproduction_matrix=reproduction_matrix,
                                     clutch_distribution=clutch_distribution,
                                     simulation_length=sim_len)

  .save_png("question_2", width = 600, height = 400)
  plot(0:sim_len, ts_adults, type="l", xlab="Time step", ylab="Population size",
       main="Stochastic population size: different initial conditions")
  lines(0:sim_len, ts_spread, lty=2)
  legend("topleft",
         legend=c("100 adults (all in final stage)", "100 spread across stages"),
         lty=c(1,2), bty="n")
  Sys.sleep(0.1)
  dev.off()

  return(paste(
    "The deterministic simulations are smooth because they use expected (average) transitions and",
    "reproduction each time step. The stochastic simulations are jagged and can fluctuate because",
    "births, deaths, and stage transitions are drawn randomly each step, so demographic stochasticity",
    "creates variance around the mean trend (especially noticeable at smaller effective numbers)."
  ))
}

# Questions 3 and 4 involve writing code elsewhere to run your simulations on the cluster

# Question 5
question_5 <- function(){

  if(!dir.exists("Results")) dir.create("Results", recursive = TRUE)

  files <- list.files("Data", pattern="^demographic_[0-9]+\\.rda$", full.names=TRUE)
  if(length(files) == 0){
    stop("question_5: No demographic_###.rda files found in Data/.")
  }

  ic_label <- function(iter){
    if(iter >= 1 && iter <= 25) return("adults, large (100)")
    if(iter >= 26 && iter <= 50) return("adults, small (10)")
    if(iter >= 51 && iter <= 75) return("mixed, large (100)")
    if(iter >= 76 && iter <= 100) return("mixed, small (10)")
    return(NA_character_)
  }

  get_iter <- function(path){
    base <- basename(path)
    m <- regmatches(base, regexpr("[0-9]+(?=\\.rda$)", base, perl=TRUE))
    if(length(m) == 0) return(NA_integer_)
    as.integer(m)
  }

  extinct_counts <- c("adults, large (100)"=0,
                      "adults, small (10)"=0,
                      "mixed, large (100)"=0,
                      "mixed, small (10)"=0)

  total_counts <- c("adults, large (100)"=0,
                    "adults, small (10)"=0,
                    "mixed, large (100)"=0,
                    "mixed, small (10)"=0)

  for(f in files){
    iter <- get_iter(f)
    if(is.na(iter)) next

    lbl <- ic_label(iter)
    if(is.na(lbl)) next

    e <- new.env()
    load(f, envir=e)

    if(!exists("results", envir=e)){
      stop(paste("question_5: Expected object 'results' not found in", basename(f)))
    }
    res <- get("results", envir=e)

    finals <- vapply(res, function(ts) ts[length(ts)], numeric(1))
    extinct <- sum(finals == 0)

    extinct_counts[lbl] <- extinct_counts[lbl] + extinct
    total_counts[lbl] <- total_counts[lbl] + length(res)
  }

  prop_extinct <- extinct_counts / total_counts

  png(filename="Results/question_5.png", width = 600, height = 400)
  barplot(prop_extinct,
          ylim=c(0, max(prop_extinct, na.rm=TRUE) * 1.1),
          ylab="Proportion extinct",
          main="Extinction probability by initial condition")
  Sys.sleep(0.1)
  dev.off()

  worst <- names(which.max(prop_extinct))

  return(paste(
    "The population most likely to go extinct was:", worst, ".",
    "Smaller initial populations are more extinction-prone because demographic stochasticity causes",
    "larger relative fluctuations and can drive the population to zero before it builds up, whereas",
    "larger starting sizes buffer random variation and reduce extinction risk."
  ))
}

# Question 6
question_6 <- function(){

  if(!dir.exists("Results")) dir.create("Results", recursive = TRUE)

  source("Code/Demographic.R")

  growth_matrix <- matrix(c(0.1, 0.0, 0.0, 0.0,
                            0.5, 0.4, 0.0, 0.0,
                            0.0, 0.4, 0.7, 0.0,
                            0.0, 0.0, 0.25, 0.4),
                          nrow=4, ncol=4, byrow=TRUE)

  reproduction_matrix <- matrix(c(0.0, 0.0, 0.0, 2.6,
                                  0.0, 0.0, 0.0, 0.0,
                                  0.0, 0.0, 0.0, 0.0,
                                  0.0, 0.0, 0.0, 0.0),
                                nrow=4, ncol=4, byrow=TRUE)

  projection_matrix <- growth_matrix + reproduction_matrix

  files <- list.files("Data", pattern="^demographic_[0-9]+\\.rda$", full.names=TRUE)
  if(length(files) == 0){
    stop("question_6: No demographic_###.rda files found in Data/.")
  }

  get_iter <- function(path){
    base <- basename(path)
    m <- regmatches(base, regexpr("[0-9]+(?=\\.rda$)", base, perl=TRUE))
    if(length(m) == 0) return(NA_integer_)
    as.integer(m)
  }

  load_condition <- function(iter_min, iter_max){
    all_ts <- list()
    for(f in files){
      iter <- get_iter(f)
      if(is.na(iter) || iter < iter_min || iter > iter_max) next
      e <- new.env()
      load(f, envir=e)

      if(!exists("results", envir=e)){
        stop(paste("question_6: Expected object 'results' not found in", basename(f)))
      }
      res <- get("results", envir=e)
      all_ts <- c(all_ts, res)
    }
    all_ts
  }

  ts_large_mixed <- load_condition(51, 75)
  ts_small_mixed <- load_condition(76, 100)

  if(length(ts_large_mixed) == 0 || length(ts_small_mixed) == 0){
    stop("question_6: Missing demographic results for initial conditions 3 and/or 4.")
  }

  mean_ts <- function(lst){
    n <- length(lst)
    L <- length(lst[[1]])
    acc <- rep(0, L)
    for(i in seq_len(n)){
      acc <- acc + lst[[i]]
    }
    acc / n
  }

  mean_large <- mean_ts(ts_large_mixed)
  mean_small <- mean_ts(ts_small_mixed)

  sim_len <- length(mean_large) - 1

  det_large <- deterministic_simulation(
    initial_state=state_initialise_spread(4, 100),
    simulation_length=sim_len,
    projection_matrix=projection_matrix
  )
  det_small <- deterministic_simulation(
    initial_state=state_initialise_spread(4, 10),
    simulation_length=sim_len,
    projection_matrix=projection_matrix
  )

  dev_large <- mean_large / det_large
  dev_small <- mean_small / det_small

  png(filename="Results/question_6.png", width = 600, height = 400)
  plot(0:sim_len, dev_large, type="l",
       ylim=range(c(dev_large, dev_small), finite=TRUE),
       xlab="Time step", ylab="Stochastic mean / deterministic",
       main="Deviation of stochastic mean from deterministic model")
  lines(0:sim_len, dev_small, lty=2)
  abline(h=1, lty=3)
  legend("topright",
         legend=c("Mixed, large (100)", "Mixed, small (10)", "Ratio = 1"),
         lty=c(1,2,3), bty="n")
  Sys.sleep(0.1)
  dev.off()

  return(paste(
    "It is more appropriate to approximate the average stochastic behaviour with a deterministic model",
    "for the large mixed population (initial condition 3). With more individuals, demographic stochasticity",
    "averages out so the mean trajectory stays closer to deterministic expectations. For the small mixed",
    "population, random fluctuations and extinctions cause larger deviations."
  ))
}

# Section Two: Individual-based ecological neutral theory simulation


# Question 7
species_richness <- function(community){
  return(length(unique(community)))
}

# Question 8
init_community_max <- function(size){
  return(seq(1, size))
}

# Question 9
init_community_min <- function(size){
  return(rep(1, size))
}

# Question 10
choose_two <- function(max_value){
  return(sample(1:max_value, size=2, replace=FALSE))
}

# Question 11
neutral_step <- function(community){
  idx <- choose_two(length(community))
  dead <- idx[1]
  repro <- idx[2]
  community[dead] <- community[repro]
  return(community)
}

# Question 12
neutral_generation <- function(community){
  x <- length(community)
  steps_exact <- x / 2
  if(steps_exact == floor(steps_exact)){
    n_steps <- steps_exact
  } else {
    n_steps <- sample(c(floor(steps_exact), ceiling(steps_exact)), size=1)
  }
  n_steps <- as.integer(n_steps)

  for(i in seq_len(n_steps)){
    community <- neutral_step(community)
  }
  return(community)
}

# Question 13
neutral_time_series <- function(community, duration){
  out <- numeric(duration + 1)
  out[1] <- species_richness(community)
  if(duration > 0){
    for(t in 1:duration){
      community <- neutral_generation(community)
      out[t+1] <- species_richness(community)
    }
  }
  return(out)
}

# Question 14
question_14 <- function() {
  comm <- init_community_max(100)
  ts <- neutral_time_series(community=comm, duration=200)

  .save_png("question_14", width = 600, height = 400)
  plot(0:200, ts, type="l", xlab="Generation", ylab="Species richness",
       main="Neutral model (no speciation): richness over time")
  Sys.sleep(0.1)
  dev.off()

  return(paste(
    "Without speciation, the system will always converge to monodominance (species richness = 1)",
    "if you wait long enough. This is because the model has only drift: random replacement events",
    "eventually eliminate species one by one, and with no mechanism to create new species, one lineage",
    "ultimately fixes."
  ))
}

# Question 15
neutral_step_speciation <- function(community, speciation_rate)  {
  idx <- choose_two(length(community))
  dead <- idx[1]
  repro <- idx[2]

  if(runif(1) < speciation_rate){
    new_id <- max(community) + 1
    community[dead] <- new_id
  } else {
    community[dead] <- community[repro]
  }
  return(community)
}

# Question 16
neutral_generation_speciation <- function(community, speciation_rate)  {
  x <- length(community)
  steps_exact <- x / 2
  if(steps_exact == floor(steps_exact)){
    n_steps <- steps_exact
  } else {
    n_steps <- sample(c(floor(steps_exact), ceiling(steps_exact)), size=1)
  }
  n_steps <- as.integer(n_steps)

  for(i in seq_len(n_steps)){
    community <- neutral_step_speciation(community, speciation_rate)
  }
  return(community)
}

# Question 17
neutral_time_series_speciation <- function(community, speciation_rate, duration)  {
  out <- numeric(duration + 1)
  out[1] <- species_richness(community)
  if(duration > 0){
    for(t in 1:duration){
      community <- neutral_generation_speciation(community, speciation_rate)
      out[t+1] <- species_richness(community)
    }
  }
  return(out)
}

# Question 18
question_18 <- function()  {
  size <- 100
  duration <- 200
  v <- 0.1

  ts_max <- neutral_time_series_speciation(init_community_max(size), v, duration)
  ts_min <- neutral_time_series_speciation(init_community_min(size), v, duration)

  .save_png("question_18", width = 600, height = 400)
  plot(0:duration, ts_max, type="l", xlab="Generation", ylab="Species richness",
       main="Neutral model with speciation (v=0.1): effect of initial condition")
  lines(0:duration, ts_min, lty=2)
  legend("bottomright",
         legend=c("init_community_max(100)", "init_community_min(100)"),
         lty=c(1,2), bty="n")
  Sys.sleep(0.1)
  dev.off()

  return(paste(
    "The initial condition affects the early trajectory (starting diverse begins with high richness,",
    "starting monodominant begins low), but over time both tend toward a similar dynamic equilibrium",
    "range of richness. With speciation, new species continually enter while drift eliminates others,",
    "so the system has a balance between creation and loss that reduces long-term dependence on the",
    "starting state (though finite-time differences can persist)."
  ))
}

# Question 19
species_abundance <- function(community)  {
  tab <- table(community)
  abund <- as.numeric(tab)
  abund <- sort(abund, decreasing=TRUE)
  return(abund)
}

# Question 20
octaves <- function(abundance_vector) {
  if(length(abundance_vector) == 0) return(numeric(0))
  classes <- floor(log(abundance_vector, base=2)) + 1
  out <- tabulate(classes)
  return(out)
}

# Question 21
sum_vect <- function(x, y) {
  lx <- length(x); ly <- length(y)
  if(lx < ly) x <- c(x, rep(0, ly - lx))
  if(ly < lx) y <- c(y, rep(0, lx - ly))
  return(x + y)
}

# Question 22
question_22 <- function() {
  size <- 100
  v <- 0.1
  burn_in <- 200
  after <- 2000
  interval <- 20

  run_collect <- function(init_comm){
    comm <- init_comm

    for(g in 1:burn_in){
      comm <- neutral_generation_speciation(comm, v)
    }

    records <- list()
    records[[1]] <- octaves(species_abundance(comm))

    n_records <- floor(after / interval)
    for(k in 1:n_records){
      for(j in 1:interval){
        comm <- neutral_generation_speciation(comm, v)
      }
      records[[k+1]] <- octaves(species_abundance(comm))
    }

    acc <- numeric(0)
    for(r in records){
      acc <- sum_vect(acc, r)
    }
    mean_oct <- acc / length(records)
    return(mean_oct)
  }

  mean_oct_max <- run_collect(init_community_max(size))
  mean_oct_min <- run_collect(init_community_min(size))

  L <- max(length(mean_oct_max), length(mean_oct_min))
  if(length(mean_oct_max) < L) mean_oct_max <- c(mean_oct_max, rep(0, L - length(mean_oct_max)))
  if(length(mean_oct_min) < L) mean_oct_min <- c(mean_oct_min, rep(0, L - length(mean_oct_min)))

  .save_png("question_22", width = 600, height = 400)
  par(mfrow=c(1,2), mar=c(4,4,3,1))

  barplot(mean_oct_max, xlab="Octave class", ylab="Mean # species",
          main="Init: max diversity (after burn-in)")
  barplot(mean_oct_min, xlab="Octave class", ylab="Mean # species",
          main="Init: min diversity (after burn-in)")

  Sys.sleep(0.1)
  dev.off()

  return(paste(
    "After a sufficient burn-in, the initial condition matters little for the mean species-abundance",
    "distribution: both initial states approach the same dynamic equilibrium because drift and speciation",
    "continuously reshuffle abundances. Any differences are mainly transient and disappear when the",
    "system has mixed for long enough."
  ))
}

# Question 23
neutral_cluster_run <- function(speciation_rate, size, wall_time, interval_rich, interval_oct,
                                burn_in_generations, output_file_name) {

  community <- init_community_min(size)

  time_series <- numeric(0)        # richness during burn-in only
  abundance_list <- list()         # octave vectors across whole run

  start_time <- proc.time()[["elapsed"]]
  gen <- 0

  repeat {
    elapsed_min <- (proc.time()[["elapsed"]] - start_time) / 60
    if(elapsed_min >= wall_time) break

    gen <- gen + 1
    community <- neutral_generation_speciation(community, speciation_rate)

    if(gen <= burn_in_generations){
      if(gen %% interval_rich == 0){
        time_series <- c(time_series, species_richness(community))
      }
    }

    if(gen %% interval_oct == 0){
      abundance_list[[length(abundance_list) + 1]] <- octaves(species_abundance(community))
    }
  }

  total_time <- (proc.time()[["elapsed"]] - start_time) / 60

  save(time_series, abundance_list, community, total_time,
       speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations,
       file=output_file_name)

  invisible(NULL)
}

# Questions 24 and 25 involve writing code elsewhere to run your simulations on the cluster

# Question 26 
process_neutral_cluster_results <- function() {

  # helper: safe vector add with padding
  sum_vect_local <- function(x, y) {
    lx <- length(x); ly <- length(y)
    if(lx < ly) x <- c(x, rep(0, ly - lx))
    if(ly < lx) y <- c(y, rep(0, lx - ly))
    x + y
  }

  # ONLY read neutral cluster outputs from Data/
  files <- list.files("Data", pattern="^neutral_[0-9]+\\.rda$", full.names=TRUE)
  if(length(files) == 0){
    stop("process_neutral_cluster_results: No neutral_###.rda files found in Data/.")
  }

  get_iter <- function(path){
    base <- basename(path)
    m <- regmatches(base, regexpr("[0-9]+(?=\\.rda$)", base, perl=TRUE))
    if(length(m) != 1) return(NA_integer_)
    suppressWarnings(as.integer(m))
  }

  iter_to_size <- function(iter){
    if(iter >= 1 && iter <= 25) return(500)
    if(iter >= 26 && iter <= 50) return(1000)
    if(iter >= 51 && iter <= 75) return(2500)
    if(iter >= 76 && iter <= 100) return(5000)
    NA_integer_
  }

  # accumulate sums and counts for each size
  sums <- list("500"=numeric(0), "1000"=numeric(0), "2500"=numeric(0), "5000"=numeric(0))
  counts <- list("500"=0L, "1000"=0L, "2500"=0L, "5000"=0L)

  for(f in files){
    iter <- get_iter(f)
    if(is.na(iter)) next

    sz <- iter_to_size(iter)
    if(is.na(sz)) next
    key <- as.character(sz)

    e <- new.env()
    load(f, envir=e)

    # expected from neutral_cluster_run()
    if(!exists("abundance_list", envir=e) ||
       !exists("burn_in_generations", envir=e) ||
       !exists("interval_oct", envir=e)){
      # skip malformed outputs
      next
    }

    abundance_list <- get("abundance_list", envir=e)
    burn_in_generations <- get("burn_in_generations", envir=e)
    interval_oct <- get("interval_oct", envir=e)

    if(length(abundance_list) == 0) next

    # Each record corresponds to generation k*interval_oct.
    gens <- seq_len(length(abundance_list)) * interval_oct
    keep <- which(gens > burn_in_generations)
    if(length(keep) == 0) next

    for(i in keep){
      sums[[key]] <- sum_vect_local(sums[[key]], abundance_list[[i]])
      counts[[key]] <- counts[[key]] + 1L
    }
  }

  combined_results <- list(
    `500`  = if(counts[["500"]]  > 0) sums[["500"]]  / counts[["500"]]  else numeric(0),
    `1000` = if(counts[["1000"]] > 0) sums[["1000"]] / counts[["1000"]] else numeric(0),
    `2500` = if(counts[["2500"]] > 0) sums[["2500"]] / counts[["2500"]] else numeric(0),
    `5000` = if(counts[["5000"]] > 0) sums[["5000"]] / counts[["5000"]] else numeric(0)
  )

  # Save results to an .rda file (in Data so inputs+processed outputs stay together)
  save(combined_results, file="Data/neutral_cluster_combined_results.rda")

  return(combined_results)
}

plot_neutral_cluster_results <- function(){

  if(!dir.exists("Results")) dir.create("Results", recursive = TRUE)

  # load combined_results from your rda file
  if(!file.exists("Data/neutral_cluster_combined_results.rda")){
    stop("plot_neutral_cluster_results: Data/neutral_cluster_combined_results.rda not found. Run process_neutral_cluster_results() first.")
  }
  load("Data/neutral_cluster_combined_results.rda")  # loads combined_results

  # ensure each vector exists
  if(!exists("combined_results")) stop("plot_neutral_cluster_results: combined_results not loaded correctly.")

  png(filename="Results/plot_neutral_cluster_results.png", width = 600, height = 400)
  par(mfrow=c(2,2), mar=c(4,4,3,1))

  barplot(combined_results[["500"]],  main="Size = 500",  xlab="Octave class", ylab="Mean # species")
  barplot(combined_results[["1000"]], main="Size = 1000", xlab="Octave class", ylab="Mean # species")
  barplot(combined_results[["2500"]], main="Size = 2500", xlab="Octave class", ylab="Mean # species")
  barplot(combined_results[["5000"]], main="Size = 5000", xlab="Octave class", ylab="Mean # species")

  Sys.sleep(0.1)
  dev.off()

  return(combined_results)
}

# Challenge questions

# Challenge question A
Challenge_A <- function(){

  if(!dir.exists("Results")) dir.create("Results", recursive = TRUE)

  files <- list.files("Data", pattern="^demographic_[0-9]+\\.rda$", full.names=TRUE)
  if(length(files) == 0){
    stop("Challenge_A: No demographic_###.rda files found in Data/.")
  }

  ic_label <- function(iter){
    if(iter >= 1 && iter <= 25) return("large adult")
    if(iter >= 26 && iter <= 50) return("small adult")
    if(iter >= 51 && iter <= 75) return("large mixed")
    if(iter >= 76 && iter <= 100) return("small mixed")
    return(NA_character_)
  }

  get_iter <- function(path){
    base <- basename(path)
    m <- regmatches(base, regexpr("[0-9]+(?=\\.rda$)", base, perl=TRUE))
    if(length(m) == 0) return(NA_integer_)
    as.integer(m)
  }

  rows_list <- list()
  sim_counter <- 0L

  for(f in files){
    iter <- get_iter(f)
    if(is.na(iter)) next
    ic <- ic_label(iter)
    if(is.na(ic)) next

    e <- new.env()
    load(f, envir=e)

    if(!exists("results", envir=e)){
      stop(paste("Challenge_A: Expected object 'results' not found in", basename(f)))
    }
    res <- get("results", envir=e)

    for(k in seq_along(res)){
      sim_counter <- sim_counter + 1L
      ts <- res[[k]]
      df_k <- data.frame(
        simulation_number = sim_counter,
        initial_condition = ic,
        time_step = 0:(length(ts)-1),
        population_size = ts
      )
      rows_list[[length(rows_list)+1]] <- df_k
    }
  }

  population_size_df <- do.call(rbind, rows_list)

  if(!requireNamespace("ggplot2", quietly = TRUE)){
    stop("Challenge_A requires ggplot2. Please install it locally: install.packages('ggplot2').")
  }

  gg <- ggplot2::ggplot(
    population_size_df,
    ggplot2::aes(x=time_step, y=population_size, group=simulation_number, colour=initial_condition)
  ) +
    ggplot2::geom_line(alpha=0.08) +
    ggplot2::labs(
      title="All demographic stochastic simulations (cluster outputs)",
      x="Time step", y="Population size", colour="Initial condition"
    )

  png(filename="Results/Challenge_A.png", width = 600, height = 400)
  print(gg)
  Sys.sleep(0.1)
  dev.off()

  return(population_size_df)
}

# Challenge question B

Challenge_B <- function() {

  if(!dir.exists("Data")) dir.create("Data", recursive = TRUE)
  if(!dir.exists("Results")) dir.create("Results", recursive = TRUE)

  cache_file <- file.path("Data", "Challenge_B_cache.rda")

  size <- 100
  v <- 0.1
  burn_in <- 200
  after <- 2000
  duration <- burn_in + after
  n_reps <- 200

  if(file.exists(cache_file)){
    load(cache_file)  # loads: ts_mean_max, ts_low_max, ts_high_max, ts_mean_min, ts_low_min, ts_high_min, eq_gen
  } else {

    run_one <- function(init_comm){
      comm <- init_comm
      out <- numeric(duration + 1)
      out[1] <- species_richness(comm)
      for(g in 1:duration){
        comm <- neutral_generation_speciation(comm, v)
        out[g+1] <- species_richness(comm)
      }
      out
    }

    mat_max <- matrix(NA_real_, nrow=n_reps, ncol=duration+1)
    mat_min <- matrix(NA_real_, nrow=n_reps, ncol=duration+1)

    for(r in 1:n_reps){
      mat_max[r,] <- run_one(init_community_max(size))
      mat_min[r,] <- run_one(init_community_min(size))
    }

    mean_ci <- function(mat){
      m <- colMeans(mat)
      s <- apply(mat, 2, sd)
      se <- s / sqrt(nrow(mat))
      z <- 2.2
      list(mean=m, low=m - z*se, high=m + z*se, sd=s)
    }

    ci_max <- mean_ci(mat_max)
    ci_min <- mean_ci(mat_min)

    ts_mean_max <- ci_max$mean; ts_low_max <- ci_max$low; ts_high_max <- ci_max$high
    ts_mean_min <- ci_min$mean; ts_low_min <- ci_min$low; ts_high_min <- ci_min$high

    tail_window <- 200
    tail_stats <- function(ts){
      tail_seg <- ts[(length(ts)-tail_window+1):length(ts)]
      list(mean=mean(tail_seg), sd=sd(tail_seg))
    }

    find_entry_time <- function(ts, tail_mean, tail_sd){
      band <- max(2, 2 * tail_sd)
      lower <- tail_mean - band
      upper <- tail_mean + band
      inside <- (ts >= lower) & (ts <= upper)
      for(g in 1:length(ts)){
        if(all(inside[g:length(ts)])) return(g - 1)
      }
      NA_integer_
    }

    st_max <- tail_stats(ts_mean_max)
    st_min <- tail_stats(ts_mean_min)

    eq_max <- find_entry_time(ts_mean_max, st_max$mean, st_max$sd)
    eq_min <- find_entry_time(ts_mean_min, st_min$mean, st_min$sd)

    if(is.na(eq_max) || is.na(eq_min)){
      find_entry_consecutive <- function(ts, tail_mean, tail_sd){
        band <- max(2, 2 * tail_sd)
        lower <- tail_mean - band
        upper <- tail_mean + band
        inside <- (ts >= lower) & (ts <= upper)
        win <- 200
        for(g in 1:(length(ts)-win+1)){
          if(all(inside[g:(g+win-1)])) return(g - 1)
        }
        NA_integer_
      }
      if(is.na(eq_max)) eq_max <- find_entry_consecutive(ts_mean_max, st_max$mean, st_max$sd)
      if(is.na(eq_min)) eq_min <- find_entry_consecutive(ts_mean_min, st_min$mean, st_min$sd)
    }

    if(all(is.na(c(eq_max, eq_min)))){
      eq_gen <- NA_integer_
    } else {
      eq_gen <- max(eq_max, eq_min, na.rm = TRUE)
    }

    save(ts_mean_max, ts_low_max, ts_high_max,
         ts_mean_min, ts_low_min, ts_high_min,
         eq_gen, file=cache_file)
  }

  gens <- 0:duration

  .save_png("Challenge_B", width = 600, height = 400)
  plot(gens, ts_mean_max, type="l",
       xlab="Generation", ylab="Species richness",
       main="Mean richness with 97.2% CI (v=0.1, size=100)",
       ylim=range(c(ts_low_max, ts_high_max, ts_low_min, ts_high_min), finite=TRUE))
  lines(gens, ts_low_max, lty=3); lines(gens, ts_high_max, lty=3)

  lines(gens, ts_mean_min, lty=2)
  lines(gens, ts_low_min, lty=3); lines(gens, ts_high_min, lty=3)

  legend("topright",
         legend=c("Init max (mean)", "Init min (mean)", "97.2% CI bounds"),
         lty=c(1,2,3), bty="n")
  Sys.sleep(0.1)
  dev.off()

  if(is.na(eq_gen)){
    return("Could not detect a clear equilibrium entry time with the chosen criterion; the mean series fluctuates within the tail band without a strict settling point.")
  }
  return(paste("Estimated generations to reach dynamic equilibrium is approximately", eq_gen, "generations under these parameters."))
}


# Challenge question C
Challenge_C <- function() {

  if(!dir.exists("Data")) dir.create("Data", recursive = TRUE)
  if(!dir.exists("Results")) dir.create("Results", recursive = TRUE)

  cache_file <- file.path("Data", "Challenge_C_cache.rda")

  size <- 100
  v <- 0.1
  burn_in <- 200
  after <- 2000
  duration <- burn_in + after

  richness_values <- c(1,2,5,10,20,40,60,80,100)
  n_reps <- 80

  if(file.exists(cache_file)){
    load(cache_file)  # loads: richness_values, mean_series_list
  } else {

    init_random_given_R <- function(J, R){
      sample(1:R, size=J, replace=TRUE)
    }

    run_series <- function(comm){
      out <- numeric(duration + 1)
      out[1] <- species_richness(comm)
      for(g in 1:duration){
        comm <- neutral_generation_speciation(comm, v)
        out[g+1] <- species_richness(comm)
      }
      out
    }

    mean_series_list <- list()
    for(R in richness_values){
      mat <- matrix(NA_real_, nrow=n_reps, ncol=duration+1)
      for(r in 1:n_reps){
        comm0 <- init_random_given_R(size, R)
        mat[r,] <- run_series(comm0)
      }
      mean_series_list[[as.character(R)]] <- colMeans(mat)
    }

    save(richness_values, mean_series_list, file=cache_file)
  }

  gens <- 0:duration
  series_mat <- do.call(rbind, mean_series_list)

  .save_png("Challenge_C", width = 600, height = 400)
  plot(gens, series_mat[1,], type="l",
       xlab="Generation", ylab="Mean species richness",
       main="Mean richness time series for a range of initial richness values")
  if(nrow(series_mat) > 1){
    for(i in 2:nrow(series_mat)){
      lines(gens, series_mat[i,])
    }
  }
  legend("topright", legend=paste("Init R =", rownames(series_mat)), lty=1, bty="n", cex=0.7)
  Sys.sleep(0.1)
  dev.off()

  invisible(NULL)
}

# Challenge question D
Challenge_D <- function() {

  if(!dir.exists("Results")) dir.create("Results", recursive = TRUE)

  # ONLY neutral outputs
  files <- list.files("Data", pattern="^neutral_[0-9]+\\.rda$", full.names=TRUE)
  if(length(files) == 0) stop("Challenge_D: No neutral_###.rda files found in Data/.")

  # Safe iter extractor: always returns length-1 integer or NA
  get_iter <- function(path){
    base <- basename(path)
    m <- regmatches(base, regexpr("[0-9]{1,3}(?=\\.rda$)", base, perl=TRUE))
    if(length(m) != 1) return(NA_integer_)
    suppressWarnings(as.integer(m))
  }

  iter_to_size <- function(iter){
    if(iter >= 1 && iter <= 25) return(500)
    if(iter >= 26 && iter <= 50) return(1000)
    if(iter >= 51 && iter <= 75) return(2500)
    if(iter >= 76 && iter <= 100) return(5000)
    return(NA_integer_)
  }

  # We'll average the burn-in richness time series (time_series) by size
  sums   <- list("500"=numeric(0), "1000"=numeric(0), "2500"=numeric(0), "5000"=numeric(0))
  counts <- list("500"=0L,         "1000"=0L,         "2500"=0L,         "5000"=0L)

  for(f in files){
    iter <- get_iter(f)
    if(is.na(iter)) next

    sz <- iter_to_size(iter)
    if(is.na(sz)) next
    key <- as.character(sz)

    e <- new.env()
    load(f, envir=e)

    if(!exists("time_series", envir=e)) next
    ts <- get("time_series", envir=e)
    if(length(ts) == 0) next

    # pad sums to length
    if(length(sums[[key]]) < length(ts)){
      sums[[key]] <- c(sums[[key]], rep(0, length(ts) - length(sums[[key]])))
    }
    # add (ts should be numeric)
    sums[[key]][seq_along(ts)] <- sums[[key]][seq_along(ts)] + ts
    counts[[key]] <- counts[[key]] + 1L
  }

  means <- list(
    `500`  = if(counts[["500"]]  > 0) sums[["500"]]  / counts[["500"]]  else numeric(0),
    `1000` = if(counts[["1000"]] > 0) sums[["1000"]] / counts[["1000"]] else numeric(0),
    `2500` = if(counts[["2500"]] > 0) sums[["2500"]] / counts[["2500"]] else numeric(0),
    `5000` = if(counts[["5000"]] > 0) sums[["5000"]] / counts[["5000"]] else numeric(0)
  )

  png(filename="Results/Challenge_D.png", width = 600, height = 400)
  par(mfrow=c(2,2), mar=c(4,4,3,1))

  for(key in c("500","1000","2500","5000")){
    ts <- means[[key]]
    if(length(ts) == 0){
      plot(0,0,type="n", main=paste("Size =", key), xlab="Burn-in record index", ylab="Mean richness")
      text(0,0,"No data")
    } else {
      plot(seq_along(ts), ts, type="l",
           main=paste("Size =", key),
           xlab="Burn-in record index", ylab="Mean richness")
    }
  }

  Sys.sleep(0.1)
  dev.off()

  return(means)
}

# Challenge question E
Challenge_E <- function() {

  if(!dir.exists("Data")) dir.create("Data", recursive = TRUE)
  if(!dir.exists("Results")) dir.create("Results", recursive = TRUE)

  cache_file <- file.path("Data", "Challenge_E_cache.rda")

  v <- 0.1
  sizes <- c(500, 1000, 2500, 5000)
  reps_per_size <- 25

  coalescence_abundances <- function(J, speciation_rate){
    lineages <- rep(1L, J)
    abundances <- integer(0)
    N <- J
    theta <- (speciation_rate * J) / (1 - speciation_rate)

    while(N > 1){
      j <- sample.int(N, 1)
      randnum <- runif(1)
      p_spec <- theta / (theta + (N - 1))

      if(randnum < p_spec){
        abundances <- c(abundances, lineages[j])
      } else {
        i <- sample.int(N-1, 1)
        if(i >= j) i <- i + 1
        lineages[i] <- lineages[i] + lineages[j]
      }

      lineages <- lineages[-j]
      N <- N - 1
    }

    abundances <- c(abundances, lineages[1])
    sort(abundances, decreasing=TRUE)
  }

  # Coalescence cache
  if(file.exists(cache_file)){
    load(cache_file)  # loads: coal_mean, coal_elapsed_hours, v, sizes, reps_per_size
  } else {
    coal_mean <- list()

    t0 <- proc.time()[["elapsed"]]
    for(J in sizes){
      acc <- numeric(0)
      for(r in 1:reps_per_size){
        abund <- coalescence_abundances(J, v)
        acc <- sum_vect(acc, octaves(abund))
      }
      coal_mean[[as.character(J)]] <- acc / reps_per_size
    }
    t1 <- proc.time()[["elapsed"]]
    coal_elapsed_hours <- (t1 - t0) / 3600

    save(coal_mean, coal_elapsed_hours, v, sizes, reps_per_size, file=cache_file)
  }

  # Cluster combined results (Q26)
  if(file.exists("Data/neutral_cluster_combined_results.rda")){
    load("Data/neutral_cluster_combined_results.rda")  # loads combined_results
  } else {
    combined_results <- process_neutral_cluster_results()
  }

  .save_png("Challenge_E", width = 600, height = 400)
  par(mfrow=c(2,2), mar=c(4,4,3,1))

  # safer access by name
  keys <- c("500","1000","2500","5000")

  for(k in 1:4){
    J <- sizes[k]
    cl <- combined_results[[ keys[k] ]]
    co <- coal_mean[[ as.character(J) ]]

    L <- max(length(cl), length(co))
    if(length(cl) < L) cl <- c(cl, rep(0, L - length(cl)))
    if(length(co) < L) co <- c(co, rep(0, L - length(co)))

    bp <- barplot(cl, main=paste("Size =", J),
                  xlab="Octave class", ylab="Mean # species")
    lines(bp, co, type="b", lty=2)
    legend("topright", legend=c("Cluster mean", "Coalescence mean"),
           lty=c(1,2), bty="n", cex=0.8)
  }

  Sys.sleep(0.1)
  dev.off()

  cluster_cpu_hours <- 100 * 12
  coalescence_cpu_hours <- coal_elapsed_hours

  return(paste(
    "Coalescence used approximately", round(coalescence_cpu_hours, 4), "CPU hours on this machine for",
    reps_per_size, "replicates of each size (", paste(sizes, collapse=", "), ").",
    "The cluster used approximately", cluster_cpu_hours, "CPU hours for 100 jobs at 12 hours each (assuming 1 core per job).",
    "Coalescence is much faster because it works backwards in time and samples the species-abundance outcome directly via lineage merging/speciation events,",
    "avoiding long forward-time burn-in and time-series recording."
  ))
}