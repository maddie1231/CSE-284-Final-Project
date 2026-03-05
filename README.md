# LMMs vs LDSC for Heritability Estimation in CEU

**CSE 284 Final Project (Option 2)**

| Name | PID |
|---|---|
| Madeleine Pittigher | A69033583 |
| Jeremy Parker Yang | A69033516 |
| Rosan Wang | A69033717 |

---

## Overview

This project compares two widely-used methods for estimating SNP-based heritability:

- **GCTA REML (LMM-based):** Uses individual-level genotype data to estimate the proportion of phenotypic variance explained by genome-wide SNPs. A Genetic Relationship Matrix (GRM) is constructed from the genotypes, and REML is used to partition variance into genetic and residual components.

- **LDSC (LD Score Regression):** Uses GWAS summary statistics to estimate heritability by regressing chi-squared statistics on precomputed LD scores. It does not require individual-level data.

We simulate multiple phenotypes with varying heritability (h2) and disease prevalence using GCTA and 1000 Genomes CEU genotype data, then compare the two methods on:
1. Heritability estimate accuracy (correlation with true simulated h2)
2. Average runtime per trait
3. Average peak memory usage per trait

---

## Repository Structure

```
CSE-284-Final-Project/
├── README.md
├── environment.yml              # Conda environment specification
├── scripts/
│   ├── 01_simulate_data.sh     # Simulate phenotypes with GCTA (varying h2, prevalence)
│   ├── 02_compute_grm.sh       # Compute Genetic Relationship Matrix with GCTA
│   ├── 03_run_gcta_reml.sh     # Run GCTA REML heritability estimation (LMM)
│   ├── 04_prepare_sumstats.sh  # Run GWAS with PLINK and munge sumstats for LDSC
│   ├── 05_run_ldsc.sh          # Run LDSC heritability estimation
│   └── 06_analyze_results.py   # Compare estimates, compute correlation, plot figures
├── results/
│   ├── gcta/                   # GCTA REML outputs (.hsq files, timing)
│   └── ldsc/                   # LDSC outputs (.log files, timing)
└── data/                       # Not tracked in git (see Data section below)
```

---

## Data

The `data/` directory is not committed to this repository due to file size. Below is the expected layout:

```
data/
├── genotypes/
│   └── ceu/
│       ├── ceu_1000g.bed       # 1000 Genomes CEU genotypes (PLINK binary format)
│       ├── ceu_1000g.bim       # SNP information
│       └── ceu_1000g.fam       # Sample information
├── grm/
│   ├── ceu_grm.grm.bin         # Binary GRM (produced by script 02)
│   ├── ceu_grm.grm.N.bin       # Number of SNPs per pair
│   └── ceu_grm.grm.id          # Sample IDs
├── simulated/
│   ├── qt_hsq0.1.phen          # Quantitative trait, h2=0.1 (10 replicates each)
│   ├── qt_hsq0.5.phen          # ...
│   ├── bt_hsq0.3_prev0.05.phen # Binary trait, h2=0.3, prevalence=5%
│   └── ...
├── sumstats/
│   ├── qt_hsq0.1.sumstats.gz   # Munged GWAS sumstats for LDSC
│   └── ...
└── ref/
    ├── w_hm3.snplist            # HapMap3 SNP list for munge_sumstats.py
    ├── ld_scores/
    │   └── eur_w_ld_chr/        # Precomputed 1000G EUR LD scores (from LDSC repo)
    └── weights/
        └── weights.hm3_noMHC.*  # LD score regression weights
```

**Genotype data source:** 1000 Genomes Project, CEU (Utah residents with Northern/Western European ancestry). Download from the [1000 Genomes FTP](http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/) and convert to PLINK format, keeping only CEU samples.

