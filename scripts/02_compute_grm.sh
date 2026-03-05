#!/usr/bin/env bash
# =============================================================================
# 02_compute_grm.sh
# Compute a Genetic Relationship Matrix (GRM) from CEU genotype data using GCTA.
# The GRM is required for LMM-based heritability estimation (REML).
#
# Usage:
#   bash scripts/02_compute_grm.sh <bfile_prefix>
#
# Arguments:
#   bfile_prefix  Prefix for PLINK binary files (.bed/.bim/.fam) for CEU samples
#
# Outputs (written to data/grm/):
#   ceu_grm.grm.bin   Binary GRM
#   ceu_grm.grm.N.bin Number of SNPs used per pair
#   ceu_grm.grm.id    Sample IDs
# =============================================================================

set -euo pipefail

BFILE=${1:?"Usage: $0 <bfile_prefix>"}

OUT_DIR="data/grm"
mkdir -p "$OUT_DIR"

N_THREADS=4

echo "=== Computing GRM for CEU samples ==="
gcta64 \
    --bfile "$BFILE" \
    --make-grm \
    --out "${OUT_DIR}/ceu_grm" \
    --thread-num "$N_THREADS"

echo "Done. GRM written to ${OUT_DIR}/ceu_grm.*"
