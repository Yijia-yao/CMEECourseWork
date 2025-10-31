# Week 4: Data Wrangling, Visualization, and Statistical Analysis

## Overview

This week focuses on **data wrangling**, **efficient computation**, **advanced plotting**, and **statistical modeling** in R. You’ll learn how to clean, reshape, and analyze datasets while improving speed and robustness in your code.

### Topics Covered

* Data reshaping: wide ↔ long formats using `reshape2` and `melt`
* Using the `apply` family for efficient computation
* Pre-allocation and memory optimization
* Vectorization: replacing loops with `lapply`, `sapply`, and built-in functions
* Statistical analysis: linear models, permutation tests, simulations
* Creating publication-ready graphics with `ggplot2`
* Command-line R scripts and debugging with `browser()`

---

## Folder Structure

```
week4/
├── data/
│   ├── PoundHillData.csv
│   ├── PoundHillMetaData.csv
│   ├── KeyWestAnnualMeanTemperature.RData
│   ├── EcolArchives-E089-51-D1.csv
│   └── Results.txt
├── results/                  # CSVs, PDFs, PNGs
├── DataWrang.R
├── apply1.R
├── apply2.R
├── preallocate.R
├── sample.R
├── try.R
├── Ricker.R
├── Vectorize1.R
├── Vectorize2.R
├── plotLin.R
├── Florida.R
├── Girko.R
├── MyBars.R
├── PP_Regress.R
├── browse.R
└── get_TreeHeight.R
```

---

## Quick Start

```r
setwd("path/to/week4")
dir.create("results", showWarnings = FALSE)
```

This ensures all output files (plots, CSVs) are saved in the correct directory.

---

## Script Guide

| File                 | Purpose                                   | Key Output                         |
| -------------------- | ----------------------------------------- | ---------------------------------- |
| **DataWrang.R**      | Reshape ecological data (wide → long)     | `MyWrangledData`                   |
| **apply1.R**         | Demonstrates row/column means & variances | Console output                     |
| **apply2.R**         | Custom `apply` for row scaling            | Normalized matrix                  |
| **preallocate.R**    | Compare pre-allocation vs dynamic growth  | Speed test summary                 |
| **sample.R**         | Compare loop vs vectorized sampling       | `sapply` is fastest                |
| **try.R**            | Demonstrate safe error handling           | Skips errors silently              |
| **Ricker.R**         | Deterministic population dynamics         | Smooth population curve            |
| **Vectorize1.R**     | Benchmark vectorization with `sum()`      | ~100× faster result                |
| **Vectorize2.R**     | Stochastic Ricker model                   | Randomized population oscillations |
| **plotLin.R**        | Linear regression and annotated plot      | `MyLinReg.pdf`                     |
| **Florida.R**        | Permutation test on warming data          | `Florida_results.pdf`              |
| **Girko.R**          | Eigenvalue simulation (Girko’s Law)       | `Girko.pdf`                        |
| **MyBars.R**         | Multi-group bar plots                     | `MyBars.pdf`                       |
| **PP_Regress.R**     | Predator-prey regressions                 | `PP_Regress_Results.csv`           |
| **browse.R**         | Debug loop using `browser()`              | Step-through demo                  |
| **get_TreeHeight.R** | CLI to compute tree heights               | `TreeHts.csv`                      |

---

## Key Concepts

###  Pre-allocation

Efficient memory usage prevents performance bottlenecks:

```r
# Slow: dynamic vector growth
a <- c(); for(i in 1:10000) a <- c(a, i)

# Fast: pre-allocated vector
a <- rep(NA, 10000); for(i in 1:10000) a[i] <- i
```

###  Vectorization

Vectorized functions reduce the need for explicit loops:

```r
# Slow loop
for(i in 1:10000) result[i] <- mean(sample(pop, 100))

# Fast vectorized version
sapply(1:10000, function(i) mean(sample(pop, 100)))
```

###  Error Handling

`try()` allows a loop or `lapply()` to continue despite errors:

```r
result <- lapply(1:15, function(i) try(do_it(pop), silent = TRUE))
```

###  Command-Line Interface (CLI)

Run scripts directly from the shell:

```bash
Rscript get_TreeHeight.R ../data/trees.csv
```

---

## Exercises

1. **Pre-allocation:** Optimize `loopy_sample1` in `sample.R` and benchmark speed.
2. **Error control:** Wrap `Ricker.R` in `try()` for robustness.
3. **Randomization:** Add `set.seed()` to `Vectorize2.R` for reproducibility.
4. **Group analysis:** Use `tapply()` to summarize prey/predator data by life stage.
5. **Debug practice:** Step through `browse.R` to watch variable changes.

---

## Performance Tips

| Method                            | Speed        | Recommended Use           |
| --------------------------------- | ------------ | ------------------------- |
| `for` + dynamic growth            |  Very Slow | Avoid completely          |
| `for` + pre-allocation            | Medium    | Small loops               |
| `lapply` / `sapply`               | Fast       | Vectorized, readable code |
| Built-in (`sum`, `mean`, `apply`) |  Fastest   | Always prefer             |

---

## Summary

By the end of Week 4, you should be able to:

* Clean and reshape complex datasets efficiently.
* Write fast, memory-safe R code using vectorization and pre-allocation.
* Conduct basic statistical analyses (e.g., regression, permutation tests).
* Create high-quality plots using `ggplot2`.
* Build and run R scripts from the command line.
* Debug effectively using `try()` and `browser()`.

---

**Author:** Yijia Yao

**Course:** CMEECourseWork

**Week:** 4
