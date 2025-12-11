# CMEE

This repository contains coursework and practical materials for the **Living Planet with Computational Methods in Ecology and Evolution (CMEE)** programme at **Imperial College London**.

This repo is a collection of all coding exercises, data analyses, and modelling projects I’ve worked on as part of the MSc.  
Each week focuses on a different skill, covering UNIX, R, Python, data analysis, statistics, and ecological modelling.

---

## Week 1: Introduction to UNIX, R & Python

### Overview
Introduction to UNIX commands, R and Python basics, scripting, and data handling.

### Key Topics
- UNIX shell commands and file management  
- Version control with Git  
- Writing basic scripts in R and Python  
- Reading and writing files  
- Simple data exploration and visualization  

### Example Scripts
| Script        | Description                    |
| ------------- | ------------------------------ |
| `basic_io1.py`| File reading and writing       |
| `boilerplate.py` | Basic script structure      |
| `cfexercises1.py` | Control flow exercises      |
| `debugme.py`  | Debugging practice             |
| `TreeHeight.R`| Tree height calculation         |

### Usage
1. Open scripts in RStudio or Python  
2. Set working directory  
3. Run scripts to perform exercises  

---

## Week 2: Python Programming – Control Flow & Bioinformatics

### Overview
Learn loops, functions, list comprehensions, dictionaries, and simple bioinformatics tasks in Python.

### Example Scripts
| Script          | Description                              |
| --------------- | ---------------------------------------- |
| `lc1.py`        | Loops and list comprehensions             |
| `dictionary.py` | Dictionaries and sets                     |
| `align_seqs.py` | DNA sequence alignment                     |
| `oaks_debugme.py` | Debugging example                        |
| `numpy_practice.py` | NumPy array operations                  |

---

## Week 3: Control Flow, Functions, Vectorization & File I/O (R)

### Overview
Structured programming in R: control flow, functions, vectorization, file I/O, and simple simulations.

### Key Topics
- `if`, `for`, `while`, `break`, `next`  
- Writing reusable functions  
- Vectorized operations vs loops  
- Reading and writing CSVs  
- Basic simulation (Ricker model, Tree height)  

### Example Scripts
| Script         | Description                                    |
| -------------- | ---------------------------------------------- |
| `TreeHeight.R` | Calculates tree height from distance and angle |
| `Vectorize1.R` | Compares loop vs vectorized operations        |
| `Ricker.R`     | Population model simulation                    |
| `basic_io.R`   | Reading and writing CSVs                       |

---

## Week 4: Data Wrangling, Visualization & Statistical Analysis

### Overview
Data manipulation, performance optimization, and statistical modelling in R.  

### Key Topics
- Data reshaping (wide ↔ long)  
- Apply functions (`apply`, `lapply`, `sapply`)  
- Pre-allocation and vectorization  
- Error handling (`try()`, `browser()`)  
- Linear models and permutation tests  
- Advanced plotting with `ggplot2`  

### Example Scripts
| Script                 | Description                                |
| ---------------------- | ------------------------------------------ |
| `DataWrang.R`          | Reshape species abundance data             |
| `apply1.R`, `apply2.R` | Use `apply` family for matrix operations   |
| `PP_Regress.R`         | Predator-prey regression and visualization |
| `Florida.R`            | Permutation test and climate data plotting |
| `Girko.R`              | Random matrix eigenvalue simulation        |

---

## Week 5: Stats with Sparrows – Basic Linear Models

### Overview
Focus on linear regression, ANOVA, t-tests, correlation, and data visualization using sparrow and other ecological datasets.

### Example Scripts
| Script        | Description                              |
| ------------- | ---------------------------------------- |
| `SwS01.R`     | Data introduction and basic plots        |
| `SwS02.R`     | Linear regression exercises              |
| `SwS03.R`     | ANOVA examples                            |
| `SwS04.R`     | Model diagnostics                         |
| `SwS05.R`     | Multiple explanatory variables           |
| `SwS06.R`     | Interaction terms in models              |
| `SwS07.R`     | t-tests                                   |
| `SwS08.R`     | Correlation analysis                      |
| `SwS09.R`     | Advanced linear models                    |
| `SwS10.R`     | Visualizing model outputs                |
| `SwS11.R`     | Case study using sparrow size dataset    |
| `SwS12.R`     | Integrating multiple datasets            |
| `SwS13.R`     | Final exercises                           |

### Usage
1. Open R scripts in RStudio  
2. Set working directory to `Week5/`  
3. Load dependencies (e.g., `tidyverse`, `ggplot2`)  
4. Read datasets from `data/`  
5. Run scripts to reproduce analyses  

---

## Week 6: Stats with Sparrows – Generalized Linear Models

### Overview
Introduction to Generalized Linear Models (GLMs), including multiple distributions, link functions, and model diagnostics.

### Example Scripts
| Script        | Description                              |
| ------------- | ---------------------------------------- |
| `GLMs.ho1.R`  | Introduction to GLMs and basic exercises |
| `GLMs.ho2.R`  | GLMs with Poisson and binomial distributions |
| `GLMs.ho3.R`  | Model diagnostics and residual analysis  |
| `GLMs.ho4.R`  | GLMs with multiple explanatory variables |
| `GLMs.ho5.R`  | Practical case studies with sparrow datasets |
| `GLMs.ho6.R`  | Advanced GLM exercises and visualization |


### Usage
1. Open GLMs.ho*.R scripts in RStudio  
2. Set working directory to `Week6/`  
3. Load dependencies (e.g., `tidyverse`, `ggplot2`, `MASS`)  
4. Read datasets from the appropriate handout subfolder  
5. Run scripts to perform exercises  

---

## Author
- Yijia Yao email: yijia.yao25@imperial.ac.uk