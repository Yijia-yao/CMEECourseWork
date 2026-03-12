#!/usr/bin/env python3
from __future__ import annotations

import pandas as pd
import matplotlib.pyplot as plt
from pathlib import Path

from plot_style import apply_style, save_pdf, color_for_model


def stacked_pct_plot(tab_counts: pd.DataFrame, outpath: Path, xlabel: str) -> pd.DataFrame:
    """Percent stacked bar plot with consistent model colours; returns percent table."""
    apply_style()

    # stable model order
    model_order = [m for m in ["logistic", "gompertz", "cubic", "quadratic"] if m in tab_counts.columns] + [
        m for m in tab_counts.columns if m not in ["logistic", "gompertz", "cubic", "quadratic"]
    ]
    tab_counts = tab_counts[model_order]

    tab_pct = tab_counts.div(tab_counts.sum(axis=1), axis=0) * 100

    fig, ax = plt.subplots(figsize=(9.2, 4.8))
    tab_pct.plot(
        kind="bar",
        stacked=True,
        width=0.6,
        ax=ax,
        color=[color_for_model(m) for m in tab_pct.columns]
    )

    ax.set_ylabel("Percentage of curves (%)")
    ax.set_xlabel(xlabel)
    ax.legend(title="Model", bbox_to_anchor=(1.02, 1), loc="upper left", borderaxespad=0)
    plt.xticks(rotation=0)

    save_pdf(outpath)
    plt.close(fig)
    return tab_pct


def main() -> None:
    base = Path(__file__).resolve().parents[1]  # MiniProject/
    tables = base / "Results" / "Tables"
    figs = base / "Results" / "Figures"
    figs.mkdir(parents=True, exist_ok=True)

    winners = pd.read_csv(tables / "winners_by_aic.csv")
    summary = pd.read_csv(tables / "curve_summary.csv")

    df = winners.merge(
        summary[["curve_num", "n_points", "time_min", "time_max", "pop_min", "pop_max", "PopBio_units", "Temp"]],
        on="curve_num",
        how="left",
        suffixes=("_win", "_sum")
    )

    # Resolve PopBio_units if duplicated
    if "PopBio_units" not in df.columns:
        if "PopBio_units_sum" in df.columns:
            df["PopBio_units"] = df["PopBio_units_sum"]
        elif "PopBio_units_win" in df.columns:
            df["PopBio_units"] = df["PopBio_units_win"]

    df["dynamic_range"] = df["pop_max"] - df["pop_min"]

    # ---- Short bins ----
    # n_points bins (short labels)
    df["n_points_bin"] = pd.cut(df["n_points"], bins=[0, 10, 15, 20, 30, 100], right=True)
    mapping = {
        pd.Interval(0, 10, closed="right"): "≤10",
        pd.Interval(10, 15, closed="right"): "10–15",
        pd.Interval(15, 20, closed="right"): "15–20",
        pd.Interval(20, 30, closed="right"): "20–30",
        pd.Interval(30, 100, closed="right"): "≥30",
    }
    df["n_points_label"] = df["n_points_bin"].map(mapping)
    df["n_points_label"] = pd.Categorical(
        df["n_points_label"],
        categories=["≤10", "10–15", "15–20", "20–30", "≥30"],
        ordered=True
    )

    # dynamic range quartiles (Q1–Q4 labels)
    df["dyn_quartile"] = pd.qcut(
        df["dynamic_range"],
        q=4,
        labels=["Q1 (low)", "Q2", "Q3", "Q4 (high)"]
    )

    # ---- Count tables ----
    unit_tab = pd.crosstab(df["PopBio_units"], df["model"])
    np_tab = pd.crosstab(df["n_points_label"], df["model"])
    dyn_tab = pd.crosstab(df["dyn_quartile"], df["model"])

    unit_tab.to_csv(tables / "winner_by_unit_table.csv")
    np_tab.to_csv(tables / "winner_by_npoints_table.csv")
    dyn_tab.to_csv(tables / "winner_by_dynamicrange_table.csv")
    print("Saved:", tables / "winner_by_unit_table.csv")
    print("Saved:", tables / "winner_by_npoints_table.csv")
    print("Saved:", tables / "winner_by_dynamicrange_table.csv")

    # ---- Figures (percent stacked) ----
    np_pct = stacked_pct_plot(
        np_tab,
        figs / "winner_by_npoints_stacked.pdf",
        xlabel="Points per curve (bin)"
    )
    print("Saved:", figs / "winner_by_npoints_stacked.pdf")

    dyn_pct = stacked_pct_plot(
        dyn_tab,
        figs / "winner_by_dynamicrange_stacked.pdf",
        xlabel="Dynamic range (quartile)"
    )
    print("Saved:", figs / "winner_by_dynamicrange_stacked.pdf")

    # ---- Save percent tables too (nice for writing) ----
    np_pct.to_csv(tables / "winner_by_npoints_pct.csv")
    dyn_pct.to_csv(tables / "winner_by_dynamicrange_pct.csv")
    print("Saved:", tables / "winner_by_npoints_pct.csv")
    print("Saved:", tables / "winner_by_dynamicrange_pct.csv")

    print("Done.")


if __name__ == "__main__":
    main()