#!/usr/bin/env bash
# =============================================================================
# 01_simulate_data.sh
# Simulate GWAS phenotypes from 1000 Genomes CEU genotype data using GCTA.
#
# Usage:
#   bash scripts/01_simulate_data.sh <bfile_prefix>
#
# Arguments:
#   bfile_prefix  Prefix for PLINK binary files (.bed/.bim/.fam) for EUR samples
#
# Outputs (written to data/simulated/):
#   <prefix>_hsq<hsq>_prev<prev>.phen   Simulated phenotype file
#   <prefix>_hsq<hsq>_prev<prev>.log    GCTA simulation log
# =============================================================================

set -euo pipefail

BFILE=${1:?"Usage: $0 <bfile_prefix>"}

OUT_DIR="data/simulated"
mkdir -p "$OUT_DIR"

# Heritability levels to simulate
HSQ_VALUES=(0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8)

# Disease prevalence levels (for binary traits)
PREV_VALUES=(0.01 0.05 0.1 0.2 0.5)

# Number of simulation replicates per parameter combination
N_REP=10

echo "=== Simulating quantitative traits ==="
for hsq in "${HSQ_VALUES[@]}"; do
    out_prefix="${OUT_DIR}/qt_hsq${hsq}"
    echo "  h2=${hsq}"
    gcta64 \
        --bfile "$BFILE" \
        --simu-qt \
        --simu-hsq "$hsq" \
        --simu-rep "$N_REP" \
        --out "$out_prefix"
done

echo "=== Simulating binary traits (case-control) ==="
for hsq in "${HSQ_VALUES[@]}"; do
    for prev in "${PREV_VALUES[@]}"; do
        out_prefix="${OUT_DIR}/bt_hsq${hsq}_prev${prev}"
        echo "  h2=${hsq}, prevalence=${prev}"
        gcta64 \
            --bfile "$BFILE" \
            --simu-cc \
            --simu-hsq "$hsq" \
            --simu-k "$prev" \
            --simu-rep "$N_REP" \
            --out "$out_prefix"
    done
done

echo "Done. Simulated phenotypes written to ${OUT_DIR}/"
