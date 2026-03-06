#!/usr/bin/env bash
# =============================================================================
# 04_prepare_sumstats.sh
# Convert simulated phenotype files into GWAS summary statistics suitable
# for LDSC, using PLINK to run association tests and munge_sumstats.py to
# format the output.
#
# Usage:
#   bash scripts/04_prepare_sumstats.sh <bfile_prefix>
#
# Arguments:
#   bfile_prefix  Prefix for PLINK binary files (.bed/.bim/.fam) for CEU samples
#
# Expects:
#   data/simulated/*.phen         Phenotype files from 01_simulate_data.sh
#   $LDSC_DIR/munge_sumstats.py   LDSC installation directory (set below)
#
# Outputs (written to data/sumstats/):
#   <trait>.assoc.linear/.logistic   PLINK association results
#   <trait>.sumstats.gz              Munged sumstats for LDSC
# =============================================================================

set -euo pipefail

BFILE=${1:?"Usage: $0 <bfile_prefix>"}

PHEN_DIR="data/simulated"
OUT_DIR="data/sumstats"
LDSC_DIR="tools/ldsc"          # path to cloned ldsc repo
HAPMAP_SNPS="data/ref/w_hm3.snplist"  # HapMap3 SNP list for munging

mkdir -p "$OUT_DIR"

for phen_file in "${PHEN_DIR}"/*.phen; do
    trait=$(basename "$phen_file" .phen)
    echo "  Running GWAS for ${trait}..."

    # Determine if binary or quantitative based on filename prefix
    if [[ "$trait" == bt_* ]]; then
        plink2 \
            --bfile "$BFILE" \
            --pheno "$phen_file" \
            --logistic hide-covar \
            --1 \
            --out "${OUT_DIR}/${trait}" \
            --no-psam-pheno \
            --covar-variance-standardize
    else
        plink2 \
            --bfile "$BFILE" \
            --pheno "$phen_file" \
            --linear hide-covar \
            --out "${OUT_DIR}/${trait}" \
            --no-psam-pheno
    fi
done

echo "Done"
