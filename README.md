
# CMEE

This repository contains some coursework and practical materials for the **Living Planet with Computational Methods in Ecology and Evolution (CMEE)** programme at **Imperial College London**.


😄🎉👋Welcome to my **CMEE Coursework Repository**!  
This repo is a collection of all the coding exercises, data analyses, and modelling projects I’ve worked on as part of the *Computational Methods in Ecology and Evolution (CMEE)* MSc at Imperial College London.  

It’s basically a record of my journey learning how to think like a computational biologist — from writing Bash scripts and analysing data in R, to building models in Python.  
Each week focuses on a different skill, and together they cover everything from UNIX basics to ecological modelling and statistics.

## Feel free to explore the structure below 👇

#  Week1 Learning Goals
- Learning **UNIX**, **R**, and **Python**  
- Writing reproducible, modular, and well-organized code  
- Applying computational methods to biological datasets  
- Practising good coding and data management workflows  

Programming empowers biologists to:
- Perform custom analyses not covered by existing software  
- Ensure reproducibility and transparency  
- Improve computational efficiency and scientific rigor  

---

##  Repository Structure

Each weekly folder is organized as follows:
### 💻 1. Computing
├── UNIX and Linux

├── Shell scripting

├── Version control with Git

├── Scientific documents

├── Biological Computing in Python

└── Biological Computing in R



### 🌱 2. Ecological & Evolutionary Modelling
├── The Metabolic Basis of Ecology and Evolutionary Dynamics

├── Single Populations

├── Species Interactions

└── References



### 📊 3. Basic Data Analyses and Statistics

├── Introduction

├── Data Management and Visualization

├── Experimental Design and Data Exploration

├── Basic Hypothesis Testing

├── t-tests

├── Linear Models: Regression

├── Linear Models: Analysis of Variance

├── Linear Models: Multiple Explanatory Variables

├── Linear Models: Multiple Variables with Interactions

└── Model Simplification




### 🔢 4. Advanced Data Analyses and Statistics
├── Generalised Linear Models

├── Model Fitting using Non-linear Least-squares

└── Model Fitting using Maximum Likelihood



### 📚 5. Appendices
├── Introduction to Jupyter

├── Data Analyses with Python & Jupyter

├── Mathematical Models in Jupyter

├── Maths for Biologists

├── Databases

├── Model Fitting in Python

├── The Computing Miniproject

├── TMQB Coursework Assessment

└── Introduction to High-Performance Computing (HPC)

---

#  Week2 Learning Goals

This section summarises how the **Python-related** parts of my CMEECourseWork repo are organised.  
Each week builds up from basic scripting and logic to debugging, testing, and handling biological data.

---

### Introduction to Python

├── `basic_io1.py` — Reading and writing files  
├── `boilerplate.py` — Basic script structure and `main()` usage  
├── `cfexercises1.py` — Control flow exercises (pre-modular version)  
├── `control_flow.py` — Example module with functions  
├── `debugme.py` — Simple script for debugging practice  
├── `scope.py` — Understanding variable scope and namespaces  
├── `sysargv.py` — Command-line arguments and system inputs  
├── `loops.py` — Practice with `for` and `while` loops  
├── `test_control_flow.py` — Example of unit testing with `doctest`  
└── `README.md` — Overview of Python basics and learning notes

---

### Python II: Debugging, Testing & Bioinformatics

#### Part 1: Loops and List Comprehensions
├── `lc1.py` — Basic loop and comprehension tasks  
├── `lc2.py` — Advanced comprehension and conditionals  
├── `dictionary.py` — Using dictionaries and sets  
└── `tuple.py` — Tuple manipulations and unpacking  

#### Part 2: Writing a Program with Control Flows
├── `cfexercises1.py` — Updated as a standalone module  
└── Demonstrates structured `main()` and clean I/O handling  

#### Part 3: Align DNA Sequences
├── `align_seqs.py` — Program to find the best alignment between two DNA sequences  
├── `DNA_seqs.csv` — Input file with two example DNA sequences  
└── `best_alignment.txt` — Output file containing best alignment and score  

