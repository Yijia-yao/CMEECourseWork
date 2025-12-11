# Week 6 – Generalized Linear Models (GLMs)

## Project Description
    This folder contains all materials, data, and scripts for Week 6 of the *Stats with Sparrows* course, focused on **Generalized Linear Models (GLMs)**. The week covers practical exercises in R for applying GLMs to various ecological datasets, including sparrows, chytrid fungi, fisheries, and other study systems. Lecture slides, handouts, and example datasets allow students to follow exercises and explore GLM concepts.

**References & Resources:**  
- Lecture slides in the `lecture/` folder  
- Handouts and example datasets in the `handout/` folder  

---

## Languages
- **R** (version 4.3.0 or higher recommended)

---

## Dependencies
Required R packages (install via `install.packages()` if not already installed):
- `tidyverse` (data manipulation and visualization)  
- `ggplot2` (plotting)  
- `dplyr` (data wrangling)  
- `readr` (reading CSV and TXT files)  
- `MASS` (for some GLM functions)  

*(Check individual scripts for additional packages.)*

---

## Installation
1. Clone or download this repository.
2. Open RStudio or your preferred R environment.
3. Ensure all required R packages are installed.
4. Load and run scripts (e.g., `GLMs.ho1.R`) to perform exercises.

---

## Project Structure

    Week6/
    ├── handout/ # Handouts and example datasets
    │ ├── friday/ # Friday handouts and parkgrass dataset
    │ ├── monday/ # Monday handouts and datasets (e.g., chytrid, fisheries)
    │ ├── thursday/ # Thursday handouts (PDFs and SparrowSize.txt)
    │ └── tuesday and wednesday/ # Midweek handouts and datasets
    ├── lecture/ # Lecture slides for each day
    │ ├── friday/
    │ ├── monday/
    │ ├── thursday/
    │ └── tuesday and wednesday/
    ├── GLMs.ho1.R - GLMs.ho6.R # R scripts for homework exercises


---

## Usage
1. Open an R script (e.g., `GLMs.ho1.R`) in RStudio.
2. Set your working directory to the `Week6/` folder:
   ```r
   setwd("path/to/Week6")

    Load required packages:

library(tidyverse)
library(MASS)

Run the scripts to perform analyses. Each script corresponds to a specific homework exercise:

    GLMs.ho1.R → Homework 1

    GLMs.ho2.R → Homework 2

    ...

    GLMs.ho6.R → Homework 6

Example datasets are stored in handout/ subfolders. Use paths like:

    read.csv("handout/monday/bee_mites.csv")

## Authors & Contact

    Yijia Yao – Lecture material compilation and documentation – yijia.yao25@imperial.ac.uk