**LD scores and weights:** Download from the [LDSC GitHub releases](https://github.com/bulik/ldsc) or the LDSC wiki (files `eur_w_ld_chr.tar.bz2` and `weights_hm3_no_hla.tgz`).

---

## Setup

### 1. Clone this repository

```bash
git clone <repo-url>
cd CSE-284-Final-Project
```

### 2. Create the conda environment

```bash
conda env create -f environment.yml
conda activate cse284-heritability
```

> **Note:** `gcta` and `plink2` are available via bioconda. If `gcta` is not available in your conda channel, download the binary directly from the [GCTA website](https://yanglab.westlake.edu.cn/software/gcta/) and place it on your PATH.

### 3. Install LDSC

LDSC is not on conda. Clone it into `tools/ldsc/`:

```bash
mkdir -p tools
git clone https://github.com/bulik/ldsc.git tools/ldsc
```

### 4. Prepare data

Place the CEU PLINK binary files under `data/genotypes/ceu/` and the LD score reference files under `data/ref/` as described in the Data section above.

---

## Pipeline

Run the scripts in order. All scripts are run from the repository root.

### Step 1: Simulate phenotypes

```bash
bash scripts/01_simulate_data.sh data/genotypes/ceu/ceu_1000g
```

Simulates quantitative and binary traits across a grid of heritability values (0.1–0.8) and prevalence values (0.01–0.5), with 10 replicates each. Outputs `.phen` files to `data/simulated/`.

### Step 2: Compute GRM

```bash
bash scripts/02_compute_grm.sh data/genotypes/ceu/ceu_1000g
```

Builds the genetic relationship matrix from CEU genotypes. Required for GCTA REML. Output goes to `data/grm/`.

### Step 3: Run GCTA REML (LMM)

```bash
bash scripts/03_run_gcta_reml.sh
```

Runs REML heritability estimation for all simulated phenotypes. Records runtime and peak memory. Outputs `.hsq` files and `gcta_timing.tsv` to `results/gcta/`.

### Step 4: Prepare sumstats for LDSC

```bash
bash scripts/04_prepare_sumstats.sh data/genotypes/ceu/ceu_1000g
```

Runs PLINK GWAS (linear/logistic) on each simulated phenotype, then runs `munge_sumstats.py` to produce LDSC-ready `.sumstats.gz` files in `data/sumstats/`.

### Step 5: Run LDSC

```bash
bash scripts/05_run_ldsc.sh
```

Runs LDSC heritability estimation on all munged sumstats. Records runtime and peak memory. Outputs `.log` files and `ldsc_timing.tsv` to `results/ldsc/`.

### Step 6: Analyze and compare results

```bash
python scripts/06_analyze_results.py
```

Parses all GCTA and LDSC outputs, computes Pearson correlation between h2 estimates, and produces:
- `results/summary_table.tsv` — per-trait h2 estimates and timing
- `results/h2_correlation.png` — scatter plot of GCTA vs LDSC h2
- `results/runtime_comparison.png` — average runtime per method
- `results/memory_comparison.png` — average peak memory per method

---

## Evaluation Criteria

| Metric | Description |
|---|---|
| h2 correlation | Pearson r between GCTA and LDSC heritability estimates across traits |
| Runtime | Average wall-clock time per trait for each method |
| Memory | Average peak resident memory per trait for each method |

---

## Methods Summary

### GCTA REML

GCTA fits a linear mixed model where the phenotype is modeled as:

```
y = Xb + g + e
```

where `g ~ N(0, A * sigma_g^2)` is the polygenic effect captured by the GRM `A`, and `e` is the residual. REML estimates `sigma_g^2` and `sigma_e^2`, giving h2 = sigma_g^2 / (sigma_g^2 + sigma_e^2). This requires individual-level genotype data.

### LDSC

LDSC exploits the relationship between per-SNP LD scores and GWAS chi-squared statistics:

```
E[chi^2_j] = N * h2 * l_j / M + 1
```

where `l_j` is the LD score for SNP j, N is the sample size, and M is the number of SNPs. Heritability is estimated by regressing chi-squared statistics on LD scores. Only GWAS summary statistics are needed.

---

## References

- Yang, J. et al. (2011). GCTA: A tool for genome-wide complex trait analysis. *AJHG*, 88(1), 76–82.
- Bulik-Sullivan, B.K. et al. (2015). LD Score regression distinguishes confounding from polygenicity in genome-wide association studies. *Nature Genetics*, 47, 291–295.
- 1000 Genomes Project Consortium (2015). A global reference for human genetic variation. *Nature*, 526, 68–74.
