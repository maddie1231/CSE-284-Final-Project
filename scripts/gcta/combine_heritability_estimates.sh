#!/usr/bin/env bash

# combine GCTA results into one tsv
# Inputs: GCTA output files for full chr and single loci runs
# Output: results/gcta/heritability_summary.tsv

set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
FULL_DIR="${REPO_DIR}/results/gcta/full_chromosome"
LOCI_DIR="${REPO_DIR}/results/gcta/single_loci"
OUT="${REPO_DIR}/results/gcta/heritability_summary.tsv"

echo -e "trait\th2_full_chr\tse_full_chr\th2_single_loci\tse_single_loci" > "$OUT"

for disease in Anorexia Autism MDD Schizophrenia T1D; do
    full_hsq="${FULL_DIR}/${disease}.hsq"
    loci_hsq="${LOCI_DIR}/${disease}_locus.hsq"

    read h2_full se_full <<< $(awk '$1=="V(G)/Vp" {print $2, $3}' "$full_hsq")
    read h2_loci se_loci <<< $(awk '$1=="V(G)/Vp" {print $2, $3}' "$loci_hsq")

    echo -e "${disease}\t${h2_full}\t${se_full}\t${h2_loci}\t${se_loci}" >> "$OUT"
done

echo "Saved to ${OUT}"
