import pandas as pd
import matplotlib.pyplot as plt

input_tsv = "results/gcta/heritability_summary.tsv"
output_full_chr_png = "results/gcta/heritability_full_chr.png"
output_single_loci_png = "results/gcta/heritability_single_loci.png"

# gt heritability
gt_h2 = {
    "MDD": 0.4,
    "T1D": 0.5,
    "Anorexia": 0.6,
    "Schizophrenia": 0.75,
    "Autism": 0.8,
}

# load data
df = pd.read_csv(input_tsv, sep="\t")
df["h2_gt"] = df["trait"].map(gt_h2)

# plot full chromosome
r_chr = df["h2_gt"].corr(df["h2_full_chr"])
fig, ax = plt.subplots(figsize=(5, 5))

ax.errorbar(
    df["h2_gt"],
    df["h2_full_chr"],
    yerr=df["se_full_chr"],
    fmt="o",
)

# identity line
x_min = min(df["h2_gt"].min(), df["h2_full_chr"].min())
x_max = max(df["h2_gt"].max(), df["h2_full_chr"].max())
ax.plot([x_min, x_max], [x_min, x_max], linestyle="--")

ax.set_xlabel("Ground Truth h2")
ax.set_ylabel("Estimated h2")
ax.set_title(f"Full Chromosome (R={r_chr:.2f})")
ax.set_aspect("equal", adjustable="box")

plt.tight_layout()
plt.savefig(output_full_chr_png, dpi=300)
plt.close()

# plot single loci
r_loci = df["h2_gt"].corr(df["h2_single_loci"])
fig, ax = plt.subplots(figsize=(5, 5))

ax.errorbar(
    df["h2_gt"],
    df["h2_single_loci"],
    yerr=df["se_single_loci"],
    fmt="o",
)

ax.plot([0, 1], [0, 1], linestyle="--")
ax.set_xlim(0, 1)
ax.set_ylim(0, 1)

ax.set_xlabel("Ground Truth h2")
ax.set_ylabel("Estimated h2")
ax.set_title(f"Single Loci (R={r_loci:.2f})")
ax.set_aspect("equal", adjustable="box")

plt.tight_layout()
plt.savefig(output_single_loci_png, dpi=300)
plt.close()
