# Week 5 – Stats with Sparrows

## Project Description
    This folder contains all materials, data, and scripts for Week 5 of the *Stats with Sparrows* course. The primary focus of this week is to practice data analysis and statistical modeling using R, based on datasets from various ecological studies (e.g., sparrow size, ornamentation, and other species datasets). The provided lecture slides, handouts, and sandbox data allow students to follow along with exercises and complete the assigned tasks.

**References & Resources:**  
- Lecture slides in the `lecture/` folder  
- Handouts in the `handout/` folder  
- Sandbox datasets in `data/` folder (also included as `SandBoxData.zip`)  

---

## Languages
- **R** (version 4.3.0 or higher recommended)

---

## Dependencies
The following R packages may be required (install via `install.packages()` if not already available):
- `tidyverse` (for data manipulation and visualization)
- `ggplot2` (for plotting)
- `dplyr` (data wrangling)
- `readr` (reading CSV and TXT files)  

*(Check individual scripts for any additional package requirements.)*

---

## Installation
1. Clone or download this repository.
2. Unzip `SandBoxData.zip` into the `data/` folder if needed.
3. Ensure all required R packages are installed.
4. Open RStudio or your preferred R environment and load the scripts (e.g., `SwS01.R`) to start running analyses.

---

## Project Structure

    Week5/
    ├── data/ # Contains CSV and TXT datasets for analysis
    ├── handout/ # PDFs with exercises, instructions, and solutions
    ├── lecture/ # Lecture slides in PPTX and PDF formats
    ├── SwS01.R - SwS13.R # R scripts for exercises and analyses
    └── SandBoxData.zip # Compressed version of all datasets


---

## Usage
1. Open an R script (e.g., `SwS01.R`) in RStudio.
2. Set your working directory to the `Week5/` folder:
   ```r
   setwd("path/to/Week5")

    Load any required packages:

    library(tidyverse)

    Run the script to perform the analysis. Each script corresponds to a specific lecture or handout exercise:

        SwS01.R → Exercise 1

        SwS02.R → Exercise 2

        ...

        SwS13.R → Exercise 13

    Data files in data/ should be read directly in the scripts (e.g., read.csv("data/Aconite.csv")).

## Authors & Contact

    Yijia Yao – Lecture material preparation and documentation – yijia.yao25@imperial.ac.uk
