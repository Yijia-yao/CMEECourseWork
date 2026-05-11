# MiniProject Assessment for Yijia Yao

## Computing

### A1 — Project Organisation

The project is well laid out, with the expected `Code/`, `Data/`, `Results/`, and `TheReport/` directories present, and the README gives a clear reproduction pathway, language versions, dependencies, and package purposes. That makes the submission easy to inspect and lowers the barrier to rerunning the analysis on another machine. The main organisational weakness is that `Results/Tables` and `Results/Figures` are committed to the repository, including many generated PDFs and CSVs, which costs marks under the rubric and weakens the “generate-on-run” principle; future submissions would benefit from keeping `Results/` empty in git and relying on the pipeline to recreate outputs.

### A2 — Single-Script Reproducibility

#### Workflow & Solution Quality

`run_MiniProject.py` runs data preparation, exploratory plotting, single-curve fitting, full fitting, model-selection summaries, delta-AIC analysis, and winner-explanation steps successfully, then stops in `Code/08_compile_report.sh` because `texcount` is unavailable. The orchestration is strong: `require_files()` checks inputs and expected intermediate outputs at each stage, and the run log shows concrete products being generated such as `Results/Tables/all_curve_model_fits.csv`, `Results/Tables/model_win_summary.csv`, and `Results/Figures/model_wins_aic.pdf`. The main reproducibility gap is that report compilation depends on `texcount` without a fallback, so one missing system utility aborts the whole pipeline even though the analysis itself has completed; a more robust approach would write a placeholder word count when `texcount` is absent and continue to `pdflatex`. The README also lists `lmfit` and `seaborn` even though the visible pipeline uses `pandas`, `numpy`, `matplotlib`, and `scipy`; a useful next step is to ask whether each non-core dependency is truly necessary for this submission and remove any unnecessary packages to improve reproducibility.

### A3 — Code Quality & Style

#### Script-level Technical Feedback

The codebase is substantial at 1220 lines across Python and shell, with 28 function definitions and a comment density of 0.101, which is comfortably in the adequate range for a student research workflow. Modularity is a real strength: `Code/run_MiniProject.py` separates orchestration into `run_step()` and `require_files()`, `Code/05_analyse_model_selection.py` uses `_is_success_row()` and `plot_wins_by_unit_pct()` to keep analysis and plotting readable, and `Code/plot_style.py` centralises `apply_style()` and `color_for_model()` so figure formatting is consistent across scripts. The largest fitting scripts, `Code/03_fit_single_curves.py` and `Code/04_fit_all_curves.py`, also use clearly named helpers such as `fit_model()`, `aic_bic()`, and `starting_values()`, which makes the nonlinear fitting logic much easier to follow than a monolithic notebook-style script. A concrete improvement would be to refactor `Code/01_data_prep.py` and `Code/02_exploratory_plots.py`, which currently have no function decomposition, into smaller helper functions so that data loading, curve-ID creation, and figure generation are easier to test and reuse.

### A4 — Model Fitting & Statistical Analysis

#### NLLS

The fitting workflow goes well beyond the minimum requirement: `Code/04_fit_all_curves.py` fits four models—quadratic, cubic, logistic, and Gompertz—across 305 curves using `scipy.optimize.curve_fit`, with AIC and BIC calculated from RSS for within-curve comparison. NLLS is used appropriately for the sigmoid models, with explicit starting values from `starting_values()`, biologically sensible bounds on `K`, `r`, and `t0`, and `try/except` handling so failed fits are recorded rather than crashing the analysis; the run produced 1178 successful fits and 42 skipped combinations due to insufficient unique time points. The analysis is statistically coherent because model comparison is restricted within curves measured on the same response scale, and the downstream scripts extend this into winner summaries and `Δ`AIC evidence-strength analysis rather than stopping at raw fit output. A concrete improvement would be to record the specific exception message or convergence reason in `all_curve_model_fits.csv` instead of only `FAILED_<ExceptionType>`, so that problematic curves can be diagnosed more transparently.

