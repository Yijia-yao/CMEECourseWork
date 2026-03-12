#!/usr/bin/env python3

from pathlib import Path
import warnings

import numpy as np
import pandas as pd
from scipy.optimize import curve_fit

warnings.filterwarnings("ignore", category=RuntimeWarning)

# Paths
base_dir = Path(__file__).resolve().parents[1]
data_dir = base_dir / "Data"
table_dir = base_dir / "Results" / "Tables"
table_dir.mkdir(parents=True, exist_ok=True)

growth = pd.read_csv(data_dir / "logistic_growth_data_prepared.csv")
curve_summary = pd.read_csv(table_dir / "curve_summary.csv")

# Models
def quad(t, a, b, c):
    return a + b * t + c * t**2

def cubic(t, a, b, c, d):
    return a + b * t + c * t**2 + d * t**3

def logistic(t, K, r, t0):
    return K / (1.0 + np.exp(-r * (t - t0)))

def gompertz(t, K, r, t0):
    return K * np.exp(-np.exp(-r * (t - t0)))

MODELS = {
    "quadratic": (quad, 3),
    "cubic": (cubic, 4),
    "logistic": (logistic, 3),
    "gompertz": (gompertz, 3),
}

def aic_bic(rss, n, k):
    if rss <= 0 or np.isnan(rss):
        return np.nan, np.nan
    aic = n * np.log(rss / n) + 2 * k
    bic = n * np.log(rss / n) + k * np.log(n)
    return aic, bic

def fit_model(x, y, func, p0, bounds=None):
    if bounds is None:
        popt, _ = curve_fit(func, x, y, p0=p0, maxfev=30000)
    else:
        popt, _ = curve_fit(func, x, y, p0=p0, bounds=bounds, maxfev=30000)
    yhat = func(x, *popt)
    rss = np.sum((y - yhat) ** 2)
    return popt, rss

def starting_values(x, y):
    y_max = float(np.nanmax(y))
    t0_0 = float(x[np.argmax(np.gradient(y))]) if len(x) > 3 else float(np.median(x))
    r0 = 0.01
    return max(y_max, 1e-6), max(r0, 1e-6), t0_0

# Fit all curves
records = []
curve_nums = sorted(growth["curve_num"].unique())

for curve_num in curve_nums:
    df = growth[growth["curve_num"] == curve_num].copy()
    df = df.dropna(subset=["Time", "PopBio"])
    df = df[df["Time"] >= 0].sort_values("Time")

    x = df["Time"].to_numpy(float)
    y = df["PopBio"].to_numpy(float)

    # Basic eligibility checks
    n = len(y)
    n_unique_x = len(np.unique(x))

    # metadata (safe even if skipped)
    species = df["Species"].iloc[0]
    temp = df["Temp"].iloc[0]
    medium = df["Medium"].iloc[0]
    unit = df["PopBio_units"].iloc[0]

    # dynamic range (for sigmoid stability)
    dyn = float(np.nanmax(y) - np.nanmin(y))

    for name, (func, k) in MODELS.items():
        # parameter identifiability check
        if n_unique_x < (k + 1) or n < (k + 2):
            records.append({
                "curve_num": curve_num, "model": name,
                "n": n, "n_unique_time": n_unique_x, "dynamic_range": dyn,
                "rss": np.nan, "aic": np.nan, "bic": np.nan,
                "params": "SKIPPED_insufficient_points",
                "Species": species, "Temp": temp, "Medium": medium, "PopBio_units": unit
            })
            continue

        # extra guard for sigmoid: skip near-flat curves
        if name in ["logistic", "gompertz"] and dyn < 1e-6:
            records.append({
                "curve_num": curve_num, "model": name,
                "n": n, "n_unique_time": n_unique_x, "dynamic_range": dyn,
                "rss": np.nan, "aic": np.nan, "bic": np.nan,
                "params": "SKIPPED_flat_curve",
                "Species": species, "Temp": temp, "Medium": medium, "PopBio_units": unit
            })
            continue

        try:
            if name in ["quadratic", "cubic"]:
                deg = 2 if name == "quadratic" else 3
                coeffs = np.polyfit(x, y, deg)
                if name == "quadratic":
                    c, b, a = coeffs
                    p0 = [a, b, c]
                    bounds = None
                else:
                    d, c, b, a = coeffs
                    p0 = [a, b, c, d]
                    bounds = None
            else:
                K0, r0, t0_0 = starting_values(x, y)
                p0 = [K0, r0, t0_0]
                bounds = ([0, 0, x.min()], [np.inf, np.inf, x.max()])

            popt, rss = fit_model(x, y, func, p0=p0, bounds=bounds)
            aic, bic = aic_bic(rss, n=n, k=k)

            records.append({
                "curve_num": curve_num, "model": name,
                "n": n, "n_unique_time": n_unique_x, "dynamic_range": dyn,
                "rss": rss, "aic": aic, "bic": bic,
                "params": ",".join([f"{v:.6g}" for v in popt]),
                "Species": species, "Temp": temp, "Medium": medium, "PopBio_units": unit
            })

        except Exception as e:
            records.append({
                "curve_num": curve_num, "model": name,
                "n": n, "n_unique_time": n_unique_x, "dynamic_range": dyn,
                "rss": np.nan, "aic": np.nan, "bic": np.nan,
                "params": f"FAILED_{type(e).__name__}",
                "Species": species, "Temp": temp, "Medium": medium, "PopBio_units": unit
            })

fits_all = pd.DataFrame.from_records(records)
out_csv = table_dir / "all_curve_model_fits.csv"
fits_all.to_csv(out_csv, index=False)

print("Saved:", out_csv)
print("Total fit attempts:", len(fits_all))
print("Successful fits:", fits_all["params"].str.startswith(("FAILED", "SKIPPED")).eq(False).sum())
print("Failures:", fits_all["params"].str.startswith("FAILED").sum())
print("Skipped:", fits_all["params"].str.startswith("SKIPPED").sum())