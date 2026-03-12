#!/usr/bin/env python3
from __future__ import annotations

from pathlib import Path
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

from plot_style import apply_style, save_pdf


def strength_bin(x: float) -> str:
    """Categorise evidence strength by ΔAIC gap to runner-up."""
    if pd.isna(x):
        return "NA"
    if x < 2:
        return "<2 (weak)"
    if x < 7:
        return "2–7 (moderate)"
    if x < 10:
        return "7–10 (strong)"
    return ">10 (very strong)"


def main() -> None:
    base_dir = Path(__file__).resolve().parents[1]  # MiniProject/
    table_dir = base_dir / "Results" / "Tables"
    fig_dir = base_dir / "Results" / "Figures"
    table_dir.mkdir(parents=True, exist_ok=True)
    fig_dir.mkdir(parents=True, exist_ok=True)

    fits_path = table_dir / "all_curve_model_fits.csv"
    df = pd.read_csv(fits_path)

    # -------------------------
    # Keep only successful fits
    # -------------------------
    params = df["params"].astype(str)
    ok = df[~(params.str.startswith("FAILED") | params.str.startswith("SKIPPED"))].copy()

    ok["aic"] = pd.to_numeric(ok["aic"], errors="coerce")
    ok["bic"] = pd.to_numeric(ok["bic"], errors="coerce")
    ok = ok.dropna(subset=["aic", "bic"])

    # -------------------------
    # Delta AIC / Delta BIC within each curve
    # -------------------------
    ok["min_aic_curve"] = ok.groupby("curve_num")["aic"].transform("min")
    ok["min_bic_curve"] = ok.groupby("curve_num")["bic"].transform("min")
    ok["delta_aic"] = ok["aic"] - ok["min_aic_curve"]
    ok["delta_bic"] = ok["bic"] - ok["min_bic_curve"]

    out_delta = table_dir / "delta_ic_by_curve.csv"
    ok.to_csv(out_delta, index=False)
    print("Saved:", out_delta)

    # -------------------------
    # Identify winner per curve (AIC)
    # -------------------------
    winners = (
        ok.sort_values(["curve_num", "aic"])
          .drop_duplicates(subset=["curve_num"], keep="first")
          .reset_index(drop=True)
    )

    # Runner-up AIC gap: second-best minus best
    runner_up = (
        ok.sort_values(["curve_num", "aic"])
          .groupby("curve_num")
          .nth(1)  # second row per curve (if exists)
          .reset_index()
          .rename(columns={"aic": "aic_second"})
    )

    winners = winners.merge(
        runner_up[["curve_num", "aic_second"]],
        on="curve_num",
        how="left"
    )
    winners["delta_aic_runnerup"] = winners["aic_second"] - winners["aic"]
    winners["evidence_strength"] = winners["delta_aic_runnerup"].apply(strength_bin)

    # -------------------------
    # Evidence strength summary table
    # -------------------------
    strength_summary = (
        winners.groupby(["model", "evidence_strength"])
               .size()
               .reset_index(name="n_curves")
    )
    totals = winners.groupby("model").size().rename("total").reset_index()
    strength_summary = strength_summary.merge(totals, on="model", how="left")
    strength_summary["pct_within_winner"] = (100 * strength_summary["n_curves"] / strength_summary["total"]).round(1)

    out_strength = table_dir / "delta_ic_strength_summary.csv"
    strength_summary.to_csv(out_strength, index=False)
    print("Saved:", out_strength)

    # -------------------------
    # Figure settings
    # -------------------------
    cap = 50  # clip extreme ΔAIC values for readability in boxplots

    # -------------------------
    # Figure 3: ΔAIC distribution by model (clipped)
    # -------------------------
    apply_style()
    plot_df = ok.copy()
    plot_df["delta_aic_clip"] = plot_df["delta_aic"].clip(upper=cap)

    models = sorted(plot_df["model"].unique())
    data = [plot_df.loc[plot_df["model"] == m, "delta_aic_clip"].values for m in models]

    plt.figure(figsize=(8, 4.8))
    plt.boxplot(data, tick_labels=models, showfliers=False)
    plt.ylabel(f"ΔAIC within curve (clipped at {cap})")
    plt.xlabel("Model")
    save_pdf(fig_dir / "deltaAIC_distribution.pdf")
    print("Saved:", fig_dir / "deltaAIC_distribution.pdf")

    # -------------------------
    # Figure 4: evidence strength (gap to runner-up), clipped
    # -------------------------
    apply_style()
    w = winners.dropna(subset=["delta_aic_runnerup"]).copy()
    w["gap_clip"] = w["delta_aic_runnerup"].clip(upper=cap)

    models_w = sorted(w["model"].unique())
    data_w = [w.loc[w["model"] == m, "gap_clip"].values for m in models_w]

    plt.figure(figsize=(8, 4.8))
    plt.boxplot(data_w, tick_labels=models_w, showfliers=False)
    plt.ylabel(f"ΔAIC to runner-up (clipped at {cap})")
    plt.xlabel("Winning model")
    save_pdf(fig_dir / "deltaAIC_winner_strength.pdf")
    print("Saved:", fig_dir / "deltaAIC_winner_strength.pdf")

    # -------------------------
    # Quick console summary (useful for writing)
    # -------------------------
    n_winners = winners["curve_num"].nunique()
    top_model = winners["model"].value_counts().idxmax()

    print("\nCurves with AIC winner:", n_winners)
    print("Most frequent AIC winner:", top_model)

    # Keep this in the same format you previously reported
    counts = w["evidence_strength"].value_counts()
    print("\nEvidence strength (all winners, runner-up available):")
    print(counts)


if __name__ == "__main__":
    main()