#!/usr/bin/env python3

from pathlib import Path
import warnings

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit

warnings.filterwarnings("ignore", category=RuntimeWarning)

# -------------------------
# Paths + I/O
# -------------------------
base_dir = Path(__file__).resolve().parents[1]
data_dir = base_dir / "Data"
table_dir = base_dir / "Results" / "Tables"
fig_dir = base_dir / "Results" / "Figures" / "ModelFits_single"
fig_dir.mkdir(parents=True, exist_ok=True)

growth = pd.read_csv(data_dir / "logistic_growth_data_prepared.csv")
rep = pd.read_csv(table_dir / "representative_curves.csv")

# Choose how many curves to test (start small)
TEST_N = 8
test_curves = rep["curve_num"].head(TEST_N).tolist()

# -------------------------
# Model definitions
# -------------------------
def quad(t, a, b, c):
    return a + b * t + c * t**2

def cubic(t, a, b, c, d):
    return a + b * t + c * t**2 + d * t**3

def logistic(t, K, r, t0):
    # K: carrying capacity, r: growth rate, t0: midpoint time
    return K / (1.0 + np.exp(-r * (t - t0)))

def gompertz(t, K, r, t0):
    # "standard" Gompertz (3-parameter), flexible sigmoid
    # r controls steepness, t0 shift
    return K * np.exp(-np.exp(-r * (t - t0)))

MODELS = {
    "quadratic": (quad, 3),
    "cubic": (cubic, 4),
    "logistic": (logistic, 3),
    "gompertz": (gompertz, 3),
}

# -------------------------
# Helpers: fit + AIC/BIC
# -------------------------
def fit_model(x, y, func, p0, bounds=None):
    if bounds is None:
        popt, pcov = curve_fit(func, x, y, p0=p0, maxfev=20000)
    else:
        popt, pcov = curve_fit(func, x, y, p0=p0, bounds=bounds, maxfev=20000)
    yhat = func(x, *popt)
    resid = y - yhat
    rss = np.sum(resid**2)
    return popt, rss

def aic_bic(rss, n, k):
    # Gaussian errors, constant variance: AIC = n ln(RSS/n) + 2k
    # BIC = n ln(RSS/n) + k ln(n)
    if rss <= 0:
        rss = 1e-12
    aic = n * np.log(rss / n) + 2 * k
    bic = n * np.log(rss / n) + k * np.log(n)
    return aic, bic

def starting_values(x, y):
    # sensible generic starting values for sigmoid models
    y_max = np.nanmax(y)
    y_min = np.nanmin(y)
    K0 = y_max
    t0_0 = x[np.argmax(np.gradient(y))] if len(x) > 3 else np.median(x)
    # crude r0 from mid-section slope
    r0 = 0.01
    return K0, r0, t0_0, y_min

# -------------------------
# Fit loop (minimal example)
# -------------------------
records = []

for curve_num in test_curves:
    df = growth[growth["curve_num"] == curve_num].copy()
    df = df.sort_values("Time")

    # Drop NaNs, keep only non-negative time
    df = df.dropna(subset=["Time", "PopBio"])
    df = df[df["Time"] >= 0]

    # For this minimal example we fit on raw scale.
    # (Log scale fitting comes later once we handle non-positive PopBio robustly.)
    x = df["Time"].to_numpy(dtype=float)
    y = df["PopBio"].to_numpy(dtype=float)

    # If too few points, skip
    if len(np.unique(x)) < 6 or len(y) < 6:
        continue

    # Metadata for plot titles
    species = df["Species"].iloc[0]
    temp = df["Temp"].iloc[0]
    medium = df["Medium"].iloc[0]
    unit = df["PopBio_units"].iloc[0]

    # Prep x grid for smooth fitted lines
    xgrid = np.linspace(x.min(), x.max(), 200)

    # Plot data once, overlay fits
    plt.figure(figsize=(7.2, 4.8))
    plt.scatter(x, y, s=18)
    plt.plot(x, y, linewidth=1, alpha=0.6)

    for name, (func, k) in MODELS.items():
        try:
            # Starting values + bounds
            if name in ["quadratic", "cubic"]:
                # polynomial start values: least squares via np.polyfit
                deg = 2 if name == "quadratic" else 3
                coeffs = np.polyfit(x, y, deg)
                # np.polyfit returns highest power first
                if name == "quadratic":
                    c, b, a = coeffs
                    p0 = [a, b, c]
                else:
                    d, c, b, a = coeffs
                    p0 = [a, b, c, d]
                popt, rss = fit_model(x, y, func, p0=p0, bounds=None)

            else:
                K0, r0, t0_0, y_min = starting_values(x, y)

                # Keep K positive; r positive; t0 within time range
                if name == "logistic":
                    p0 = [max(K0, 1e-6), max(r0, 1e-6), t0_0]
                    bounds = ([0, 0, x.min()], [np.inf, np.inf, x.max()])
                else:  # gompertz
                    p0 = [max(K0, 1e-6), max(r0, 1e-6), t0_0]
                    bounds = ([0, 0, x.min()], [np.inf, np.inf, x.max()])

                popt, rss = fit_model(x, y, func, p0=p0, bounds=bounds)

            n = len(y)
            aic, bic = aic_bic(rss, n=n, k=k)

            # record
            rec = {
                "curve_num": curve_num,
                "model": name,
                "n": n,
                "rss": rss,
                "aic": aic,
                "bic": bic,
                "params": ",".join([f"{v:.6g}" for v in popt]),
                "Species": species,
                "Temp": temp,
                "Medium": medium,
                "PopBio_units": unit,
            }
            records.append(rec)

            # overlay fitted line
            ygrid = func(xgrid, *popt)
            plt.plot(xgrid, ygrid, linewidth=2, label=f"{name} (AIC {aic:.1f})")

        except Exception as e:
            # keep a note of failures
            records.append({
                "curve_num": curve_num,
                "model": name,
                "n": len(y),
                "rss": np.nan,
                "aic": np.nan,
                "bic": np.nan,
                "params": "FAILED",
                "Species": species,
                "Temp": temp,
                "Medium": medium,
                "PopBio_units": unit,
            })
            continue

    plt.xlabel("Time (hours)")
    plt.ylabel(f"PopBio ({unit})")
    plt.title(f"Curve {curve_num}: {species}, {temp}°C, {medium}")
    plt.legend(fontsize=8)
    plt.tight_layout()
    plt.savefig(fig_dir / f"curve_{curve_num}_fits.pdf")
    plt.close()

# Save fit table
fits = pd.DataFrame.from_records(records)
out_csv = table_dir / "single_curve_model_fits.csv"
fits.to_csv(out_csv, index=False)

print("Saved model fits table to:", out_csv)
print("Saved fitted plots to:", fig_dir)
print("Tested curves:", test_curves)
print("Successful fits:", fits["params"].ne("FAILED").sum(), "out of", len(fits))