#!/usr/bin/env bash
# =============================================================================
# 03_run_gcta_reml.sh
# Estimate SNP-based heritability using GCTA REML (LMM approach).
# Loops over all simulated phenotype files and records runtime and memory.
#
# Usage:
#   bash scripts/03_run_gcta_reml.sh
#
# Expects:
#   data/grm/ceu_grm.*       GRM files from 02_compute_grm.sh
#   data/simulated/*.phen    Phenotype files from 01_simulate_data.sh
#
# Outputs (written to results/gcta/):
#   <trait>.hsq    GCTA REML heritability estimate
#   <trait>.log    GCTA log
#   gcta_timing.tsv  Runtime and memory per trait
# =============================================================================

set -euo pipefail

GRM_PREFIX="data/grm/ceu_grm"
PHEN_DIR="data/simulated"
OUT_DIR="results/gcta"
TIMING_FILE="${OUT_DIR}/gcta_timing.tsv"

mkdir -p "$OUT_DIR"

echo -e "trait\truntime_s\tpeak_mem_kb" > "$TIMING_FILE"

for phen_file in "${PHEN_DIR}"/*.phen; do
    trait=$(basename "$phen_file" .phen)
    echo "  Running REML for ${trait}..."

    start_time=$(date +%s%N)

    /usr/bin/time -v gcta64 \
        --grm "$GRM_PREFIX" \
        --pheno "$phen_file" \
        --reml \
        --out "${OUT_DIR}/${trait}" \
        2> "${OUT_DIR}/${trait}.time.txt"

    end_time=$(date +%s%N)
    runtime_s=$(( (end_time - start_time) / 1000000000 ))

    peak_mem=$(grep "Maximum resident" "${OUT_DIR}/${trait}.time.txt" | awk '{print $NF}')
    echo -e "${trait}\t${runtime_s}\t${peak_mem}" >> "$TIMING_FILE"
done

echo "Done. GCTA REML results written to ${OUT_DIR}/"
