#!/usr/bin/env python3

import pandas as pd
from pathlib import Path

# Paths
base_dir = Path(__file__).resolve().parents[1]
data_dir = base_dir / "Data"
results_dir = base_dir / "Results" / "Tables"
results_dir.mkdir(parents=True, exist_ok=True)

# Load data
growth = pd.read_csv(data_dir / "logistic_growth_data.csv")
meta = pd.read_csv(data_dir / "logistic_growth_meta_data.csv")

# Basic checks
print("Growth data shape:", growth.shape)
print("Columns:", growth.columns.tolist())
print("\nMissing values per column:")
print(growth.isna().sum())

# Create unique curve ID
growth["curve_id"] = (
    growth["Species"].astype(str) + "_" +
    growth["Temp"].astype(str) + "_" +
    growth["Medium"].astype(str) + "_" +
    growth["Citation"].astype(str) + "_" +
    growth["Rep"].astype(str)
)

# Create shorter numeric ID for convenience
curve_lookup = (
    growth[["curve_id"]]
    .drop_duplicates()
    .reset_index(drop=True)
    .reset_index(names="curve_num")
)
curve_lookup["curve_num"] = curve_lookup["curve_num"] + 1

growth = growth.merge(curve_lookup, on="curve_id", how="left")

# Summarise each curve
curve_summary = (
    growth.groupby(["curve_num", "curve_id", "Species", "Temp", "Medium", "Rep", "PopBio_units"])
    .agg(
        n_points=("Time", "size"),
        time_min=("Time", "min"),
        time_max=("Time", "max"),
        pop_min=("PopBio", "min"),
        pop_max=("PopBio", "max")
    )
    .reset_index()
    .sort_values("curve_num")
)

print("\nNumber of unique curves:", curve_summary.shape[0])
print("\nFirst few curve summaries:")
print(curve_summary.head())

# Save outputs
growth.to_csv(data_dir / "logistic_growth_data_prepared.csv", index=False)
curve_lookup.to_csv(results_dir / "curve_lookup.csv", index=False)
curve_summary.to_csv(results_dir / "curve_summary.csv", index=False)

print("\nSaved:")
print("-", data_dir / "logistic_growth_data_prepared.csv")
print("-", results_dir / "curve_lookup.csv")
print("-", results_dir / "curve_summary.csv")