### A5 — Version Control & Workflow Discipline

The repository has 37 commits in total, but only 2 commits touch `MiniProject/`, and both are late, broad updates (`Update MiniProject analysis and report`, `pushing newest version of report`). That pattern looks much more like bulk submission-stage commits than iterative development, so it does not yet show the steady workflow discipline the rubric rewards. Future work could include committing each major stage separately—data prep, exploratory plots, fitting, report drafting—with more descriptive messages and without generated PDFs in version control.

## Report

### B1 — Report Format & Presentation

The report meets the main LaTeX formatting requirements: `article` class at 11pt, 1.5 spacing, line numbers, bibliography support, title page elements, and a non-numeric citation style are all in place. The body word count is 3368, which stays within the 3500-word limit, and the abstract at about 221 words is close to the expected length while remaining informative. The main presentation issue is scale: there are 9 display items (6 figures and 3 tables), which is above the target range of 4–6, so the visual story is a little over-expanded rather than tightly curated.

### B2 — Introduction & Objectives

The Introduction is well written and biologically literate, with a clear funnel from general microbial growth-curve shape to the contrast between phenomenological and sigmoid models, and it motivates why model choice matters for ecological interpretation. The hypotheses also emerge naturally from the narrative, especially the expectation that sigmoidal models should often perform well while sparse or weakly informative curves may favour polynomial flexibility. The main weakness is alignment with the course framing: the topic is clearly about single-population growth, but it is not explicitly grounded in the required MQB chapter material, and the biological versus methodological objectives are not separated as clearly as they could be.

### B3 — Methods (including Computing Tools)

The Methods section is one of the stronger parts of the report. It describes the dataset, defines a curve as a `Species × Temp × Medium × Citation × Rep` combination, states all four candidate models explicitly in mathematical form, explains starting values and bounds for sigmoid fitting, and justifies within-curve comparison because `PopBio` units differ across studies. The `Computing tools` subsection is present and names Python, `pandas`, `numpy`, `matplotlib`, `scipy`, Git, and LaTeX, but the tool justification is brief and more functional than reflective. A next step would be to make the computing rationale slightly sharper—for example, why `curve_fit` was preferred for bounded NLLS and how the shell script contributes to document reproducibility.

### B4 — Results & Display Items

The Results section is rich, logically ordered, and closely aligned to the stated objectives: it moves from fitting coverage, to overall model performance, to evidence strength, and then to how winner identity varies with sampling density and dynamic range. The section includes 9 display items, all with captions, and it reports model-comparison outputs clearly through AIC/BIC win counts, `Δ`AIC strength categories, and stratified summaries. There is, however, some interpretive discussion mixed into the Results—for example the paragraphs explaining what weak discrimination “suggests” and why shifts across data-rich curves matter biologically—which slightly blurs the boundary between factual reporting and Discussion.

### B5 — Discussion, Conclusions & Abstract

The Discussion returns well to the main findings, interprets them biologically, and does a good job of distinguishing frequent winners from decisive winners, which is an important scientific nuance in this dataset. Limitations are concrete rather than generic: heterogeneous `PopBio` units, non-positive values, skipped fits, and the simplification inherent in logistic and Gompertz forms are all discussed, and the future directions are specific, including Baranyi-type models, cross-validation, and hierarchical or mixed-effects approaches. The main ceiling on this section is advanced-methods engagement: hierarchical frameworks are mentioned, but the required explicit engagement with MLE, Bayesian inference, or machine learning is limited and not developed into a substantive paragraph about what extra biological insight those approaches would provide. The abstract is strong and self-contained, with clear background, methods, quantitative results, and take-home message.

## Summary

Final classification (student-facing):

- Part A (Computing): Distinction
- Part B (Report): Distinction
- Overall: Distinction
