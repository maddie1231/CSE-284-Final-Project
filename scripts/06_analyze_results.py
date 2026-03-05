#!/usr/bin/env python3
"""
06_analyze_results.py
Compare GCTA REML and LDSC heritability estimates across simulated traits.

Computes:
  - Pearson correlation between GCTA and LDSC h2 estimates
  - Average runtime and peak memory per trait for each method
  - Plots: scatter of h2 estimates, h2 by true h2, runtime comparison

Usage:
    python scripts/06_analyze_results.py

Outputs (written to results/):
    results/summary_table.tsv     Per-trait h2 estimates and timing
    results/h2_correlation.png    Scatter plot of GCTA vs LDSC h2
    results/runtime_comparison.png  Bar plot of runtimes
    results/memory_comparison.png   Bar plot of peak memory
"""

import re
import glob
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from scipy import stats


# ---------------------------------------------------------------------------
# Parsing helpers
# ---------------------------------------------------------------------------

def parse_gcta_hsq(hsq_file: str) -> float:
    """Extract h2 estimate from a GCTA .hsq file."""
    with open(hsq_file) as f:
        for line in f:
            if line.startswith("V(G)/Vp"):
                parts = line.split()
                return float(parts[1])
    return float("nan")


def parse_ldsc_log(log_file: str) -> float:
    """Extract h2 estimate from an LDSC .log file."""
    with open(log_file) as f:
        for line in f:
            if "Total Observed scale h2" in line:
                match = re.search(r"h2:\s+([\d.]+)", line)
                if match:
                    return float(match.group(1))
    return float("nan")


def parse_timing(tsv_file: str) -> pd.DataFrame:
    """Load timing TSV produced by 03/05 scripts."""
    return pd.read_csv(tsv_file, sep="\t")


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    gcta_dir = "results/gcta"
    ldsc_dir = "results/ldsc"
    out_dir = "results"

    # Collect GCTA estimates
    gcta_rows = []
    for hsq_file in glob.glob(f"{gcta_dir}/*.hsq"):
        trait = hsq_file.replace(f"{gcta_dir}/", "").replace(".hsq", "")
        h2 = parse_gcta_hsq(hsq_file)
        gcta_rows.append({"trait": trait, "gcta_h2": h2})
    gcta_df = pd.DataFrame(gcta_rows)

    # Collect LDSC estimates
    ldsc_rows = []
    for log_file in glob.glob(f"{ldsc_dir}/*.log"):
        trait = log_file.replace(f"{ldsc_dir}/", "").replace(".log", "")
        h2 = parse_ldsc_log(log_file)
        ldsc_rows.append({"trait": trait, "ldsc_h2": h2})
    ldsc_df = pd.DataFrame(ldsc_rows)

    # Load timing
    gcta_timing = parse_timing(f"{gcta_dir}/gcta_timing.tsv").rename(
        columns={"runtime_s": "gcta_runtime_s", "peak_mem_kb": "gcta_mem_kb"}
    )
    ldsc_timing = parse_timing(f"{ldsc_dir}/ldsc_timing.tsv").rename(
        columns={"runtime_s": "ldsc_runtime_s", "peak_mem_kb": "ldsc_mem_kb"}
    )

    # Merge everything
    df = (
        gcta_df
        .merge(ldsc_df, on="trait", how="inner")
        .merge(gcta_timing, on="trait", how="left")
        .merge(ldsc_timing, on="trait", how="left")
    )

    # Parse true h2 from trait name (e.g. qt_hsq0.5 -> 0.5)
    df["true_h2"] = df["trait"].str.extract(r"hsq([\d.]+)").astype(float)

    df.to_csv(f"{out_dir}/summary_table.tsv", sep="\t", index=False)
    print(df[["trait", "true_h2", "gcta_h2", "ldsc_h2"]].to_string(index=False))

    # --- Correlation ---
    valid = df.dropna(subset=["gcta_h2", "ldsc_h2"])
    r, p = stats.pearsonr(valid["gcta_h2"], valid["ldsc_h2"])
    print(f"\nPearson r (GCTA vs LDSC h2): {r:.4f}  (p={p:.4g})")

    # --- Scatter plot ---
    fig, ax = plt.subplots(figsize=(5, 5))
    ax.scatter(valid["gcta_h2"], valid["ldsc_h2"], alpha=0.6)
    lims = [min(ax.get_xlim()[0], ax.get_ylim()[0]),
            max(ax.get_xlim()[1], ax.get_ylim()[1])]
    ax.plot(lims, lims, "k--", linewidth=0.8, label="y=x")
    ax.set_xlabel("GCTA h2 estimate")
    ax.set_ylabel("LDSC h2 estimate")
    ax.set_title(f"GCTA vs LDSC (r={r:.3f})")
    ax.legend()
    fig.tight_layout()
    fig.savefig(f"{out_dir}/h2_correlation.png", dpi=150)
    print(f"Saved {out_dir}/h2_correlation.png")

    # --- Runtime comparison ---
    avg_runtime = {
        "GCTA": df["gcta_runtime_s"].mean(),
        "LDSC": df["ldsc_runtime_s"].mean(),
    }
    fig, ax = plt.subplots(figsize=(4, 4))
    ax.bar(avg_runtime.keys(), avg_runtime.values())
    ax.set_ylabel("Avg runtime (s)")
    ax.set_title("Average runtime per trait")
    fig.tight_layout()
    fig.savefig(f"{out_dir}/runtime_comparison.png", dpi=150)
    print(f"Saved {out_dir}/runtime_comparison.png")

    # --- Memory comparison ---
    avg_mem = {
        "GCTA": df["gcta_mem_kb"].mean(),
        "LDSC": df["ldsc_mem_kb"].mean(),
    }
    fig, ax = plt.subplots(figsize=(4, 4))
    ax.bar(avg_mem.keys(), np.array(list(avg_mem.values())) / 1024)
    ax.set_ylabel("Avg peak memory (MB)")
    ax.set_title("Average peak memory per trait")
    fig.tight_layout()
    fig.savefig(f"{out_dir}/memory_comparison.png", dpi=150)
    print(f"Saved {out_dir}/memory_comparison.png")


if __name__ == "__main__":
    main()
