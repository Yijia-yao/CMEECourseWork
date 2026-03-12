#!/usr/bin/env python3

import sys
import subprocess
from pathlib import Path


def run_step(step_name: str, cmd: list[str], cwd: Path) -> None:
    """Run a workflow step, echoing output, and fail fast on error."""
    print("\n" + "=" * 72)
    print(f"STEP: {step_name}")
    print("CMD :", " ".join(cmd))
    print("=" * 72)

    completed = subprocess.run(
        cmd,
        cwd=str(cwd),
        text=True,
        capture_output=True
    )

    if completed.stdout.strip():
        print(completed.stdout)
    if completed.stderr.strip():
        print(completed.stderr, file=sys.stderr)

    if completed.returncode != 0:
        raise RuntimeError(f"Step failed: {step_name} (exit code {completed.returncode})")


def require_files(base: Path, relpaths: list[str]) -> None:
    missing = [rp for rp in relpaths if not (base / rp).exists()]
    if missing:
        msg = "\n".join([f"  - {m}" for m in missing])
        raise FileNotFoundError(f"Missing required file(s):\n{msg}")


def main() -> None:
    # script is in MiniProject/Code/, so project root is parents[1]
    base = Path(__file__).resolve().parents[1]
    py = sys.executable

    require_files(base, [
        "Data/logistic_growth_data.csv",
        "Data/logistic_growth_meta_data.csv",

        "Code/01_data_prep.py",
        "Code/02_exploratory_plots.py",
        "Code/03_fit_single_curves.py",
        "Code/04_fit_all_curves.py",
        "Code/05_analyse_model_selection.py",
        "Code/06_delta_ic_analysis.py",
        "Code/07_explain_winners.py",
        "Code/08_compile_report.sh",

        "TheReport/report.tex",
        "TheReport/references.bib",
    ])

    run_step("01 Data preparation", [py, "Code/01_data_prep.py"], cwd=base)
    require_files(base, [
        "Data/logistic_growth_data_prepared.csv",
        "Results/Tables/curve_lookup.csv",
        "Results/Tables/curve_summary.csv",
    ])

    run_step("02 Exploratory plots", [py, "Code/02_exploratory_plots.py"], cwd=base)
    require_files(base, [
        "Results/Figures/all_curves_overview.pdf",
        "Results/Figures/growth_curve_examples.pdf",
        "Results/Figures/growth_curve_examples_log.pdf",
        "Results/Tables/representative_curves.csv",
        "Results/Tables/curve_plotting_flags.csv",
    ])

    run_step("03 Minimal example fits (single curves)", [py, "Code/03_fit_single_curves.py"], cwd=base)
    require_files(base, [
        "Results/Tables/single_curve_model_fits.csv",
        "Results/Figures/ModelFits_single",
    ])

    run_step("04 Full fits (all curves)", [py, "Code/04_fit_all_curves.py"], cwd=base)
    require_files(base, [
        "Results/Tables/all_curve_model_fits.csv",
    ])

    run_step("05 Model selection summary", [py, "Code/05_analyse_model_selection.py"], cwd=base)
    require_files(base, [
        "Results/Tables/winners_by_aic.csv",
        "Results/Tables/winners_by_bic.csv",
        "Results/Tables/model_win_summary.csv",
        "Results/Figures/model_wins_aic.pdf",
        "Results/Figures/model_wins_by_unit_aic.pdf",
    ])

    run_step("06 Delta AIC analysis (evidence strength)", [py, "Code/06_delta_ic_analysis.py"], cwd=base)
    require_files(base, [
        "Results/Tables/delta_ic_strength_summary.csv",
        "Results/Figures/deltaAIC_winner_strength.pdf",
    ])

    run_step("07 Explain winners by curve features", [py, "Code/07_explain_winners.py"], cwd=base)
    require_files(base, [
        "Results/Tables/winner_by_npoints_table.csv",
        "Results/Tables/winner_by_dynamicrange_table.csv",
        "Results/Figures/winner_by_npoints_stacked.pdf",
        "Results/Figures/winner_by_dynamicrange_stacked.pdf",
    ])

    run_step("08 Compile report (LaTeX + auto wordcount)", ["bash", "Code/08_compile_report.sh"], cwd=base)
    require_files(base, [
        "TheReport/report.pdf",
        "TheReport/wordcount.tex",
    ])

    print("\n" + "=" * 72)
    print("MiniProject workflow completed successfully.")
    print("Key outputs:")
    print("  - TheReport/report.pdf")
    print("  - Results/Tables/model_win_summary.csv")
    print("  - Results/Tables/delta_ic_strength_summary.csv")
    print("  - Results/Tables/winner_by_npoints_table.csv")
    print("  - Results/Tables/winner_by_dynamicrange_table.csv")
    print("=" * 72)


if __name__ == "__main__":
    main()