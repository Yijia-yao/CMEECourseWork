# Week 3

## Overview

This week focuses on developing essential **R programming skills** for writing efficient, reproducible code. You will explore control flow, modular function design, and performance optimization using vectorization. Additionally, you will practice importing and exporting datasets, performing basic analyses, and running simple ecological simulations.

### Key Concepts

* **Control Flow:** Manage program logic using conditional statements and loops.
* **Functions:** Write modular, reusable functions for cleaner, more efficient scripts.
* **Vectorization:** Replace slow loops with fast, vectorized R operations.
* **File I/O:** Learn to read and write `.csv` files to organize results.
* **Simulations:** Model ecological or biological processes numerically.

## Folder Structure

```
week3/
├── data/
│   └── trees.csv              # Example dataset for tree height calculations
├── results/                   # Output directory for plots and CSV results
├── basic_io.R                 # Demonstrates basic input/output in R
├── boilerplate.R              # Template for writing functions
├── break.R                    # Example using 'break' to exit loops
├── next.R                     # Example using 'next' to skip iterations
├── TreeHeight.R               # Function for calculating tree height from angles
├── Vectorize1.R               # Compare vectorized vs loop performance
├── R_conditionals.R           # Practice conditional statements and logic
├── control_flow.R             # Illustrate if/for/while loop structures
└── Ricker.R                   # Ecological population model simulation
```

---

## Script Guide

| File                 | Description                                          | Example / Output                       |
| -------------------- | ---------------------------------------------------- | -------------------------------------- |
| **basic_io.R**       | Demonstrates file reading/writing and appending data | Creates `../results/MyData.csv`        |
| **boilerplate.R**    | Template for creating user-defined functions         | `MyFunction(3,4)` prints `7`           |
| **break.R**          | Uses `break` to terminate loops early                | Prints 0–9, then stops                 |
| **next.R**           | Uses `next` to skip even numbers                     | Prints only odd numbers 1–9            |
| **TreeHeight.R**     | Calculates tree height from distance and angle       | `TreeHeight(30,10)` ≈ 17.32            |
| **Vectorize1.R**     | Compares loops vs. vectorized operations             | Vectorized version runs ~100× faster   |
| **R_conditionals.R** | Defines logical tests (even, prime, power of 2)      | Try `is.prime(3)` → TRUE               |
| **control_flow.R**   | Demonstrates conditional and loop examples           | Prints squares and conditional outputs |
| **Ricker.R**         | Simulates population oscillations                    | Produces growth curve plot             |

---

## Extended Learning

This week’s scripts serve as a foundation for more advanced programming. You should practice:

1. **Debugging:** Learn to identify and fix logical or runtime errors using `traceback()` and `browser()`.
2. **Profiling Performance:** Compare different implementations using `system.time()` or `microbenchmark`.
3. **Functional Programming:** Use `lapply()` and `sapply()` to replace repetitive loops.
4. **Documentation:** Write clear comments and use `roxygen2` for structured function documentation.
5. **Data Validation:** Add error checks with `stopifnot()` and informative error messages.

---

## Example Analysis Workflow

A typical project pipeline during Week 3 might look like:

1. **Load data** → `basic_io.R`
2. **Process data** → `R_conditionals.R` or `Vectorize1.R`
3. **Run analysis** → `Ricker.R` (simulation) or `TreeHeight.R` (calculation)
4. **Save results** → Write outputs to `../results/`
5. **Visualize** → Plot outputs or inspect generated CSVs

---

## Tips for Success

* Always **use relative paths** (`../data/`, `../results/`) to keep scripts portable.
* Keep your **working directory** consistent (`getwd()` to check, `setwd()` only when necessary).
* Use **comments** generously to describe logic and function purposes.
* Organize your scripts so each has **one main goal**.
* Remember: vectorized code is **cleaner, faster, and easier to debug**.

---

## Reflection

By the end of Week 3, you should feel confident with:

* Designing your own functions and testing them with simple inputs.
* Using control flow to manage program logic effectively.
* Reading/writing data for reproducible workflows.
* Optimizing loops through vectorization.
* Applying R programming concepts to simple ecological models.

---

**Author:** Yijia Yao

**Course:** CMEECourseWork

**Week:** 3