#### Part 4: The Missing Oaks Problem
├── `oaks_debugme.py` — Debugging exercise to find and fix logical errors  
├── `TestOaksData.csv` — Input data for testing tree names  
└── `JustOaksData.csv` — Output with oak species only  

#### Part 5: Testing and Debugging Practice
├── `test_control_flow.py` — Example doctests for control flow functions  
└── `debugme.py` — Used for practicing `pdb` and `ipdb` debugging  

#### Part 6: Numerical Computing with NumPy
├── `numpy_practice.py` — Practice with array creation, reshaping, and preallocation  
├── `matrix_operations.py` — Basic operations on 2D arrays and matrices  
└── Notes on `numpy`, `scipy`, and performance optimisation  




## Week 3: Control Flow, Functions, Vectorization & File I/O

### Overview

Week 3 focuses on the foundations of **structured programming in R**. Students learn how to control program logic, create modular functions, and use vectorized operations for efficient computation.

### Key Topics

* Control flow (`if`, `for`, `while`, `break`, `next`)
* Writing reusable functions
* Vectorized vs. loop-based operations
* Reading and writing data files (CSV)
* Basic simulation (Tree height, Ricker model)

### Outcomes

By the end of this week, students can:

* Write clean, modular R functions.
* Use control structures effectively for logical flow.
* Compare loop and vectorized performance.
* Conduct simple file I/O operations.

### Example Scripts

| Script         | Description                                    |
| -------------- | ---------------------------------------------- |
| `TreeHeight.R` | Calculates tree height from distance and angle |
| `Vectorize1.R` | Compares loop vs. vectorized operations        |
| `Ricker.R`     | Population model simulation                    |
| `basic_io.R`   | Demonstrates reading and writing CSVs          |

---

## Week 4: Data Wrangling, Visualization & Statistical Analysis

### Overview

Week 4 builds upon previous programming skills, emphasizing **data manipulation**, **performance optimization**, and **statistical modeling**. Students explore efficient computation using the `apply` family, generate publication-quality plots with `ggplot2`, and perform basic statistical analyses.

### Key Topics

* Data reshaping (wide ↔ long)
* Efficient computation using `apply`, `lapply`, `sapply`
* Pre-allocation and vectorization
* Error handling (`try()`) and debugging (`browser()`)
* Linear models and permutation tests
* Advanced plotting with `ggplot2`

### Outcomes

By the end of this week, students can:

* Clean and reshape complex datasets.
* Build and analyze statistical models.
* Implement vectorized, efficient workflows.
* Create professional data visualizations.
* Debug and handle errors in R scripts.

### Example Scripts

| Script                 | Description                                |
| ---------------------- | ------------------------------------------ |
| `DataWrang.R`          | Reshape species abundance data             |
| `apply1.R`, `apply2.R` | Use `apply` family for matrix operations   |
| `PP_Regress.R`         | Predator-prey regression and visualization |
| `Florida.R`            | Permutation test and climate data plotting |
| `Girko.R`              | Random matrix eigenvalue simulation        |

---

## Repository Navigation

| Folder     | Description                                 |
| ---------- | ------------------------------------------- |
| `week1/`   | Introduction to R and command-line basics   |
| `week2/`   | Reproducible workflows and scripting        |
| `week3/`   | Control flow, functions, and vectorization  |
| `week4/`   | Data wrangling, visualization, and analysis |
| `results/` | Output figures, CSVs, and PDFs              |

---

## How to Run

1. Clone this repository:

   ```bash
   git clone https://github.com/<username>/CMEECourseWork.git
   ```
2. Navigate to a specific week:

   ```bash
   cd CMEECourseWork/week3/code
   ```
3. Run any R script:

   ```bash
   Rscript scriptname.R
   ```

---

## Author

**Name:** Yijia Yao

**Course:** CMEECourseWork

**Contact:** yijia.yao@ucl.ac.uk
