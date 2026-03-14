# CSE 284 Final Project (Option 2) : LMMs vs LDSC for Heritability Estimation in EUR

This project compares two widely-used methods for estimating SNP-based heritability:

- **GCTA REML (LMM-based):** Uses individual-level genotype data to estimate the proportion of phenotypic variance explained by genome-wide SNPs. A Genetic Relationship Matrix (GRM) is constructed from the genotypes, and REML is used to partition variance into genetic and residual components.

- **LDSC (LD Score Regression):** Uses GWAS summary statistics to estimate heritability by regressing chi-squared statistics on precomputed LD scores. It does not require individual-level data.

We simulate multiple phenotypes with varying heritability (h2) using GCTA and 1000 Genomes EUR genotype data, then compare the two methods on:
1. Heritability estimate accuracy (correlation with true simulated h2)
2. Average runtime per trait

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

### 4. Prepare data (not on github due to size)
**Genotype data source:** 1000 Genomes Project, EUR. Downloaded from the [1000 Genomes FTP](http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/).

Use plink to filter them to only EUR donors. Update paths in GWAS simulation scripts named /path/to/your/100G/chr* to the location of your downloaded reference files. 

**LD scores and weights:** Download from the [LDSC GitHub releases](https://github.com/bulik/ldsc) or the LDSC wiki (files `eur_w_ld_chr.tar.bz2` and `weights_hm3_no_hla.tgz`) https://zenodo.org/records/10515792 . 

Place LD score reference files under `inputs/ldsc/ref` 
```bash
      inputs/ldsc/ref/baselineLD_v2.3
      inputs/ldsc/ref/GRCh38
```      
---

## Pipeline

Run the scripts in order. All scripts are run from the repository root.

### Step 1: Simulate phenotypes 

see scripts/simulation/

Outputs: inputs/gwas_simulation/*/*.phen

### Step 2: Compute GRM
Builds the genetic relationship matrix from EUR genotypes. Required for GCTA REML.

```bash
bash scripts/simulation/01_make_grm.sh
bash scripts/simulation/01_make_grm_locus.sh
```
Output: `inputs/grms/`.

### Step 3: Run GCTA REML (LMM)
Runs REML heritability estimation for all simulated phenotypes. Records runtime. 

```bash
bash scripts/gcta/run_gcta_chr.sh
bash scripts/gcta/run_gcta_loci.sh
```
Output: 'results/gcta'

### Step 4: Prepare sumstats and run LDSC
Runs LDSC heritability estimation on all munged sumstats.

```bash
bash scripts/ldsc/05a_munge_sumstats.sh
```
Output: 'results/ldsc'

### Step 6: Analyze and compare results

see plotting/

---

## Evaluation Criteria

| Metric | Description |
|---|---|
| h2 correlation | Pearson r between GCTA and LDSC heritability estimates across traits |
| Runtime | Average wall-clock time per trait for each method |

---
