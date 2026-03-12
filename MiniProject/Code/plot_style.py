#!/usr/bin/env python3
from __future__ import annotations

from pathlib import Path
import matplotlib as mpl
import matplotlib.pyplot as plt

# Consistent, nicer colours (model name -> hex colour)
MODEL_COLORS = {
    "logistic":  "#486c7c",
    "gompertz":  "#c55168",  
    "cubic":     "#7F6B8B", 
    "quadratic": "#d6c667",
}

def apply_style() -> None:
    """Clean, paper-like matplotlib style with consistent typography."""
    mpl.rcParams.update({
        "font.size": 11,
        "axes.titlesize": 12,
        "axes.labelsize": 11,
        "xtick.labelsize": 9,
        "ytick.labelsize": 9,
        "legend.fontsize": 9,
        "axes.linewidth": 1.0,
        "axes.spines.top": False,
        "axes.spines.right": False,
        "axes.grid": True,
        "grid.alpha": 0.25,
        "grid.linewidth": 0.7,
        "figure.dpi": 150,
        "savefig.dpi": 300,
    })

def save_pdf(path: Path) -> None:
    """Save current figure nicely cropped for PDF inclusion."""
    path.parent.mkdir(parents=True, exist_ok=True)
    plt.tight_layout()
    plt.savefig(path, bbox_inches="tight")
    plt.close()

def color_for_model(model: str) -> str:
    """Return consistent colour for a model; fall back to default cycle if missing."""
    return MODEL_COLORS.get(str(model).strip().lower(), "#4C4C4C")