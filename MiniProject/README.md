# Computing Miniproject — Microbial population growth model comparison

This mini-project compares alternative mathematical models for microbial population growth curves. I fit two phenomenological polynomial models (quadratic, cubic) and two sigmoid growth models (logistic, Gompertz), and evaluate model support within each curve using AIC/BIC and ΔAIC evidence strength. The workflow is fully reproducible from a single command and produces all tables/figures plus a compiled LaTeX report.

---

## Project layout

```
MiniProject/
├── Code/                 scripts (01–08)
├── Data/                 raw CSVs + prepared dataset
├── Results/
│   ├── Figures/          PDF figures
│   └── Tables/           CSV outputs
└── TheReport/            LaTeX report (compiled to report.pdf)
```

---

## Languages and versions

Run in a Linux terminal (VS Code integrated terminal works well).

* **Python**: 3.x (tested in a project virtual environment)
* **LaTeX**: TeX Live (pdflatex + bibtex)
* **Shell**: bash

To print your exact versions (useful for marking records):

```bash
python --version
pdflatex --version | head -n 1
bibtex --version | head -n 1
```

---

## Dependencies (and what they are used for)

### Python packages

* **pandas** — reading CSV files, merging tables, curve-level summaries
* **numpy** — numerical operations, polynomial fitting, binning
* **matplotlib** — all plots (PDF output)
* **scipy** — nonlinear least squares fitting (`scipy.optimize.curve_fit`)
* **lmfit** — installed for NLLS workflows (not required by the current pipeline, but useful for extensions)

### System tools

* **texcount** (via `texlive-extra-utils`) — automatic word count written into the title page at compile time
* **pdflatex + bibtex** — LaTeX compilation + bibliography

---

## Setup (recommended)

From the `MiniProject/` directory:

```bash
python -m venv venv
source venv/bin/activate
python -m pip install pandas numpy matplotlib scipy lmfit seaborn
```

Install LaTeX + texcount utilities (if needed):

```bash
sudo apt-get update
sudo apt-get install texlive-latex-base texlive-latex-recommended texlive-bibtex-extra texlive-extra-utils
```

---

## Reproduce everything (single command)

From `MiniProject/`:

```bash
source venv/bin/activate
python Code/run_MiniProject.py
```

This runs the full workflow:

1. data preparation (IDs, summaries)
2. exploratory plots
3. minimal example fits
4. full model fitting across curves
5. model selection summaries (AIC/BIC winners)
6. ΔAIC evidence-strength analysis
7. interpreting winners by curve characteristics (sampling density, dynamic range)
8. compile the LaTeX report (auto-updating word count)

Final report output:

* `TheReport/report.pdf`

---

## Key outputs (for quick inspection)

### Main summary

* `Results/Tables/model_win_summary.csv`
* `Results/Figures/model_wins_aic.pdf`
* `Results/Figures/model_wins_by_unit_aic.pdf`

### Evidence strength (ΔAIC)

* `Results/Tables/delta_ic_strength_summary.csv`
* `Results/Figures/deltaAIC_winner_strength.pdf`

### “Why models win” diagnostics

* `Results/Tables/winner_by_npoints_table.csv`
* `Results/Tables/winner_by_dynamicrange_table.csv`
* `Results/Figures/winner_by_npoints_stacked.pdf`
* `Results/Figures/winner_by_dynamicrange_stacked.pdf`

---

## Notes

* Curves are defined as unique `Species × Temp × Medium × Citation × Rep`.
* Model comparison is performed **within curves** because PopBio is measured in heterogeneous units across studies.
* Some curve–model combinations are skipped when parameters are not identifiable (e.g., too few unique time points).
