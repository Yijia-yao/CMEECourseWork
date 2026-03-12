#!/usr/bin/env python3

import math
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

# Paths
base_dir = Path(__file__).resolve().parents[1]
data_dir = base_dir / "Data"
fig_dir = base_dir / "Results" / "Figures"
table_dir = base_dir / "Results" / "Tables"
fig_dir.mkdir(parents=True, exist_ok=True)
table_dir.mkdir(parents=True, exist_ok=True)

# Load prepared data
growth = pd.read_csv(data_dir / "logistic_growth_data_prepared.csv")
curve_summary = pd.read_csv(table_dir / "curve_summary.csv")

# -----------------------------
# Basic cleaning for plotting
# -----------------------------
# Treat tiny floating-point negative times as zero
growth["Time"] = growth["Time"].mask(np.isclose(growth["Time"], 0, atol=1e-10), 0)

# Sort data for cleaner plotting
growth = growth.sort_values(["curve_num", "Time"]).reset_index(drop=True)

# Flag values that can be log-transformed
growth["positive_for_log"] = (growth["Time"] >= 0) & (growth["PopBio"] > 0)

# Summarise problem cases
curve_flags = (
    growth.groupby("curve_num")
    .agg(
        any_negative_popbio=("PopBio", lambda x: (x <= 0).any()),
        min_popbio=("PopBio", "min"),
        n_points=("PopBio", "size"),
        n_positive_for_log=("positive_for_log", "sum"),
    )
    .reset_index()
)

curve_flags.to_csv(table_dir / "curve_plotting_flags.csv", index=False)

print("Saved plotting flags to:", table_dir / "curve_plotting_flags.csv")
print("Curves with at least one non-positive PopBio value:",
      int(curve_flags["any_negative_popbio"].sum()))

# -----------------------------
# Figure 1: all curves overview
# -----------------------------
n_curves = growth["curve_num"].nunique()
ncols = 4
nrows = math.ceil(n_curves / ncols)

fig, axes = plt.subplots(nrows, ncols, figsize=(16, 3.2 * nrows), squeeze=False)
axes = axes.flatten()

for ax, curve_num in zip(axes, sorted(growth["curve_num"].unique())):
    subset = growth[growth["curve_num"] == curve_num]
    ax.plot(subset["Time"], subset["PopBio"], "-", linewidth=1)
    ax.scatter(subset["Time"], subset["PopBio"], s=8)
    ax.set_title(f"Curve {curve_num}", fontsize=8)
    ax.tick_params(labelsize=6)

for ax in axes[n_curves:]:
    ax.axis("off")

fig.supxlabel("Time")
fig.supylabel("Population size / biomass (PopBio)")
fig.suptitle("Overview of all microbial growth curves", y=0.995, fontsize=14)
fig.tight_layout()
fig.savefig(fig_dir / "all_curves_overview.pdf")
plt.close(fig)

print("Saved:", fig_dir / "all_curves_overview.pdf")

# -----------------------------
# Choose representative curves
# -----------------------------
# Pick curves with enough points and decent dynamic range
representative = (
    curve_summary.assign(dynamic_range=curve_summary["pop_max"] - curve_summary["pop_min"])
    .query("n_points >= 15")
    .sort_values(["dynamic_range", "n_points"], ascending=[False, False])
    .head(12)
    .copy()
)

representative.to_csv(table_dir / "representative_curves.csv", index=False)
print("Saved:", table_dir / "representative_curves.csv")

# -----------------------------
# Figure 2: representative curves
# -----------------------------
fig, axes = plt.subplots(3, 4, figsize=(16, 10), squeeze=False)
axes = axes.flatten()

for ax, curve_num in zip(axes, representative["curve_num"]):
    subset = growth[growth["curve_num"] == curve_num]
    species = subset["Species"].iloc[0]
    temp = subset["Temp"].iloc[0]
    medium = subset["Medium"].iloc[0]

    ax.plot(subset["Time"], subset["PopBio"], "-", linewidth=1.2)
    ax.scatter(subset["Time"], subset["PopBio"], s=16)
    ax.set_title(f"Curve {curve_num}\n{species}, {temp}°C, {medium}", fontsize=8)
    ax.tick_params(labelsize=7)

fig.supxlabel("Time")
fig.supylabel("Population size / biomass (PopBio)")
fig.suptitle("Representative microbial growth curves", y=0.98, fontsize=14)
fig.tight_layout()
fig.savefig(fig_dir / "growth_curve_examples.pdf")
plt.close(fig)

print("Saved:", fig_dir / "growth_curve_examples.pdf")

# -----------------------------
# Figure 3: representative curves on log scale
# -----------------------------
rep_for_log = representative["curve_num"].tolist()

fig, axes = plt.subplots(3, 4, figsize=(16, 10), squeeze=False)
axes = axes.flatten()

for ax, curve_num in zip(axes, rep_for_log):
    subset = growth[growth["curve_num"] == curve_num].copy()
    subset = subset[subset["PopBio"] > 0]

    species = growth.loc[growth["curve_num"] == curve_num, "Species"].iloc[0]
    temp = growth.loc[growth["curve_num"] == curve_num, "Temp"].iloc[0]
    medium = growth.loc[growth["curve_num"] == curve_num, "Medium"].iloc[0]

    ax.plot(subset["Time"], np.log(subset["PopBio"]), "-", linewidth=1.2)
    ax.scatter(subset["Time"], np.log(subset["PopBio"]), s=16)
    ax.set_title(f"Curve {curve_num}\n{species}, {temp}°C, {medium}", fontsize=8)
    ax.tick_params(labelsize=7)

fig.supxlabel("Time")
fig.supylabel("log(PopBio)")
fig.suptitle("Representative microbial growth curves on log scale", y=0.98, fontsize=14)
fig.tight_layout()
fig.savefig(fig_dir / "growth_curve_examples_log.pdf")
plt.close(fig)

print("Saved:", fig_dir / "growth_curve_examples_log.pdf")