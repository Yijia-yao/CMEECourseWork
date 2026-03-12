#!/usr/bin/env python3
from __future__ import annotations

import pandas as pd
import matplotlib.pyplot as plt
from pathlib import Path

from plot_style import apply_style, save_pdf, color_for_model


def _is_success_row(df: pd.DataFrame) -> pd.Series:
    """Successful fits are those not labelled FAILED/SKIPPED in params."""
    params = df["params"].astype(str)
    bad = params.str.startswith("FAILED") | params.str.startswith("SKIPPED")
    return ~bad


def plot_model_wins_bar(win_counts: pd.Series, outpath: Path) -> None:
    """Horizontal bar chart with consistent model colours + numeric labels."""
    apply_style()
    win_counts = win_counts.sort_values(ascending=True)

    fig, ax = plt.subplots(figsize=(7.2, 4.2))
    colors = [color_for_model(m) for m in win_counts.index.astype(str)]
    ax.barh(win_counts.index.astype(str), win_counts.values, color=colors)

    ax.set_xlabel("Number of curves")
    ax.set_ylabel("")

    xmax = max(win_counts.values) if len(win_counts) else 1
    for i, v in enumerate(win_counts.values):
        ax.text(v + xmax * 0.01 + 0.5, i, f"{int(v)}", va="center")

    save_pdf(outpath)
    plt.close(fig)


def plot_wins_by_unit_pct(winners: pd.DataFrame, outpath: Path) -> pd.DataFrame:
    """
    Percent stacked bar: within each unit category, what % of curves were won by each model?
    Uses consistent model colours.
    Returns the underlying percentage table.
    """
    apply_style()

    tab = pd.crosstab(winners["PopBio_units"], winners["model"])
    tab = tab.loc[tab.sum(axis=1).sort_values(ascending=False).index]

    model_order = [m for m in ["logistic", "gompertz", "cubic", "quadratic"] if m in tab.columns] + [
        m for m in tab.columns if m not in ["logistic", "gompertz", "cubic", "quadratic"]
    ]
    tab = tab[model_order]

    tab_pct = tab.div(tab.sum(axis=1), axis=0) * 100

    fig, ax = plt.subplots(figsize=(9.2, 4.8))
    tab_pct.plot(
        kind="bar",
        stacked=True,
        width=0.6,
        ax=ax,
        color=[color_for_model(m) for m in tab_pct.columns]
    )

    ax.set_ylabel("Percentage of curves (%)")
    ax.set_xlabel("PopBio units")
    ax.legend(title="Model", bbox_to_anchor=(1.02, 1), loc="upper left", borderaxespad=0)
    plt.xticks(rotation=25, ha="right")

    save_pdf(outpath)
    plt.close(fig)
    return tab_pct


def main() -> None:
    base_dir = Path(__file__).resolve().parents[1]  # MiniProject/
    results_dir = base_dir / "Results"
    tables_dir = results_dir / "Tables"
    figs_dir = results_dir / "Figures"
    tables_dir.mkdir(parents=True, exist_ok=True)
    figs_dir.mkdir(parents=True, exist_ok=True)

    fits_path = tables_dir / "all_curve_model_fits.csv"
    df = pd.read_csv(fits_path)

    ok = df[_is_success_row(df)].copy()
    ok["aic"] = pd.to_numeric(ok["aic"], errors="coerce")
    ok["bic"] = pd.to_numeric(ok["bic"], errors="coerce")
    ok = ok.dropna(subset=["aic", "bic"])

    winners_aic = (
        ok.sort_values(["curve_num", "aic"])
        .drop_duplicates(subset=["curve_num"], keep="first")
        .reset_index(drop=True)
    )
    winners_bic = (
        ok.sort_values(["curve_num", "bic"])
        .drop_duplicates(subset=["curve_num"], keep="first")
        .reset_index(drop=True)
    )

    winners_aic_out = tables_dir / "winners_by_aic.csv"
    winners_bic_out = tables_dir / "winners_by_bic.csv"
    winners_aic.to_csv(winners_aic_out, index=False)
    winners_bic.to_csv(winners_bic_out, index=False)
    print("Saved:", winners_aic_out)
    print("Saved:", winners_bic_out)

    win_aic_counts = winners_aic["model"].value_counts()
    win_bic_counts = winners_bic["model"].value_counts()

    all_models = sorted(ok["model"].unique())
    summary = pd.DataFrame({
        "model": all_models,
        "wins_aic": [int(win_aic_counts.get(m, 0)) for m in all_models],
        "wins_bic": [int(win_bic_counts.get(m, 0)) for m in all_models],
    })
    summary["total_curves_aic"] = winners_aic["curve_num"].nunique()
    summary["total_curves_bic"] = winners_bic["curve_num"].nunique()

    summary_out = tables_dir / "model_win_summary.csv"
    summary.to_csv(summary_out, index=False)
    print("Saved:", summary_out)

    # Figure 1
    plot_model_wins_bar(
        win_aic_counts.reindex(all_models).fillna(0),
        figs_dir / "model_wins_aic.pdf"
    )
    print("Saved:", figs_dir / "model_wins_aic.pdf")

    # Ensure PopBio_units exists for Figure 2
    if "PopBio_units" not in winners_aic.columns:
        meta = df[["curve_num", "PopBio_units"]].drop_duplicates()
        winners_aic = winners_aic.merge(meta, on="curve_num", how="left")

    unit_pct = plot_wins_by_unit_pct(
        winners_aic,
        figs_dir / "model_wins_by_unit_aic.pdf"
    )
    print("Saved:", figs_dir / "model_wins_by_unit_aic.pdf")

    # Save unit tables
    unit_counts = pd.crosstab(winners_aic["PopBio_units"], winners_aic["model"])
    unit_counts_out = tables_dir / "model_wins_by_unit.csv"
    unit_counts.to_csv(unit_counts_out)
    print("Saved:", unit_counts_out)

    unit_pct_out = tables_dir / "model_wins_by_unit_pct.csv"
    unit_pct.to_csv(unit_pct_out)
    print("Saved:", unit_pct_out)

    print("\nCurves with at least one successful fit (AIC winners):", winners_aic["curve_num"].nunique())
    print("Top AIC-winning model:", win_aic_counts.idxmax())


if __name__ == "__main__":
    main()